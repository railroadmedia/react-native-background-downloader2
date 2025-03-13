package com.eko;

/**
 * Build configuration for the RNBackgroundDownloader module
 */
public class BuildConfig {
    public static final boolean IS_NEW_ARCHITECTURE_ENABLED = Boolean.parseBoolean(System.getProperty("IS_NEW_ARCHITECTURE_ENABLED", "false"));
} 