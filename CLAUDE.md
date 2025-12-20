# 🗺️ Quickshell Wallpaper Configuration Analysis

## 📋 Project Overview
**Repository**: `/home/insomnia/git/dots-hyprland` (Hyprland dots setup)
**Current Branch**: `quickshell-wallpaper-modifications`
**Target Directory**: `/home/insomnia/git/dots-hyprland/dots/.config/quickshell`

## 🎯 Current State Analysis

### **Quickshell Configuration Structure**
The quickshell configuration uses a **modular QML-based system** with no traditional JSON config files in the repository. Instead, configuration is managed through:

1. **QML Modules** - UI components that read/write to `Config.options`
2. **Services** - Background services like `Wallpapers.qml`
3. **Scripts** - Shell scripts for wallpaper switching (`switchwall.sh`)

### **Wallpaper Configuration Flow**
Based on analysis of the current system:

1. **User's Live Config**: `/home/insomnia/.config/illogical-impulse/config.json`
   - Contains `background.wallpaperPath`: `/home/insomnia/Pictures/Wallpapers/muscle-car-ice-road-red-moon.jpg`
   - Contains `background.thumbnailPath`: `/home/insomnia/Pictures/icons/punisher-1.png`

2. **Repository Structure**: No equivalent config file exists in the repo
   - The repo contains only QML modules, services, and scripts
   - Configuration appears to be **runtime-generated** or **user-specific**

3. **Configuration Access Pattern**:
   - QML files access `Config.options.background.wallpaperPath`
   - `Config` appears to be a singleton/service that manages configuration
   - No persistent JSON config found in the repository

### **Key Files Identified**

#### **Core Configuration Files**:
- `dots/.config/quickshell/ii/services/Wallpapers.qml` - Wallpaper service
- `dots/.config/quickshell/ii/scripts/colors/switchwall.sh` - Wallpaper switching script
- `dots/.config/quickshell/ii/modules/common/Appearance.qml` - Appearance config (reads wallpaperPath)
- `dots/.config/quickshell/ii/modules/ii/background/Background.qml` - Background rendering

#### **UI Configuration Files**:
- `dots/.config/quickshell/ii/modules/settings/QuickConfig.qml` - Quick settings with wallpaper preview
- `dots/.config/quickshell/ii/modules/settings/BackgroundConfig.qml` - Background settings
- `dots/.config/quickshell/ii/modules/ii/wallpaperSelector/WallpaperSelectorContent.qml` - Wallpaper selector UI

## 🔍 Configuration Mystery
**Critical Finding**: The repository contains **NO** `config.json` file equivalent to the user's live config at `/home/insomnia/.config/illogical-impulse/config.json`.

This suggests:
1. Configuration is **generated at first run**
2. Configuration is **user-specific** and not stored in the dots repo
3. The repo contains only **templates/defaults**

## ✅ **IMPLEMENTATION COMPLETE: Multi-Monitor Wallpaper Support** 🎯

### **What Was Implemented**
The system now supports **per-monitor wallpapers** through the following changes:

#### **1. Configuration Schema**
- **New**: `background.wallpaperPaths` object mapping monitor names to wallpaper paths
  ```json
  "wallpaperPaths": {
    "eDP-1": "/path/to/wallpaper1.jpg",
    "HDMI-1": "/path/to/wallpaper2.jpg"
  }
  ```
- **Backward Compatible**: `background.wallpaperPath` still works for single wallpaper across all monitors
- **Fallback Logic**: Background components check `wallpaperPaths[monitor.name]` first, then fall back to `wallpaperPath`

#### **2. Modified Files**
- `Background.qml`: Added `getWallpaperPathForMonitor()` function for per-monitor path resolution
- `switchwall.sh`: Added `--monitor` flag and updated `set_wallpaper_path()` to handle per-monitor config

#### **3. Usage Examples**
```bash
# Set wallpaper for specific monitor
./switchwall.sh --image /path/to/wallpaper.jpg --monitor eDP-1

# Set wallpaper for all monitors (backward compatible)
./switchwall.sh --image /path/to/wallpaper.jpg

# Set different wallpapers for different monitors
./switchwall.sh --image /path/to/wallpaper1.jpg --monitor eDP-1
./switchwall.sh --image /path/to/wallpaper2.jpg --monitor HDMI-1
```

#### **4. Technical Details**
- **Monitor Identification**: Uses Hyprland monitor names from `hyprctl monitors -j | jq -r '.[].name'`
- **Color Generation**: Always uses the wallpaper being set for system color generation (affects all monitors)
- **Video Wallpapers**: `--monitor` flag works with video wallpapers (mpvpaper applied to specified monitor only)
- **UI Integration**: Wallpaper selector UI still applies to all monitors (backward compatibility)

#### **5. Limitations & Notes**
- Widgets (clock, weather) use global `wallpaperPath` for safety checking (not per-monitor)
- Video wallpaper restore script (`__restore_video_wallpaper.sh`) restores same video on all monitors
- Appearance color quantization uses global `wallpaperPath` (from first monitor or fallback)
- For full UI integration, WallpaperSelector would need to know which monitor is being targeted

## 🔗 **Modified Files**
- `dots/.config/quickshell/ii/modules/ii/background/Background.qml` - Core per-monitor logic
- `dots/.config/quickshell/ii/scripts/colors/switchwall.sh` - CLI interface with `--monitor` flag
- `CLAUDE.md` - This documentation file

## 🚀 **Testing & Validation**
1. **Test per-monitor config**: `jq '.background.wallpaperPaths = {"eDP-1": "/test1.jpg", "HDMI-1": "/test2.jpg"}' config.json`
2. **Test CLI**: `./switchwall.sh --image ~/Pictures/wall.jpg --monitor eDP-1`
3. **Verify backward compatibility**: `./switchwall.sh --image ~/Pictures/wall.jpg` (applies to all monitors)

## 📝 **Future Enhancements**
1. **UI Integration**: Update WallpaperSelector to target specific monitors
2. **Video Restore**: Enhance restore script for per-monitor video wallpapers
3. **Widget Support**: Update widgets to use per-monitor wallpaper paths
4. **Configuration UI**: Add monitor-specific wallpaper settings in QuickConfig

## ⚠️ **Important Notes**
- The system maintains **full backward compatibility** with existing configs
- Monitor names are dynamic (from Hyprland) - use `hyprctl monitors -j` to see available names
- Color generation affects entire system regardless of which monitor's wallpaper is changed

