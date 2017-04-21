// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "AppDelegate.h"
#include "PluginRegistry.h"

@implementation AppDelegate {
  PluginRegistry *plugins;
}

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  // Override point for customization after application launch.
  FlutterViewController *flutterController =
      (FlutterViewController *)self.window.rootViewController;
  plugins = [[PluginRegistry alloc] initWithController:flutterController];
  [plugins.firebase_messaging didFinishLaunchingWithOptions:launchOptions];
  return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
  [plugins.firebase_messaging applicationDidEnterBackground];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
  [plugins.firebase_messaging applicationDidBecomeActive:application];
}

- (void)application:(UIApplication *)application
    didReceiveRemoteNotification:(NSDictionary *)userInfo {
  [plugins.firebase_messaging didReceiveRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)application
    didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
  [plugins.firebase_messaging didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application
    didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
  [plugins.firebase_messaging didRegisterUserNotificationSettings:notificationSettings];
}

@end
