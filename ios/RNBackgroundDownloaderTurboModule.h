#pragma once

#import <React/RCTEventEmitter.h>
#import "RNBackgroundDownloader.h"
#import "RNBackgroundDownloaderSpec.h"

namespace facebook {
namespace react {

class RNBackgroundDownloaderTurboModule : public NativeRNBackgroundDownloaderSpec {
public:
  RNBackgroundDownloaderTurboModule(std::shared_ptr<CallInvoker> jsInvoker, RNBackgroundDownloader *module);
  
  jsi::Value checkForExistingDownloads(jsi::Runtime &rt) override;
  void download(jsi::Runtime &rt, jsi::Object options) override;
  void pauseTask(jsi::Runtime &rt, const std::string &id) override;
  void resumeTask(jsi::Runtime &rt, const std::string &id) override;
  void stopTask(jsi::Runtime &rt, const std::string &id) override;
  void completeHandler(jsi::Runtime &rt, const std::string &jobId) override;
  
  // Event Emitter methods
  jsi::Value addListener(jsi::Runtime &rt, const jsi::String &eventName) override;
  void removeListeners(jsi::Runtime &rt, double count) override;

  // Constants getters
  jsi::String documents(jsi::Runtime &rt) override;
  double TaskRunning(jsi::Runtime &rt) override;
  double TaskSuspended(jsi::Runtime &rt) override;
  double TaskCanceling(jsi::Runtime &rt) override;
  double TaskCompleted(jsi::Runtime &rt) override;

private:
  RNBackgroundDownloader *module_;
};

} // namespace react
} // namespace facebook 