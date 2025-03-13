package com.eko;

import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.turbomodule.core.interfaces.TurboModule;

/**
 * Spec for the RNBackgroundDownloader Turbo Module
 */
public abstract class NativeRNBackgroundDownloaderSpec implements TurboModule {
    
    public static final String NAME = "RNBackgroundDownloader";
    
    protected NativeRNBackgroundDownloaderSpec(ReactApplicationContext reactContext) {
        // Required constructor
    }
    
    // Methods
    public abstract Promise checkForExistingDownloads();
    
    public abstract void download(ReadableMap options);
    
    public abstract void pauseTask(String id);
    
    public abstract void resumeTask(String id);
    
    public abstract void stopTask(String id);
    
    public abstract void completeHandler(String jobId);
    
    // Event Emitter methods
    public abstract void addListener(String eventName);
    
    public abstract void removeListeners(double count);
    
    // Constants getters
    public abstract String getDocuments();
    
    public abstract double getTaskRunning();
    
    public abstract double getTaskSuspended();
    
    public abstract double getTaskCanceling();
    
    public abstract double getTaskCompleted();
} 