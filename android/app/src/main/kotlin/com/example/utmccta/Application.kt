package com.example.utmccta
import io.flutter.app.FlutterApplication
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback
import io.flutter.view.FlutterMain
import io.flutter.plugins.firebase.messaging.FlutterFirebaseMessagingBackgroundService;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.os.Build;

class Application : FlutterApplication(), PluginRegistrantCallback {

    override fun onCreate() {
        super.onCreate()
        FlutterFirebaseMessagingBackgroundService.setPluginRegistrant(this);
        FlutterMain.startInitialization(this)

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel("messages", "Messages", NotificationManager.IMPORTANCE_LOW)
            val manager: NotificationManager = getSystemService(NotificationManager::class.java)
            manager.createNotificationChannel(channel)
        }
    }

    override fun registerWith(registry: PluginRegistry?) {
    }
}