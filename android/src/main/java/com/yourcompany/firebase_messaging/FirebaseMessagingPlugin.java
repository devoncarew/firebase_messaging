package com.yourcompany.firebase_messaging;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.MethodCall;

/**
 * FirebaseMessagingPlugin
 */
public class FirebaseMessagingPlugin implements MethodCallHandler {
  private FlutterActivity activity;

  public static FirebaseMessagingPlugin register(FlutterActivity activity) {
    return new FirebaseMessagingPlugin(activity);
  }

  private FirebaseMessagingPlugin(FlutterActivity activity) {
    this.activity = activity;
    new MethodChannel(activity.getFlutterView(), "firebase_messaging").setMethodCallHandler(this);
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    if (call.method.equals("getPlatformVersion")) {
      result.success("Android " + android.os.Build.VERSION.RELEASE);
    } else {
      result.notImplemented();
    }
  }
}
