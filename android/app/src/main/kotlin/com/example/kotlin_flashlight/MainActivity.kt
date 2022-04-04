package com.example.kotlin_flashlight

import io.flutter.embedding.android.FlutterActivity
import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodCall

// required native imports
import android.content.Context
import android.hardware.camera2.CameraAccessException
import android.hardware.camera2.CameraManager
//


class MainActivity: FlutterActivity() {
    private val CHANNEL = "flutter.native/helper" //channel name
    var flashLightStatus: Boolean = false // status of flash light i.e, true or false

    @ExperimentalStdlibApi
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler{
            call, result -> 
            when {
                call.method.equals("flashLightOnOrOff") -> {
                     flashLightOnOrOff(result);
                }
            }
        }
    }
// Function to turn on or off the flashlight
    private fun flashLightOnOrOff(result: MethodChannel.Result):Unit {
        val cameraManager = getSystemService(Context.CAMERA_SERVICE) as CameraManager
        val cameraId = cameraManager.cameraIdList[0]
           if(!flashLightStatus){ // if false, turn on flashlight
                try {
                cameraManager.setTorchMode(cameraId, true);
                flashLightStatus = true;
                result.success(flashLightStatus)
                
            } catch (e: CameraAccessException) {
                result.error("UNAVAILABLE", "Something went wrong",null)
            }}
            else { //else,turn off flashlight
            try {
                cameraManager.setTorchMode(cameraId, false);
                flashLightStatus = false;
                result.success(flashLightStatus)
            } catch (e: CameraAccessException) {
                result.error("UNAVAILABLE", "Something went wrong",null)
            }
        }
    }
}
