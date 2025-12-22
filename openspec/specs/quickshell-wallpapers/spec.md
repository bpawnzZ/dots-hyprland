# Wallpaper Management

## Purpose
This capability handles wallpaper selection, application, and management for quickshell, including multi-monitor support.

## Requirements
### Requirement: Wallpaper Application
The system SHALL apply wallpapers to specific monitors based on configuration.

#### Scenario: Applying wallpaper to specific monitor
- **WHEN** a user selects a wallpaper for a specific monitor
- **THEN** only that monitor's background updates with the new wallpaper
- **AND** other monitors retain their current wallpapers

#### Scenario: Video wallpaper support per monitor
- **WHEN** a user sets a video wallpaper for a specific monitor
- **THEN** that monitor plays the video wallpaper
- **AND** other monitors can have different wallpaper types (image or video)

### Requirement: Configuration Migration
The system SHALL migrate existing single-monitor wallpaper configuration to multi-monitor format.

#### Scenario: Migrating existing configuration
- **WHEN** quickshell starts with existing single `wallpaperPath` configuration
- **THEN** it migrates the wallpaper to all detected monitors
- **AND** preserves the user's wallpaper across all monitors

#### Scenario: Fresh installation
- **WHEN** quickshell starts with no existing wallpaper configuration
- **THEN** it initializes empty per-monitor wallpaper configuration
- **AND** allows wallpaper assignment to individual monitors