package io.flutter.plugins;

import io.flutter.app.FlutterActivity;

import io.flutter.firebase_messaging.FirebaseMessagingPlugin;

/**
 * Generated file. Do not edit.
 */

public class PluginRegistry {
    public FirebaseMessagingPlugin firebase_messaging;

    public void registerAll(FlutterActivity activity) {
        firebase_messaging = FirebaseMessagingPlugin.register(activity);
    }
}
