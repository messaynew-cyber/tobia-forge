package com.tobia.forge

import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Bundle
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
        val tempRaw = bm.getIntProperty(BatteryManager.BATTERY_PROPERTY_TEMPERATURE)
        val tempC = tempRaw / 10.0
        val status = bm.getIntProperty(BatteryManager.BATTERY_PROPERTY_STATUS)

        val health = when (tempC) {
            in Double.MIN_VALUE..35.0 -> "GOOD"
            in 35.0..40.0 -> "WARM"
            in 40.0..43.0 -> "HOT"
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
