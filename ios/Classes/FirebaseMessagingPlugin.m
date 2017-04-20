#import "FirebaseMessagingPlugin.h"

@implementation FirebaseMessagingPlugin {
}

- (instancetype)initWithController:(FlutterViewController *)controller {
  self = [super init];
  if (self) {
    FlutterMethodChannel *channel = [FlutterMethodChannel
        methodChannelWithName:@"firebase_messaging"
              binaryMessenger:controller];
    [channel setMethodCallHandler:^(FlutterMethodCall *call,
                                    FlutterResult result) {
      if ([@"getPlatformVersion" isEqualToString:call.method]) {
        result([@"iOS " stringByAppendingString:[[UIDevice currentDevice]
                                                    systemVersion]]);
      } else {
        result(FlutterMethodNotImplemented);
      }
    }];
  }
  return self;
}

@end
