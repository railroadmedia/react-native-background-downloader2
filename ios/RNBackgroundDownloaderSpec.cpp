#include "RNBackgroundDownloaderSpec.h"

namespace facebook {
namespace react {

NativeRNBackgroundDownloaderSpec::NativeRNBackgroundDownloaderSpec(std::shared_ptr<CallInvoker> jsInvoker)
    : TurboModule("RNBackgroundDownloader", jsInvoker) {}

std::string NativeRNBackgroundDownloaderSpec::moduleName() {
  return "RNBackgroundDownloader";
}

} // namespace react
} // namespace facebook 