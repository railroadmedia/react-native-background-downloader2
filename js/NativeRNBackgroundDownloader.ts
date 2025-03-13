import type { TurboModule } from 'react-native/Libraries/TurboModule/RCTExport'
import { TurboModuleRegistry, EmitterSubscription } from 'react-native'

export interface Spec extends TurboModule {
  // Constants
  readonly documents: string;
  readonly TaskRunning: number;
  readonly TaskSuspended: number;
  readonly TaskCanceling: number;
  readonly TaskCompleted: number;

  // Methods
  checkForExistingDownloads(): Promise<Array<{
    id: string;
    state: number;
    bytesDownloaded: number;
    bytesTotal: number;
    metadata: string;
  }>>;

  download(options: {
    id: string;
    url: string;
    destination: string;
    headers?: object;
    metadata?: string;
    isAllowedOverRoaming?: boolean;
    isAllowedOverMetered?: boolean;
    isNotificationVisible?: boolean;
    notificationTitle?: string;
    progressInterval: number;
  }): void;

  pauseTask(id: string): void;
  resumeTask(id: string): void;
  stopTask(id: string): void;
  completeHandler(jobId: string): void;

  // Event Emitter Methods
  addListener(eventName: string): EmitterSubscription;
  removeListeners(count: number): void;
}

export default TurboModuleRegistry.getEnforcing<Spec>('RNBackgroundDownloader')
