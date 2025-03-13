#import "RNBackgroundDownloaderTurboModule.h"
#import <React/RCTConvert.h>
#import <jsi/jsi.h>

namespace facebook {
namespace react {

RNBackgroundDownloaderTurboModule::RNBackgroundDownloaderTurboModule(std::shared_ptr<CallInvoker> jsInvoker, RNBackgroundDownloader *module)
    : NativeRNBackgroundDownloaderSpec(jsInvoker), module_(module) {}

jsi::Value RNBackgroundDownloaderTurboModule::checkForExistingDownloads(jsi::Runtime &rt) {
  __block jsi::Value result = jsi::Value::undefined();
  
  jsi::Object promise = rt.global().getPropertyAsObject(rt, "Promise");
  auto promiseConstructor = promise.getPropertyAsFunction(rt, "resolve");
  
  [module_ checkForExistingDownloadsWithResolver:^(NSArray *foundTasks) {
    NSMutableArray *jsArray = [NSMutableArray array];
    for (NSDictionary *task in foundTasks) {
      [jsArray addObject:task];
    }
    
    jsi::Array jsResult(rt, jsArray.count);
    for (size_t i = 0; i < jsArray.count; i++) {
      NSDictionary *task = jsArray[i];
      jsi::Object jsTask(rt);
      
      jsTask.setProperty(rt, "id", jsi::String::createFromUtf8(rt, [task[@"id"] UTF8String]));
      jsTask.setProperty(rt, "state", task[@"state"].intValue);
      jsTask.setProperty(rt, "bytesDownloaded", static_cast<double>([task[@"bytesDownloaded"] longLongValue]));
      jsTask.setProperty(rt, "bytesTotal", static_cast<double>([task[@"bytesTotal"] longLongValue]));
      jsTask.setProperty(rt, "metadata", jsi::String::createFromUtf8(rt, [task[@"metadata"] UTF8String]));
      
      jsResult.setValueAtIndex(rt, i, std::move(jsTask));
    }
    
    result = std::move(jsResult);
  } rejecter:^(NSString *code, NSString *message, NSError *error) {
    jsi::Object jsError(rt);
    jsError.setProperty(rt, "code", jsi::String::createFromUtf8(rt, [code UTF8String]));
    jsError.setProperty(rt, "message", jsi::String::createFromUtf8(rt, [message UTF8String]));
    
    result = std::move(jsError);
  }];
  
  return result;
}

void RNBackgroundDownloaderTurboModule::download(jsi::Runtime &rt, jsi::Object options) {
  NSMutableDictionary *optionsDict = [NSMutableDictionary new];
  
  if (options.hasProperty(rt, "id")) {
    jsi::String id = options.getProperty(rt, "id").asString(rt);
    optionsDict[@"id"] = [NSString stringWithUTF8String:id.utf8(rt).c_str()];
  }
  
  if (options.hasProperty(rt, "url")) {
    jsi::String url = options.getProperty(rt, "url").asString(rt);
    optionsDict[@"url"] = [NSString stringWithUTF8String:url.utf8(rt).c_str()];
  }
  
  if (options.hasProperty(rt, "destination")) {
    jsi::String destination = options.getProperty(rt, "destination").asString(rt);
    optionsDict[@"destination"] = [NSString stringWithUTF8String:destination.utf8(rt).c_str()];
  }
  
  if (options.hasProperty(rt, "headers")) {
    jsi::Object headers = options.getProperty(rt, "headers").asObject(rt);
    NSMutableDictionary *headersDict = [NSMutableDictionary new];
    // Convert headers object to dictionary
    for (auto &propName : headers.getPropertyNames(rt)) {
      std::string name = propName.utf8(rt);
      jsi::Value value = headers.getProperty(rt, propName.c_str());
      if (value.isString()) {
        headersDict[@(name.c_str())] = [NSString stringWithUTF8String:value.asString(rt).utf8(rt).c_str()];
      }
    }
    optionsDict[@"headers"] = headersDict;
  }
  
  if (options.hasProperty(rt, "metadata")) {
    jsi::String metadata = options.getProperty(rt, "metadata").asString(rt);
    optionsDict[@"metadata"] = [NSString stringWithUTF8String:metadata.utf8(rt).c_str()];
  }
  
  if (options.hasProperty(rt, "progressInterval")) {
    double progressInterval = options.getProperty(rt, "progressInterval").asNumber();
    optionsDict[@"progressInterval"] = @(progressInterval);
  }
  
  [module_ downloadWithOptions:optionsDict];
}

void RNBackgroundDownloaderTurboModule::pauseTask(jsi::Runtime &rt, const std::string &id) {
  NSString *taskId = [NSString stringWithUTF8String:id.c_str()];
  [module_ pauseTaskWithId:taskId];
}

void RNBackgroundDownloaderTurboModule::resumeTask(jsi::Runtime &rt, const std::string &id) {
  NSString *taskId = [NSString stringWithUTF8String:id.c_str()];
  [module_ resumeTaskWithId:taskId];
}

void RNBackgroundDownloaderTurboModule::stopTask(jsi::Runtime &rt, const std::string &id) {
  NSString *taskId = [NSString stringWithUTF8String:id.c_str()];
  [module_ stopTaskWithId:taskId];
}

void RNBackgroundDownloaderTurboModule::completeHandler(jsi::Runtime &rt, const std::string &jobId) {
  NSString *taskId = [NSString stringWithUTF8String:jobId.c_str()];
  [module_ completeHandlerWithJobId:taskId];
}

jsi::String RNBackgroundDownloaderTurboModule::documents(jsi::Runtime &rt) {
  NSString *docs = module_.documents;
  return jsi::String::createFromUtf8(rt, [docs UTF8String]);
}

double RNBackgroundDownloaderTurboModule::TaskRunning(jsi::Runtime &rt) {
  return static_cast<double>(module_.TaskRunning);
}

double RNBackgroundDownloaderTurboModule::TaskSuspended(jsi::Runtime &rt) {
  return static_cast<double>(module_.TaskSuspended);
}

double RNBackgroundDownloaderTurboModule::TaskCanceling(jsi::Runtime &rt) {
  return static_cast<double>(module_.TaskCanceling);
}

double RNBackgroundDownloaderTurboModule::TaskCompleted(jsi::Runtime &rt) {
  return static_cast<double>(module_.TaskCompleted);
}

jsi::Value RNBackgroundDownloaderTurboModule::addListener(jsi::Runtime &rt, const jsi::String &eventName) {
  // Delegate to the underlying module
  [module_ addListener:[NSString stringWithUTF8String:eventName.utf8(rt).c_str()]];
  
  // Return undefined as per the spec
  return jsi::Value::undefined();
}

void RNBackgroundDownloaderTurboModule::removeListeners(jsi::Runtime &rt, double count) {
  // Delegate to the underlying module
  [module_ removeListeners:(int)count];
}

} // namespace react
} // namespace facebook 