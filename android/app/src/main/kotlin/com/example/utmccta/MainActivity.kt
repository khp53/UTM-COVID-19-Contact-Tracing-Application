package com.example.utmccta

import io.flutter.embedding.android.FlutterActivity
//import io.flutter.app.FlutterActivity;
import android.content.Intent
import android.os.Build
import android.os.Bundle
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant


class MainActivity : FlutterActivity() {
    private var forService: Intent? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        provideFlutterEngine(this)?.let { GeneratedPluginRegistrant.registerWith(it) }

        forService = Intent(this, MyService::class.java)

        // if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
        //     startForegroundService(forService)
        // } else {
        //     startService(forService)
        // }
        MethodChannel(flutterEngine?.dartExecutor,"com.karimul.utmccta").setMethodCallHandler{ call, result ->
            if(call.method.equals("startService")){
                //val intent= Intent(this, MyService::class.java)
                startService(forService)
                result.success("Service Started")
            }
            else if(call.method.equals("stopService")){
                stopService(forService)
                result.success("Service Stopped")
            }
            else{
                result.notImplemented()
            }
        }


    fun startService() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            startForegroundService(forService)
        } else {
            startService(forService)
        }
    }

    fun stopService() {
        startService(forService)
    }
}
}
