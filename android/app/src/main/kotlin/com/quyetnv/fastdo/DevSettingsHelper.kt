package com.quyetnv.fastdo

import android.Manifest
import android.app.PendingIntent
import android.app.StatusBarManager
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.graphics.drawable.Icon
import android.net.Uri
import android.os.Build
import android.provider.Settings
import android.service.quicksettings.TileService
import java.io.File
import java.util.concurrent.Executors

object DevSettingsHelper {

    fun hasWriteSecureSettingsPermission(context: Context): Boolean {
        return context.checkCallingOrSelfPermission(Manifest.permission.WRITE_SECURE_SETTINGS) == PackageManager.PERMISSION_GRANTED
    }

    fun isDevOptionsEnabled(context: Context): Boolean {
        return try {
            Settings.Global.getInt(
                context.contentResolver,
                Settings.Global.DEVELOPMENT_SETTINGS_ENABLED,
                0
            ) != 0
        } catch (e: Exception) {
            false
        }
    }

    fun isUsbDebuggingEnabled(context: Context): Boolean {
        return try {
            Settings.Global.getInt(
                context.contentResolver,
                Settings.Global.ADB_ENABLED,
                0
            ) != 0
        } catch (e: Exception) {
            false
        }
    }

    fun setDevOptionsEnabled(context: Context, enabled: Boolean): Boolean {
        if (!hasWriteSecureSettingsPermission(context)) {
            return false
        }

        val previousDevOptions = isDevOptionsEnabled(context)
        val previousUsbDebugging = isUsbDebuggingEnabled(context)

        return try {
            // Disable ADB first when turning everything off; enable it only after
            // Developer Options succeeds. This minimizes partially-applied states.
            val firstSetting = if (enabled) {
                Settings.Global.DEVELOPMENT_SETTINGS_ENABLED
            } else {
                Settings.Global.ADB_ENABLED
            }
            val secondSetting = if (enabled) {
                Settings.Global.ADB_ENABLED
            } else {
                Settings.Global.DEVELOPMENT_SETTINGS_ENABLED
            }

            if (!writeGlobalSetting(context, firstSetting, enabled)) return false
            if (!writeGlobalSetting(context, secondSetting, enabled)) {
                writeGlobalSetting(context, Settings.Global.DEVELOPMENT_SETTINGS_ENABLED, previousDevOptions)
                writeGlobalSetting(context, Settings.Global.ADB_ENABLED, previousUsbDebugging)
                return false
            }

            // Notify TileService to refresh its visual state immediately
            updateTileState(context)
            true
        } catch (e: Exception) {
            e.printStackTrace()
            writeGlobalSetting(context, Settings.Global.DEVELOPMENT_SETTINGS_ENABLED, previousDevOptions)
            writeGlobalSetting(context, Settings.Global.ADB_ENABLED, previousUsbDebugging)
            false
        }
    }

    private fun writeGlobalSetting(context: Context, key: String, enabled: Boolean): Boolean {
        return Settings.Global.putInt(
            context.contentResolver,
            key,
            if (enabled) 1 else 0
        )
    }

    fun updateTileState(context: Context) {
        try {
            val component = ComponentName(context, FastDoTileService::class.java)
            TileService.requestListeningState(context, component)
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    fun openDevSettings(context: Context) {
        try {
            val intent = Intent(Settings.ACTION_APPLICATION_DEVELOPMENT_SETTINGS).apply {
                flags = Intent.FLAG_ACTIVITY_NEW_TASK
            }
            context.startActivity(intent)
        } catch (e: Exception) {
            try {
                val intent = Intent(Settings.ACTION_SETTINGS).apply {
                    flags = Intent.FLAG_ACTIVITY_NEW_TASK
                }
                context.startActivity(intent)
            } catch (_: Exception) {}
        }
    }

    fun openAppSettings(context: Context) {
        try {
            val intent = Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS).apply {
                data = Uri.fromParts("package", context.packageName, null)
                flags = Intent.FLAG_ACTIVITY_NEW_TASK
            }
            context.startActivity(intent)
        } catch (e: Exception) {}
    }

    fun isRootAvailable(): Boolean {
        val paths = arrayOf(
            "/system/app/Superuser.apk",
            "/sbin/su",
            "/system/bin/su",
            "/system/xbin/su",
            "/data/local/xbin/su",
            "/data/local/bin/su",
            "/system/sd/xbin/su",
            "/system/bin/failsafe/su",
            "/data/local/su"
        )
        for (path in paths) {
            if (File(path).exists()) return true
        }
        return try {
            val process = Runtime.getRuntime().exec(arrayOf("which", "su"))
            val exitCode = process.waitFor()
            exitCode == 0
        } catch (e: Exception) {
            false
        }
    }

    fun grantPermissionViaRoot(context: Context, callback: (Boolean) -> Unit) {
        Executors.newSingleThreadExecutor().execute {
            var success = false
            try {
                val pkgName = context.packageName
                val process = Runtime.getRuntime().exec(arrayOf("su", "-c", "pm grant $pkgName android.permission.WRITE_SECURE_SETTINGS"))
                val exitCode = process.waitFor()
                success = (exitCode == 0) && hasWriteSecureSettingsPermission(context)
            } catch (e: Exception) {
                e.printStackTrace()
                success = false
            }
            callback(success)
        }
    }

    fun requestAddTile(context: Context): Boolean {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            val statusBarManager = context.getSystemService(StatusBarManager::class.java)
            if (statusBarManager != null) {
                val component = ComponentName(context, FastDoTileService::class.java)
                val icon = Icon.createWithResource(context, R.drawable.ic_tile_dev)
                val executor = Executors.newSingleThreadExecutor()
                statusBarManager.requestAddTileService(
                    component,
                    context.getString(R.string.tile_label),
                    icon,
                    executor
                ) { statusCode ->
                    // Tile request result
                }
                return true
            }
        }
        return false
    }
}
