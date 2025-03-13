#import <React/RCTCxxModule.h>
#import <React/RCTMacros.h>
#import <React/RCTTurboModule.h>

#import "RNBackgroundDownloader.h"
#import "RNBackgroundDownloaderTurboModule.h"

/**
 * Provides the RNBackgroundDownloaderTurboModule
 */
@interface RNBackgroundDownloaderModuleProvider : NSObject <RCTTurboModuleProvider>
@end

@implementation RNBackgroundDownloaderModuleProvider
RCT_EXPORT_MODULE()

/// Returns the module name to export over JS
- (NSString *)getModuleName {
  return @"RNBackgroundDownloader";
}

/// Returns an instance of the Turbo Native Module
- (id<RCTTurboModule>)getTurboModule:(const ObjCTurboModule::InitParams &)params {
  // Create the native module
  RNBackgroundDownloader *bgDownloader = [RNBackgroundDownloader new];
  
  // Return a new instance of the Turbo Module wrapper
  return (id<RCTTurboModule>)[[facebook::react::RNBackgroundDownloaderTurboModule alloc]
          initWithCxxBridge:params.bridge
                   callback:params.callback
                 uiManager:params.uiManager
                    module:bgDownloader];
}

@end

// Register this provider with TurboModuleRegistry
Class RNBackgroundDownloaderModuleProviderCls(void) {
  return RNBackgroundDownloaderModuleProvider.class;
} 