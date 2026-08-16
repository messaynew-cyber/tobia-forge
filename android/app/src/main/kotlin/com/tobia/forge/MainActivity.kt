package com.tobia.forge

import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "tobia_forge/hardware"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "deviceStats" -> result.success(readDeviceStats())
                else -> result.notImplemented()
            }
        }
    }

    private fun readDeviceStats(): Map<String, Any> {
        val bm = getSystemService(BATTERY_SERVICE) as BatteryManager
        val battery = bm.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        // Temperature isn't a public BATTERY_PROPERTY_* constant; read it from the sticky battery intent.
        val sticky = registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
        var tempC = 0.0
        if (sticky != null) {
            val temp = sticky.getIntExtra(BatteryManager.EXTRA_TEMPERATURE, 0)
            tempC = temp / 10.0
        }
        val status = bm.getIntProperty(BatteryManager.BATTERY_PROPERTY_STATUS)

        val health = when {
            tempC <= 35.0 -> "GOOD"
            tempC <= 40.0 -> "WARM"
            tempC <= 43.0 -> "HOT"
            else -> "CRITICAL"
        }
        val charge = when (status) {
            BatteryManager.BATTERY_STATUS_CHARGING -> "CHARGING"
            BatteryManager.BATTERY_STATUS_FULL -> "FULL"
            else -> "UNPLUGGED"
        }
        return mapOf(
            "battery" to battery,
            "temp" to tempC,
            "health" to health,
            "charge" to charge
        )
    }
}
