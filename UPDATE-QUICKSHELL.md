# Quickshell Multi-Monitor Wallpaper Update

This directory contains scripts and files to update an existing quickshell installation with multi-monitor wallpaper support.

## What's Included

The update includes the following changes from the `quickshell-wallpaper-mod1` branch:

### Core Files Updated:
1. **`Config.qml`** - Updated to store per-monitor wallpaper paths (`wallpaperPaths`, `thumbnailPaths`)
2. **`Background.qml`** - Modified to read per-monitor wallpaper paths with fallback
3. **`WallpaperSelectorContent.qml`** - Added monitor dropdown and "Apply to all monitors" option
4. **`Wallpapers.qml`** - Added monitor detection via `hyprctl` and migration logic
5. **`switchwall.sh`** - Extended with `--monitor` and `--all-monitors` parameters

### Features Added:
- Automatic monitor detection using `hyprctl`
- Per-monitor wallpaper configuration storage
- Migration from single-monitor to multi-monitor configuration
- Monitor dropdown in wallpaper selector UI
- "Apply to all monitors" option
- Backward compatibility with existing single-monitor setups

## Update Script

The main update script is `update-quickshell-wallpaper.sh`.

### Usage:

```bash
# Basic usage (default target: ~/.config/quickshell/ii)
./update-quickshell-wallpaper.sh

# Specify custom target directory
./update-quickshell-wallpaper.sh --target /path/to/quickshell/config

# Specify both source and target directories
./update-quickshell-wallpaper.sh --source /path/to/dots-hyprland --target /home/user/.config/quickshell/ii

# Show help
./update-quickshell-wallpaper.sh --help
```

### What the Script Does:

1. **Backs up existing files** - Creates `.backup.YYYYMMDD_HHMMSS` copies
2. **Copies updated files** - Overwrites with new versions
3. **Initializes shapes submodule** - Ensures `rounded-polygon-qmljs` is available
4. **Provides summary** - Shows which files were successfully updated

### Manual Update (if script doesn't work):

Copy these files manually:

```bash
# From the dots-hyprland repository root:
cp dots/.config/quickshell/ii/modules/common/Config.qml ~/.config/quickshell/ii/modules/common/
cp dots/.config/quickshell/ii/modules/ii/background/Background.qml ~/.config/quickshell/ii/modules/ii/background/
cp dots/.config/quickshell/ii/modules/ii/wallpaperSelector/WallpaperSelectorContent.qml ~/.config/quickshell/ii/modules/ii/wallpaperSelector/
cp dots/.config/quickshell/ii/scripts/colors/switchwall.sh ~/.config/quickshell/ii/scripts/colors/
cp dots/.config/quickshell/ii/services/Wallpapers.qml ~/.config/quickshell/ii/services/

# Initialize shapes submodule
cd ~/.config/quickshell/ii/modules/common/widgets/shapes
git submodule update --init --recursive
```

## Post-Update Steps

1. **Restart quickshell** to apply changes:
   ```bash
   # Kill existing quickshell instance
   pkill -f quickshell

   # Start quickshell (adjust command based on your setup)
   qs --path ~/.config/quickshell/ii
   ```

2. **Verify configuration migration**:
   Check `~/.config/illogical-impulse/config.json` for the new structure:
   ```json
   "background": {
     "wallpaperPaths": {
       "DP-1": "/path/to/wallpaper.jpg",
       "HDMI-A-1": "/path/to/wallpaper2.jpg"
     },
     "thumbnailPaths": {
       "DP-1": "/path/to/thumbnail.jpg",
       "HDMI-A-1": "/path/to/thumbnail2.jpg"
     }
   }
   ```

3. **Test the feature**:
   - Open wallpaper selector (default: likely `Super+W`)
   - Verify monitor dropdown appears (on multi-monitor systems)
   - Test applying wallpapers to specific monitors

## Troubleshooting

### Common Issues:

1. **Shapes module errors**:
   ```
   ERROR: module "qs.modules.common.widgets.shapes" is not installed
   ```
   Solution: Ensure shapes submodule is initialized:
   ```bash
   cd ~/.config/quickshell/ii/modules/common/widgets/shapes
   git submodule update --init --recursive
   ```

2. **IPC type warnings**:
   ```
   WARN: QML IpcHandler at @services/Wallpapers.qml: Error parsing function "apply"
   ```
   This is a known warning that doesn't affect functionality. The TypeScript-style type annotations have been removed.

3. **Monitor detection fails**:
   Ensure `hyprctl` is available and you're running Hyprland.

4. **Wallpaper selector doesn't show monitor dropdown**:
   - Check that `Wallpapers.monitorList` has entries (requires `hyprctl`)
   - On single-monitor systems, the dropdown is hidden (as intended)

## Rollback

If you need to revert the changes:

1. Use the backup files created by the script (`.backup.*` extensions)
2. Or restore from git if you have the original repository:
   ```bash
   git checkout main -- dots/.config/quickshell/ii/
   ```

## Files List

Here are all the files that were modified in this update:

```
.github/README.md
dots/.config/quickshell/ii/modules/common/Config.qml
dots/.config/quickshell/ii/modules/ii/background/Background.qml
dots/.config/quickshell/ii/modules/ii/wallpaperSelector/WallpaperSelectorContent.qml
dots/.config/quickshell/ii/scripts/colors/switchwall.sh
dots/.config/quickshell/ii/services/Wallpapers.qml
```

Note: The OpenSpec documentation files are not needed for the update to work, only the QML and script files listed above.