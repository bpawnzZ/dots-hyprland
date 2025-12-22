# Project Context

## Purpose
This is a Linux desktop configuration repository (dotfiles) for the Hyprland Wayland compositor. The project provides a complete desktop environment setup with configuration files, installation scripts, and management tools for a customized Hyprland-based desktop experience.

Key goals:
- Provide a reproducible, scripted setup for Hyprland desktop environment
- Support multiple Linux distributions (Arch, Fedora, Gentoo, NixOS)
- Offer modular configuration with customization options
- Include comprehensive tooling for installation, updates, and diagnostics

## Tech Stack
- **Shell scripting**: Bash for installation and management scripts
- **Configuration languages**: Various config formats (Hyprland config, TOML, INI, etc.)
- **Desktop environment**: Hyprland (Wayland compositor)
- **Package management**: Distribution-specific (pacman, dnf, emerge, nix)
- **Version control**: Git with submodules

## Project Conventions

### Code Style
- **Shell scripts**: Use `#!/usr/bin/env bash` shebang, `set -e` for error handling
- **Indentation**: 2 spaces for shell scripts
- **Naming**: kebab-case for directories and files, lowercase for config files
- **Variables**: Use uppercase for environment variables, lowercase for local variables
- **Functions**: Use descriptive names, document with comments for complex logic

### Architecture Patterns
- **Modular configuration**: Split configs into logical files (e.g., `hyprland/env.conf`, `hyprland/keybinds.conf`)
- **Customization layer**: `custom/` directory for user overrides without modifying core configs
- **Distribution abstraction**: Separate scripts and data for different Linux distributions
- **Script organization**: `sdata/` directory contains shared libraries and subcommand implementations

### Testing Strategy
- Manual testing on supported distributions
- Diagnostic script (`diagnose`) for troubleshooting
- No automated testing framework currently

### Git Workflow
- **Branching**: `main` branch for stable releases
- **Commits**: Descriptive commit messages, reference issues when applicable
- **Submodules**: Used for external dependencies (check `.gitmodules`)
- **Changes**: Use OpenSpec for proposing and tracking changes

## Domain Context
- **Hyprland**: Wayland compositor with dynamic tiling and extensive configuration
- **Dotfiles management**: Configuration files stored in `dots/` and `dots-extra/` directories
- **Multi-distro support**: Different package names and installation methods per distribution
- **Desktop components**: Includes configuration for terminal emulators (foot, kitty), application launchers (fuzzel), status bars, and various desktop utilities

## Important Constraints
- **Root/sudo usage**: Installation requires sudo for package installation
- **Distribution compatibility**: Must work across supported Linux distributions
- **User home directory**: Configs are installed to user's home directory (`~/.config/`, `~/.local/`)
- **Hyprland dependency**: Requires Hyprland to be installed and running

## External Dependencies
- **Hyprland**: Primary window compositor
- **Various desktop utilities**: foot, fuzzel, wlogout, starship, etc.
- **Linux distributions**: Arch Linux, Fedora, Gentoo, NixOS
- **Package managers**: pacman, dnf, emerge, nix
