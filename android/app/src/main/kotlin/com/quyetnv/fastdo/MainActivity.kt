package com.quyetnv.fastdo

import android.content.Intent
import android.database.ContentObserver
import android.net.Uri
import android.os.Handler
import android.os.Looper
import android.provider.Settings
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val METHOD_CHANNEL = "com.quyetnv.fastdo/channel"
    private val EVENT_CHANNEL = "com.quyetnv.fastdo/events"

    private var eventSink: EventChannel.EventSink? = null
    private var settingsObserver: ContentObserver? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // MethodChannel handling
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, METHOD_CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "checkPermission" -> {
                    result.success(DevSettingsHelper.hasWriteSecureSettingsPermission(this))
                }
                "isDevOptionsEnabled" -> {
                    result.success(DevSettingsHelper.isDevOptionsEnabled(this))
                }
                "setDevOptionsEnabled" -> {
                    val enabled = call.argument<Boolean>("enabled") ?: false
                    val success = DevSettingsHelper.setDevOptionsEnabled(this, enabled)
                    notifySettingsChanged()
                    result.success(success)
                }
                "isUsbDebuggingEnabled" -> {
                    result.success(DevSettingsHelper.isUsbDebuggingEnabled(this))
                }
                "isWifiDebuggingEnabled" -> {
                    result.success(DevSettingsHelper.isWifiDebuggingEnabled(this))
                }
                "setWifiDebuggingEnabled" -> {
                    val enabled = call.argument<Boolean>("enabled") ?: false
                    val success = DevSettingsHelper.setWifiDebuggingEnabled(this, enabled)
                    notifySettingsChanged()
                    if (enabled) {
                        DevSettingsHelper.getAdbWifiPort(this) {
                            notifySettingsChanged()
                        }
                    }
                    result.success(success)
                }
                "getWifiIpAddress" -> {
                    result.success(DevSettingsHelper.getWifiIpAddress(this))
                }
                "getWifiPort" -> {
                    result.success(DevSettingsHelper.getAdbWifiPort(this) {
                        notifySettingsChanged()
                    })
                }
                "openDevSettings" -> {
                    DevSettingsHelper.openDevSettings(this)
                    result.success(true)
                }
                "openWirelessDebuggingSettings" -> {
                    DevSettingsHelper.openWirelessDebuggingSettings(this)
                    result.success(true)
                }
                "openAppSettings" -> {
                    DevSettingsHelper.openAppSettings(this)
                    result.success(true)
                }
                "requestAddTile" -> {
                    val res = DevSettingsHelper.requestAddTile(this)
                    result.success(res)
                }
                "requestAddWifiTile" -> {
                    val res = DevSettingsHelper.requestAddWifiTile(this)
                    result.success(res)
                }
                "isRootAvailable" -> {
                    result.success(DevSettingsHelper.isRootAvailable())
                }
                "grantRootPermission" -> {
                    DevSettingsHelper.grantPermissionViaRoot(this) { success ->
                        Handler(Looper.getMainLooper()).post {
                            notifySettingsChanged()
                            result.success(success)
                        }
                    }
                }
                "openUrl" -> {
                    val url = call.argument<String>("url")
                    if (url != null) {
                        try {
                            val intent = Intent(Intent.ACTION_VIEW, Uri.parse(url)).apply {
                                flags = Intent.FLAG_ACTIVITY_NEW_TASK
                            }
                            startActivity(intent)
                            result.success(true)
                        } catch (e: Exception) {
                            result.error("URL_ERROR", e.message, null)
                        }
                    } else {
                        result.error("INVALID_URL", "URL cannot be null", null)
                    }
                }
                else -> {
                    result.notImplemented()
                }
            }
        }

        // EventChannel handling
        EventChannel(flutterEngine.dartExecutor.binaryMessenger, EVENT_CHANNEL).setStreamHandler(object : EventChannel.StreamHandler {
            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                eventSink = events
                registerSettingsObserver()
                notifySettingsChanged()
                if (DevSettingsHelper.isWifiDebuggingEnabled(this@MainActivity)) {
                    DevSettingsHelper.getAdbWifiPort(this@MainActivity) {
                        notifySettingsChanged()
                    }
                }
            }

            override fun onCancel(arguments: Any?) {
                unregisterSettingsObserver()
                eventSink = null
            }
        })
    }

    private fun registerSettingsObserver() {
        if (settingsObserver != null) return

        val handler = Handler(Looper.getMainLooper())
        settingsObserver = object : ContentObserver(handler) {
            override fun onChange(selfChange: Boolean) {
                super.onChange(selfChange)
                notifySettingsChanged()
                if (DevSettingsHelper.isWifiDebuggingEnabled(this@MainActivity)) {
                    DevSettingsHelper.getAdbWifiPort(this@MainActivity) {
                        notifySettingsChanged()
                    }
                }
            }
        }

        try {
            contentResolver.registerContentObserver(
                Settings.Global.getUriFor(Settings.Global.DEVELOPMENT_SETTINGS_ENABLED),
                false,
                settingsObserver!!
            )
            contentResolver.registerContentObserver(
                Settings.Global.getUriFor(Settings.Global.ADB_ENABLED),
                false,
                settingsObserver!!
            )
            contentResolver.registerContentObserver(
                Settings.Global.getUriFor("adb_wifi_enabled"),
                false,
                settingsObserver!!
            )
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    private fun unregisterSettingsObserver() {
        settingsObserver?.let {
            try {
                contentResolver.unregisterContentObserver(it)
            } catch (e: Exception) {
                e.printStackTrace()
            }
        }
        settingsObserver = null
    }

    private fun notifySettingsChanged() {
        Handler(Looper.getMainLooper()).post {
            val hasPerm = DevSettingsHelper.hasWriteSecureSettingsPermission(this)
            val isDevOn = DevSettingsHelper.isDevOptionsEnabled(this)
            val isAdbOn = DevSettingsHelper.isUsbDebuggingEnabled(this)
            val isWifiAdbOn = DevSettingsHelper.isWifiDebuggingEnabled(this)
            val ipAddress = DevSettingsHelper.getWifiIpAddress(this)
            val port = DevSettingsHelper.getAdbWifiPort(this)

            // Also notify TileServices
            DevSettingsHelper.updateTileState(this)

            eventSink?.success(mapOf(
                "hasPermission" to hasPerm,
                "isDevOptionsEnabled" to isDevOn,
                "isUsbDebuggingEnabled" to isAdbOn,
                "isWifiDebuggingEnabled" to isWifiAdbOn,
                "wifiIpAddress" to ipAddress,
                "wifiPort" to port
            ))
        }
    }

    override fun onResume() {
        super.onResume()
        notifySettingsChanged()
        if (DevSettingsHelper.isWifiDebuggingEnabled(this)) {
            DevSettingsHelper.getAdbWifiPort(this) {
                notifySettingsChanged()
            }
        }
    }

    override fun onDestroy() {
        unregisterSettingsObserver()
        super.onDestroy()
    }
}
