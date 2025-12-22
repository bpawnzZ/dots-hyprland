## ADDED Requirements
### Requirement: Per-Monitor Wallpaper Configuration
The system SHALL store wallpaper configuration per monitor using monitor names as keys.

#### Scenario: Configuring different wallpapers for multiple monitors
- **WHEN** a user has multiple monitors connected
- **AND** they set different wallpapers for each monitor
- **THEN** the configuration stores each wallpaper path keyed by monitor name
- **AND** each monitor displays its assigned wallpaper

#### Scenario: Single monitor setup compatibility
- **WHEN** a user has only one monitor
- **AND** they set a wallpaper
- **THEN** the configuration stores the wallpaper for that monitor
- **AND** the wallpaper displays correctly

### Requirement: Monitor Detection for Wallpaper Assignment
The system SHALL detect available monitors and their names for wallpaper assignment.

#### Scenario: Detecting monitors at startup
- **WHEN** quickshell starts
- **THEN** it detects all connected monitors via Hyprland
- **AND** makes monitor names available for wallpaper configuration

#### Scenario: Handling monitor hotplugging
- **WHEN** a new monitor is connected
- **THEN** the system detects the new monitor
- **AND** allows wallpaper assignment to the new monitor

### Requirement: Wallpaper Selector with Monitor Targeting
The wallpaper selector UI SHALL allow users to target specific monitors for wallpaper assignment.

#### Scenario: Selecting wallpaper for specific monitor
- **WHEN** a user opens the wallpaper selector
- **THEN** they can choose which monitor to apply the wallpaper to
- **AND** the selected wallpaper applies only to that monitor

#### Scenario: Applying wallpaper to all monitors
- **WHEN** a user wants the same wallpaper on all monitors
- **THEN** they can select "Apply to all monitors" option
- **AND** the wallpaper applies to every connected monitor

## MODIFIED Requirements
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