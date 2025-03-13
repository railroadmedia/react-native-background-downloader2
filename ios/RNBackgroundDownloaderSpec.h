#pragma once

#include <ReactCommon/TurboModule.h>
#include <RCTRequired/RCTRequired.h>
#include <jsi/jsi.h>

namespace facebook {
namespace react {

class JSI_EXPORT NativeRNBackgroundDownloaderSpec : public TurboModule {
protected:
  NativeRNBackgroundDownloaderSpec(std::shared_ptr<CallInvoker> jsInvoker);

public:
  virtual jsi::Value checkForExistingDownloads(jsi::Runtime &rt) = 0;
  
  virtual void download(jsi::Runtime &rt, jsi::Object options) = 0;
  
  virtual void pauseTask(jsi::Runtime &rt, const std::string &id) = 0;
  
  virtual void resumeTask(jsi::Runtime &rt, const std::string &id) = 0;
  
  virtual void stopTask(jsi::Runtime &rt, const std::string &id) = 0;
  
  virtual void completeHandler(jsi::Runtime &rt, const std::string &jobId) = 0;
  
  // Event Emitter methods
  virtual jsi::Value addListener(jsi::Runtime &rt, const jsi::String &eventName) = 0;
  
  virtual void removeListeners(jsi::Runtime &rt, double count) = 0;

  // Constants getters
  virtual jsi::String documents(jsi::Runtime &rt) = 0;
  virtual double TaskRunning(jsi::Runtime &rt) = 0;
  virtual double TaskSuspended(jsi::Runtime &rt) = 0;
  virtual double TaskCanceling(jsi::Runtime &rt) = 0;
  virtual double TaskCompleted(jsi::Runtime &rt) = 0;

  static std::string moduleName();
};

} // namespace react
} // namespace facebook 