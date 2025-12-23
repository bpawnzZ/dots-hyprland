# Multi-Monitor Wallpaper Configuration Examples

## Config File Location
`~/.config/illogical-impulse/config.json`

## How to Find Your Monitor Names
```bash
# Get monitor names from Hyprland
hyprctl monitors -j | jq -r '.[] | .name'

# Example output:
# eDP-1
# HDMI-A-1
# DP-2
```

## Configuration Structure Examples

### Example 1: Different Wallpapers for Each Monitor
```json
{
  "background": {
    "wallpaperPaths": {
      "eDP-1": "/home/user/Pictures/Wallpapers/nature1.jpg",
      "HDMI-A-1": "/home/user/Pictures/Wallpapers/cityscape.jpg",
      "DP-2": "/home/user/Pictures/Wallpapers/abstract.jpg"
    },
    "thumbnailPaths": {
      "eDP-1": "/home/user/.cache/quickshell/user/generated/thumbnails/nature1_thumb.jpg",
      "HDMI-A-1": "/home/user/.cache/quickshell/user/generated/thumbnails/cityscape_thumb.jpg",
      "DP-2": "/home/user/.cache/quickshell/user/generated/thumbnails/abstract_thumb.jpg"
    }
  }
}
```

### Example 2: Same Wallpaper on All Monitors
```json
{
  "background": {
    "wallpaperPaths": {
      "eDP-1": "/home/user/Pictures/Wallpapers/unified.jpg",
      "HDMI-A-1": "/home/user/Pictures/Wallpapers/unified.jpg",
      "DP-2": "/home/user/Pictures/Wallpapers/unified.jpg"
    },
    "thumbnailPaths": {
      "eDP-1": "/home/user/.cache/quickshell/user/generated/thumbnails/unified_thumb.jpg",
      "HDMI-A-1": "/home/user/.cache/quickshell/user/generated/thumbnails/unified_thumb.jpg",
      "DP-2": "/home/user/.cache/quickshell/user/generated/thumbnails/unified_thumb.jpg"
    }
  }
}
```

### Example 3: Mixed Setup (Some same, some different)
```json
{
  "background": {
    "wallpaperPaths": {
      "eDP-1": "/home/user/Pictures/Wallpapers/work.jpg",
      "HDMI-A-1": "/home/user/Pictures/Wallpapers/work.jpg",  // Same as eDP-1
      "DP-2": "/home/user/Pictures/Wallpapers/gaming.jpg"     // Different
    },
    "thumbnailPaths": {
      "eDP-1": "/home/user/.cache/quickshell/user/generated/thumbnails/work_thumb.jpg",
      "HDMI-A-1": "/home/user/.cache/quickshell/user/generated/thumbnails/work_thumb.jpg",
      "DP-2": "/home/user/.cache/quickshell/user/generated/thumbnails/gaming_thumb.jpg"
    }
  }
}
```

### Example 4: With Legacy Fallback (Migration Scenario)
```json
{
  "background": {
    "wallpaperPath": "/home/user/Pictures/Wallpapers/old_default.jpg",  // Legacy single-monitor
    "wallpaperPaths": {
      "eDP-1": "/home/user/Pictures/Wallpapers/new1.jpg",
      "HDMI-A-1": "/home/user/Pictures/Wallpapers/new2.jpg"
    },
    "thumbnailPath": "/home/user/.cache/quickshell/user/generated/thumbnails/old_default_thumb.jpg",
    "thumbnailPaths": {
      "eDP-1": "/home/user/.cache/quickshell/user/generated/thumbnails/new1_thumb.jpg",
      "HDMI-A-1": "/home/user/.cache/quickshell/user/generated/thumbnails/new2_thumb.jpg"
    }
  }
}
```

## How to Edit the Config File

### Method 1: Manual Edit
```bash
# Edit with your preferred editor
nano ~/.config/illogical-impulse/config.json
# or
vim ~/.config/illogical-impulse/config.json
# or
code ~/.config/illogical-impulse/config.json
```

### Method 2: Using jq (Command Line)
```bash
# Add/update wallpaper for specific monitor
jq --arg monitor "eDP-1" --arg path "/home/user/Pictures/Wallpapers/new.jpg" \
  '.background.wallpaperPaths[$monitor] = $path' \
  ~/.config/illogical-impulse/config.json > /tmp/config.json && \
  mv /tmp/config.json ~/.config/illogical-impulse/config.json

# Remove wallpaper for specific monitor
jq 'del(.background.wallpaperPaths["HDMI-A-1"])' \
  ~/.config/illogical-impulse/config.json > /tmp/config.json && \
  mv /tmp/config.json ~/.config/illogical-impulse/config.json

# Set same wallpaper for all monitors
monitors=$(hyprctl monitors -j | jq -r '.[] | .name')
for monitor in $monitors; do
  jq --arg monitor "$monitor" --arg path "/home/user/Pictures/Wallpapers/unified.jpg" \
    '.background.wallpaperPaths[$monitor] = $path' \
    ~/.config/illogical-impulse/config.json > /tmp/config.json && \
    mv /tmp/config.json ~/.config/illogical-impulse/config.json
done
```

### Method 3: Using the Wallpaper Selector UI
1. Open wallpaper selector (default: `Super+W`)
2. Browse to wallpaper folder
3. Select monitor from dropdown:
   - "Apply to all monitors" → sets for all monitors
   - Specific monitor name → sets only for that monitor
4. Click wallpaper thumbnail

## Migration from Single-Monitor Config

If you previously had a single `wallpaperPath`, the system automatically migrates it:

**Before migration:**
```json
{
  "background": {
    "wallpaperPath": "/home/user/Pictures/Wallpapers/old.jpg",
    "thumbnailPath": "/home/user/.cache/quickshell/user/generated/thumbnails/old_thumb.jpg"
  }
}
```

**After migration (automatic):**
```json
{
  "background": {
    "wallpaperPath": "/home/user/Pictures/Wallpapers/old.jpg",
    "wallpaperPaths": {
      "eDP-1": "/home/user/Pictures/Wallpapers/old.jpg",
      "HDMI-A-1": "/home/user/Pictures/Wallpapers/old.jpg"
    },
    "thumbnailPath": "/home/user/.cache/quickshell/user/generated/thumbnails/old_thumb.jpg",
    "thumbnailPaths": {
      "eDP-1": "/home/user/.cache/quickshell/user/generated/thumbnails/old_thumb.jpg",
      "HDMI-A-1": "/home/user/.cache/quickshell/user/generated/thumbnails/old_thumb.jpg"
    }
  }
}
```

## Troubleshooting

### Monitor names not showing in dropdown?
```bash
# Check if hyprctl works
hyprctl monitors

# Verify monitor detection in quickshell logs
journalctl -f -u quickshell  # or check quickshell log file
```

### Wallpaper not applying?
1. Check file permissions: `ls -la /home/user/Pictures/Wallpapers/`
2. Verify path is correct and file exists
3. Restart quickshell after config changes

### Config changes not taking effect?
```bash
# Reload quickshell config
pkill -USR1 quickshell
# or restart quickshell
pkill -f quickshell && qs --path ~/.config/quickshell/ii
```

## Best Practices

1. **Use absolute paths** - Relative paths may not work correctly
2. **Keep thumbnails in cache** - Let the system generate them automatically
3. **Backup config before editing** - `cp ~/.config/illogical-impulse/config.json ~/.config/illogical-impulse/config.json.backup`
4. **Test with UI first** - Use the wallpaper selector to ensure paths are valid
5. **Monitor names are case-sensitive** - Use exact names from `hyprctl`