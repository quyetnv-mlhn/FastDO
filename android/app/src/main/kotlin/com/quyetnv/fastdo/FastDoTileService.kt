package com.quyetnv.fastdo

import android.app.PendingIntent
import android.content.Intent
import android.os.Build
import android.service.quicksettings.Tile
import android.service.quicksettings.TileService

class FastDoTileService : TileService() {

    override fun onStartListening() {
        super.onStartListening()
        updateTileState()
    }

    override fun onClick() {
        super.onClick()
        val hasPermission = DevSettingsHelper.hasWriteSecureSettingsPermission(this)

        if (!hasPermission) {
            // Open main activity to explain permission setup
            val intent = Intent(this, MainActivity::class.java).apply {
                flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP
                putExtra("show_permission_dialog", true)
            }
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.UPSIDE_DOWN_CAKE) { // Android 14+ (API 34)
                val pendingIntent = PendingIntent.getActivity(
                    this,
                    0,
                    intent,
                    PendingIntent.FLAG_IMMUTABLE or PendingIntent.FLAG_UPDATE_CURRENT
                )
                startActivityAndCollapse(pendingIntent)
            } else {
                @Suppress("DEPRECATION")
                startActivityAndCollapse(intent)
            }
            return
        }

        val currentState = DevSettingsHelper.isDevOptionsEnabled(this)
        val newState = !currentState
        DevSettingsHelper.setDevOptionsEnabled(this, newState)
        updateTileState()
    }

    private fun updateTileState() {
        val tile = qsTile ?: return
        val hasPermission = DevSettingsHelper.hasWriteSecureSettingsPermission(this)

        if (!hasPermission) {
            tile.state = Tile.STATE_INACTIVE
            tile.label = getString(R.string.tile_label)
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                tile.subtitle = getString(R.string.tile_subtitle_no_perm)
            }
        } else {
            val isEnabled = DevSettingsHelper.isDevOptionsEnabled(this)
            tile.state = if (isEnabled) Tile.STATE_ACTIVE else Tile.STATE_INACTIVE
            tile.label = getString(R.string.tile_label)
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                tile.subtitle = if (isEnabled) getString(R.string.tile_subtitle_on) else getString(R.string.tile_subtitle_off)
            }
        }

        tile.updateTile()
    }
}
