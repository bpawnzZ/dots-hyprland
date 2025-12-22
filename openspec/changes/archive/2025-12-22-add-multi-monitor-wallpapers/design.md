## Context
Quickshell is a desktop shell for Hyprland that currently supports single-monitor wallpaper configuration. The infrastructure for multi-monitor support already exists (`Quickshell.screens` enumeration, per-screen background instances, monitor detection via `Hyprland.monitorFor()`), but wallpaper configuration is global.

## Goals / Non-Goals

### Goals:
- Allow users to set different wallpapers for different monitors
- Maintain backward compatibility for single-monitor setups
- Provide intuitive UI for monitor-specific wallpaper assignment
- Support both static images and video wallpapers per monitor
- Handle dynamic monitor changes (hotplugging)

### Non-Goals:
- Automatic wallpaper slideshows per monitor
- Complex wallpaper layouts spanning multiple monitors
- Wallpaper synchronization across monitors
- Third-party wallpaper service integration

## Decisions

### Decision 1: Configuration Structure
**What**: Store wallpaper paths as a map from monitor name to wallpaper path
**Why**: Monitor names (e.g., "eDP-1", "HDMI-A-1") are stable identifiers from Hyprland. Using a map allows easy lookup and modification per monitor.
**Alternatives considered**:
- Array indexed by monitor order: Unstable when monitors are reordered
- Complex nested structure: Overly complex for simple key-value mapping

### Decision 2: Migration Strategy
**What**: On first run, migrate existing `wallpaperPath` to apply to all detected monitors
**Why**: Preserves user's current wallpaper across all monitors, providing a smooth transition
**Alternatives considered**:
- Reset configuration: Would lose user's current wallpaper
- Apply to primary monitor only: Could leave other monitors blank

### Decision 3: UI Approach
**What**: Extend existing wallpaper selector with monitor selection dropdown
**Why**: Minimal UI changes, leverages existing selector patterns
**Alternatives considered**:
- Separate wallpaper selector per monitor: More complex UI
- Drag-and-drop assignment: Requires significant UI redesign

### Decision 4: Script Modification
**What**: Update `switchwall.sh` to accept monitor parameter and apply to specific monitor
**Why**: Shell script already handles wallpaper application; needs monitor awareness
**Alternatives considered**:
- New script per monitor: Duplicates logic
- Pure QML solution: Loses shell script flexibility for image processing

## Risks / Trade-offs

### Risk: Monitor Name Stability
**Risk**: Hyprland monitor names could change between sessions
**Mitigation**: Use `hyprctl monitors` to detect current names and update config if needed

### Risk: Configuration Complexity
**Risk**: Per-monitor config increases configuration complexity
**Mitigation**: Provide sensible defaults and clear UI for management

### Trade-off: Performance vs Flexibility
**Trade-off**: Loading different wallpapers per monitor increases memory usage
**Mitigation**: Wallpapers are already loaded per-screen; minimal additional overhead

## Migration Plan

1. **Backup existing config**: Copy current wallpaper configuration
2. **Migration on startup**: Detect existing single `wallpaperPath` and migrate to per-monitor map
3. **UI updates**: Add monitor selection to wallpaper picker
4. **Script updates**: Modify `switchwall.sh` to handle monitor parameter
5. **Testing**: Verify on single and multi-monitor setups

## Open Questions
- Should there be a "Apply to all monitors" option in the UI?
- How to handle monitors added after initial configuration?
- Should video wallpapers have per-monitor thumbnails?