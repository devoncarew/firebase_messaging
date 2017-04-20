import 'dart:async';

import 'package:flutter/services.dart';

class FirebaseMessaging {
  static const MethodChannel _channel =
      const MethodChannel('firebase_messaging');

  static Future<String> get platformVersion =>
      _channel.invokeMethod('getPlatformVersion');
}
