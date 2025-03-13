package com.eko;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.facebook.proguard.annotations.DoNotStrip;
import com.facebook.react.bridge.NativeModule;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.module.model.ReactModuleInfo;
import com.facebook.react.module.model.ReactModuleInfoProvider;
import com.facebook.react.turbomodule.core.CallInvokerHolderImpl;
import com.facebook.react.turbomodule.core.interfaces.TurboModule;
import com.facebook.react.turbomodule.core.interfaces.TurboModuleRegistry;

import java.util.HashMap;
import java.util.Map;

/**
 * Turbo Module implementation for RNBackgroundDownloader
 */
@DoNotStrip
public class RNBackgroundDownloaderTurboModule extends NativeRNBackgroundDownloaderSpec {
    
    private final RNBackgroundDownloaderModule module;
    
    // Constructor
    public RNBackgroundDownloaderTurboModule(ReactApplicationContext reactContext) {
        super(reactContext);
        this.module = new RNBackgroundDownloaderModule(reactContext);
    }
    
    @Override
    public String getName() {
        return RNBackgroundDownloaderModule.NAME;
    }
    
    // Module methods
    @Override
    public void download(ReadableMap options) {
        module.download(options);
    }
    
    @Override
    public void pauseTask(String id) {
        module.pauseTask(id);
    }
    
    @Override
    public void resumeTask(String id) {
        module.resumeTask(id);
    }
    
    @Override
    public void stopTask(String id) {
        module.stopTask(id);
    }
    
    @Override
    public void completeHandler(String jobId) {
        module.completeHandler(jobId);
    }
    
    @Override
    public double getTaskRunning() {
        return RNBackgroundDownloaderModule.TASK_RUNNING;
    }
    
    @Override
    public double getTaskSuspended() {
        return RNBackgroundDownloaderModule.TASK_SUSPENDED;
    }
    
    @Override
    public double getTaskCanceling() {
        return RNBackgroundDownloaderModule.TASK_CANCELING;
    }
    
    @Override
    public double getTaskCompleted() {
        return RNBackgroundDownloaderModule.TASK_COMPLETED;
    }
    
    @Override
    public String getDocuments() {
        return module.getConstants().get("documents").toString();
    }
    
    @Override
    public Promise checkForExistingDownloads() {
        Promise promise = new Promise() {
            @Override
            public void resolve(@Nullable Object value) {
                // Resolve the promise with the result
            }
            
            @Override
            public void reject(String code, String message) {
                // Reject the promise with an error
            }
            
            @Override
            public void reject(String code, Throwable throwable) {
                // Reject the promise with an error
            }
            
            @Override
            public void reject(String code, String message, Throwable throwable) {
                // Reject the promise with an error
            }
            
            @Override
            public void reject(Throwable throwable) {
                // Reject the promise with an error
            }
            
            @Override
            public void reject(Throwable throwable, Throwable throwable1) {
                // Reject the promise with an error
            }
            
            @Override
            public void reject(String s, @NonNull WritableMap writableMap) {
                // Reject the promise with an error
            }
            
            @Override
            public void reject(String s, Throwable throwable, @NonNull WritableMap writableMap) {
                // Reject the promise with an error
            }
            
            @Override
            public void reject(String s, String s1, @NonNull WritableMap writableMap) {
                // Reject the promise with an error
            }
            
            @Override
            public void reject(String s, String s1, Throwable throwable, @NonNull WritableMap writableMap) {
                // Reject the promise with an error
            }
        };
        
        module.checkForExistingDownloads(promise);
        return promise;
    }
    
    @Override
    public void addListener(String eventName) {
        // Delegate to the underlying module
        module.addListener(eventName);
    }
    
    @Override
    public void removeListeners(double count) {
        // Delegate to the underlying module
        module.removeListeners((int) count);
    }
    
    // Module provider
    public static class Provider implements TurboModuleRegistry.TurboModuleProvider {
        
        @Nullable
        @Override
        public TurboModule getModule(String name, ReactApplicationContext reactContext, CallInvokerHolderImpl jsCallInvokerHolder) {
            if (name.equals(RNBackgroundDownloaderModule.NAME)) {
                return new RNBackgroundDownloaderTurboModule(reactContext);
            }
            return null;
        }
        
        public ReactModuleInfoProvider getReactModuleInfoProvider() {
            return () -> {
                Map<String, ReactModuleInfo> moduleInfos = new HashMap<>();
                moduleInfos.put(
                        RNBackgroundDownloaderModule.NAME,
                        new ReactModuleInfo(
                                RNBackgroundDownloaderModule.NAME,
                                RNBackgroundDownloaderModule.NAME,
                                false, // canOverrideExistingModule
                                false, // needsEagerInit
                                true, // hasConstants
                                false, // isCxxModule
                                true // isTurboModule
                        ));
                return moduleInfos;
            };
        }
    }
} 