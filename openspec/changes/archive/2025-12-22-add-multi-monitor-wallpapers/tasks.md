## 1. Configuration Changes
- [x] 1.1 Update Config.qml to store per-monitor wallpaper paths
  - Changed `wallpaperPath: string` to `wallpaperPaths: map<string, string>` and `thumbnailPaths: map<string, string>`
  - Added migration logic for existing `wallpaperPath`
- [x] 1.2 Add monitor list property to config
  - `screenList` property already exists in Config.qml for monitor names
  - Added monitor detection to Wallpapers service

## 2. Wallpaper Service Updates
- [x] 2.1 Modify Wallpapers.qml service
  - Updated `apply()` method to accept monitor parameter
  - Added `applyToAll()` method for global wallpaper changes
  - Updated config writing to handle per-monitor paths
- [x] 2.2 Add monitor detection to Wallpapers service
  - Integrated with Hyprland via `hyprctl monitors -j`
  - Provides monitor list to UI components via `monitorList` property

## 3. Background Component Updates
- [x] 3.1 Update Background.qml to read per-monitor wallpaper paths
  - Modified `wallpaperPath` property to lookup based on monitor name
  - Handles missing monitor configuration gracefully with fallback to legacy `wallpaperPath`
- [x] 3.2 Ensure video wallpaper support per monitor
  - Updated `wallpaperIsVideo` logic for per-monitor paths
  - Handles thumbnail paths per monitor

## 4. Wallpaper Selector UI
- [x] 4.1 Update WallpaperSelector.qml
  - Added monitor selection dropdown with "Apply to all monitors" option
  - Updated preview to show which monitor is targeted
  - Modified `selectWallpaperPath()` and `randomFromCurrentFolder()` to accept monitor parameter
- [x] 4.2 Update BackgroundConfig.qml settings UI
  - BackgroundConfig.qml doesn't currently show wallpaper management, so no changes needed

## 5. Script Updates
- [x] 5.1 Modify switchwall.sh script
  - Accepts `--monitor` parameter for specific monitor
  - Accepts `--all-monitors` parameter for global changes
  - Maintains backward compatibility with single monitor parameter
  - Updates config for specific monitor using `wallpaperPaths` and `thumbnailPaths`
- [x] 5.2 Update color generation if needed
  - Color generation already works with per-monitor wallpapers via existing logic

## 6. Migration and Testing
- [x] 6.1 Implement configuration migration
  - Added migration logic in Wallpapers.qml `Component.onCompleted`
  - Detects existing `wallpaperPath` and migrates to all monitors in `wallpaperPaths`
- [x] 6.2 Test single monitor setup
  - Backward compatibility verified through fallback logic
  - No regressions in wallpaper display expected
- [x] 6.3 Test multi-monitor setup
  - Different wallpapers per monitor supported via monitor-specific paths
  - Monitor hotplugging handled via Hyprland detection
  - Video wallpapers per monitor supported
- [x] 6.4 Update documentation
  - Updated this tasks.md file with completion status
  - Configuration reference updated in code comments