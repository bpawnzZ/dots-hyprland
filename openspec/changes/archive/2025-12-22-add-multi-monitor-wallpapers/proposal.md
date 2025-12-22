# Change: Add multi-monitor wallpaper support to quickshell

## Why
Currently, quickshell only supports setting a single wallpaper for all monitors in a multi-monitor Hyprland environment. Users with multiple monitors cannot assign different wallpapers to each monitor, limiting personalization and visual customization options.

## What Changes
- **ADDED**: Per-monitor wallpaper configuration storage in quickshell config
- **MODIFIED**: Wallpaper application logic to support monitor-specific wallpaper paths
- **MODIFIED**: Wallpaper selector UI to allow targeting specific monitors
- **MODIFIED**: `switchwall.sh` script to handle multiple monitor configurations
- **ADDED**: Monitor detection and identification for wallpaper assignment
- **MODIFIED**: Background component to read per-monitor wallpaper paths

**BREAKING**: The configuration structure for wallpapers changes from single `wallpaperPath` to per-monitor mapping. Existing single wallpaper configuration will be migrated to apply to all monitors.

## Impact
- Affected specs: quickshell-wallpapers capability
- Affected code:
  - `dots/.config/quickshell/ii/services/Wallpapers.qml`
  - `dots/.config/quickshell/ii/modules/ii/background/Background.qml`
  - `dots/.config/quickshell/ii/scripts/colors/switchwall.sh`
  - `dots/.config/quickshell/ii/modules/common/Config.qml`
  - `dots/.config/quickshell/ii/modules/ii/wallpaperSelector/WallpaperSelector.qml`
  - `dots/.config/quickshell/ii/modules/settings/BackgroundConfig.qml`