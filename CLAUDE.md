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

## 🚀 Next Steps Required

### **Option 1: Create Default Configuration Template**
Create a default `config.json` template in the repository that users can customize:

```bash
# Create config template
cp /home/insomnia/.config/illogical-impulse/config.json \
   /home/insomnia/git/dots-hyprland/dots/.config/quickshell/ii/config.json.template

# Modify paths to be relative or use placeholders
```

### **Option 2: Add Wallpaper Configuration Script**
Create a setup script that:
1. Copies default wallpapers to user's Pictures directory
2. Generates initial config with correct paths
3. Sets up symlinks or configuration

### **Option 3: Modify Existing Scripts**
Update `switchwall.sh` and related scripts to handle:
- Default wallpaper paths
- Fallback wallpapers
- Configuration initialization

## 📝 Recommendations

1. **Create `config.json.template`** in the repo with placeholder paths
2. **Add setup documentation** explaining how to customize wallpaper paths
3. **Consider adding default wallpapers** to the repo's assets
4. **Update installation scripts** to handle wallpaper configuration

## 🔗 Related Files for Modification
- `switchwall.sh` - Main wallpaper switching script
- `Wallpapers.qml` - Wallpaper service
- Any initialization scripts that create first-run config

## ⚠️ Important Notes
- The user's live config uses **absolute paths** (`/home/insomnia/Pictures/...`)
- Repository should use **relative paths** or **environment variables**
- Need to decide: Include sample wallpapers or just configuration templates?