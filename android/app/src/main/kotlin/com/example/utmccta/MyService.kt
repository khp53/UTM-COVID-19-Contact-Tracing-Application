package com.example.utmccta

import android.app.NotificationManager
import android.app.Service
import android.content.Intent
import android.os.Build
import android.os.IBinder
import androidx.core.app.NotificationCompat


class MyService : Service() {

    override fun onCreate() {
        super.onCreate()
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val builder =  NotificationCompat.Builder(this, "messages")
                    .setContentText("Contact Tracing Running In The Background")
                    .setContentTitle("UTM CCTA")
                    .setSmallIcon(R.mipmap.ic_stat_notification_icon_one)
            startForeground(101, builder.build())
        }
    }


    override fun onBind(intent: Intent?): IBinder? {
        return null
    }
}