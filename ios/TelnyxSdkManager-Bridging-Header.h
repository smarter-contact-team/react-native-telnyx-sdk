#import <React/RCTBridgeModule.h>
#import <React/RCTViewManager.h>
#import <React/RCTEventEmitter.h>

@interface TelnyxSdkManager : RCTEventEmitter <RCTBridgeModule>

+ (void)processVoIPNotification:(NSString *)callId;

@end
