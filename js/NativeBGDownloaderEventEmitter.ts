import { NativeEventEmitter } from 'react-native';
import NativeRNBackgroundDownloader from './NativeRNBackgroundDownloader';

/**
 * Event emitter for the RNBackgroundDownloader module.
 * This wraps the native module to provide event emitting capabilities.
 */
class NativeBGDownloaderEventEmitter extends NativeEventEmitter {
  constructor() {
    // Cast the module to any type to bypass TypeScript checks
    super(NativeRNBackgroundDownloader as any);
  }
}

export default new NativeBGDownloaderEventEmitter(); 