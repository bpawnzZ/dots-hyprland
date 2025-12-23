# Files to Update for Multi-Monitor Wallpaper Support

## Essential QML/Script Files (5 files):

### 1. **Config.qml** - Configuration structure
**Path**: `dots/.config/quickshell/ii/modules/common/Config.qml`
**Purpose**: Adds `wallpaperPaths` and `thumbnailPaths` objects for per-monitor storage
**Key changes**:
- Added `property JsonObject wallpaperPaths: JsonObject {}`
- Added `property JsonObject thumbnailPaths: JsonObject {}`
- Keeps legacy `wallpaperPath` and `thumbnailPath` for migration

### 2. **Background.qml** - Wallpaper rendering
**Path**: `dots/.config/quickshell/ii/modules/ii/background/Background.qml`
**Purpose**: Reads per-monitor wallpaper paths with fallback to legacy
**Key changes**:
- Modified to read from `Config.options.background.wallpaperPaths[monitorName]`
- Falls back to `Config.options.background.wallpaperPath` if per-monitor not set

### 3. **WallpaperSelectorContent.qml** - UI component
**Path**: `dots/.config/quickshell/ii/modules/ii/wallpaperSelector/WallpaperSelectorContent.qml`
**Purpose**: Adds monitor dropdown and "Apply to all monitors" option
**Key changes**:
- Added monitor selection dropdown (visible when `Wallpapers.monitorList.length > 1`)
- Added "Apply to all monitors" option
- Modified `selectWallpaperPath` function to pass monitor parameter

### 4. **Wallpapers.qml** - Service/backend
**Path**: `dots/.config/quickshell/ii/services/Wallpapers.qml`
**Purpose**: Monitor detection, migration logic, and apply functions
**Key changes**:
- Added `monitorList` property with automatic detection via `hyprctl`
- Added `currentMonitor` property
- Added migration logic in `Component.onCompleted`
- Modified `apply()` function to accept monitor parameter
- Fixed Type annotation errors (removed `: string`, `: void`)

### 5. **switchwall.sh** - Script integration
**Path**: `dots/.config/quickshell/ii/scripts/colors/switchwall.sh`
**Purpose**: Extended with monitor-specific parameters
**Key changes**:
- Added `--monitor <name>` parameter for specific monitor
- Added `--all-monitors` parameter for all monitors
- Modified `set_wallpaper_path()` and `set_thumbnail_path()` for per-monitor storage
- Updated video wallpaper handling for multi-monitor

## Quick Update Command:
```bash
# From the dots-hyprland repository root:
cp dots/.config/quickshell/ii/modules/common/Config.qml ~/.config/quickshell/ii/modules/common/
cp dots/.config/quickshell/ii/modules/ii/background/Background.qml ~/.config/quickshell/ii/modules/ii/background/
cp dots/.config/quickshell/ii/modules/ii/wallpaperSelector/WallpaperSelectorContent.qml ~/.config/quickshell/ii/modules/ii/wallpaperSelector/
cp dots/.config/quickshell/ii/scripts/colors/switchwall.sh ~/.config/quickshell/ii/scripts/colors/
cp dots/.config/quickshell/ii/services/Wallpapers.qml ~/.config/quickshell/ii/services/
```

## Additional Requirements:

### Shapes Submodule Initialization:
```bash
cd ~/.config/quickshell/ii/modules/common/widgets/shapes
git submodule update --init --recursive
```

### Configuration Migration:
The system automatically migrates existing `wallpaperPath` to `wallpaperPaths` for all detected monitors on first run.

## File Dependencies:
```
Config.qml (defines structure)
     ↓
Wallpapers.qml (reads/writes config, detects monitors)
     ↓
Background.qml (reads config for display)
     ↓
WallpaperSelectorContent.qml (UI for selection)
     ↓
switchwall.sh (script called by Wallpapers.qml)
```

All 5 files must be updated together for the feature to work correctly.