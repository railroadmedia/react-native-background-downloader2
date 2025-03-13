#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>

@interface RNBackgroundDownloader : RCTEventEmitter <RCTBridgeModule>

@property (nonatomic, readonly) NSString *documents;
@property (nonatomic, readonly) NSInteger TaskRunning;
@property (nonatomic, readonly) NSInteger TaskSuspended;
@property (nonatomic, readonly) NSInteger TaskCanceling;
@property (nonatomic, readonly) NSInteger TaskCompleted;

// Methods for TurboModule
- (void)checkForExistingDownloadsWithResolver:(void (^)(NSArray *))resolve
                                     rejecter:(void (^)(NSString *, NSString *, NSError *))reject;
- (void)downloadWithOptions:(NSDictionary *)options;
- (void)pauseTaskWithId:(NSString *)taskId;
- (void)resumeTaskWithId:(NSString *)taskId;
- (void)stopTaskWithId:(NSString *)taskId;
- (void)completeHandlerWithJobId:(NSString *)jobId;

// Event Emitter methods
- (void)addListener:(NSString *)eventName;
- (void)removeListeners:(NSInteger)count;

@end
