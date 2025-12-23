#!/usr/bin/env bash

# Script to update quickshell wallpaper multi-monitor support on another machine
# This script copies all modified files from the quickshell-wallpaper-mod1 branch

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Default source directory (current location)
SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Default target directory (typical quickshell config location)
TARGET_DIR="${HOME}/.config/quickshell/ii"

# Function to print colored messages
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to check if file exists
check_file() {
    if [ ! -f "$1" ]; then
        print_error "Source file not found: $1"
        return 1
    fi
    return 0
}

# Function to create backup of existing file
backup_file() {
    local target_file="$1"
    if [ -f "$target_file" ]; then
        local backup_file="${target_file}.backup.$(date +%Y%m%d_%H%M%S)"
        cp "$target_file" "$backup_file"
        print_info "Backed up existing file to: $backup_file"
    fi
}

# Function to copy file with directory creation
copy_file() {
    local source_file="$1"
    local target_file="$2"

    # Create target directory if it doesn't exist
    local target_dir=$(dirname "$target_file")
    mkdir -p "$target_dir"

    # Backup existing file
    backup_file "$target_file"

    # Copy the file
    cp "$source_file" "$target_file"

    if [ $? -eq 0 ]; then
        print_success "Copied: $source_file → $target_file"
    else
        print_error "Failed to copy: $source_file → $target_file"
        return 1
    fi
}

# Function to initialize shapes submodule
init_shapes_submodule() {
    local shapes_dir="${TARGET_DIR}/modules/common/widgets/shapes"

    print_info "Checking shapes submodule..."

    if [ -d "$shapes_dir" ] && [ -f "$shapes_dir/.git" ]; then
        print_info "Shapes submodule already initialized"
        return 0
    fi

    print_warning "Shapes submodule not initialized or missing files"
    print_info "Initializing shapes submodule..."

    # Check if we're in a git repo
    if [ -d "${TARGET_DIR}/.git" ]; then
        cd "$shapes_dir"
        git submodule update --init --recursive
        if [ $? -eq 0 ]; then
            print_success "Shapes submodule initialized successfully"
        else
            print_error "Failed to initialize shapes submodule"
            return 1
        fi
        cd - > /dev/null
    else
        print_warning "Target directory is not a git repository. Manual shapes initialization may be needed."
        print_info "You may need to run: git submodule update --init --recursive in $shapes_dir"
    fi
}

# Main update function
update_quickshell() {
    print_info "Starting quickshell wallpaper update..."
    print_info "Source directory: $SOURCE_DIR"
    print_info "Target directory: $TARGET_DIR"
    echo ""

    # Check if target directory exists
    if [ ! -d "$TARGET_DIR" ]; then
        print_error "Target directory does not exist: $TARGET_DIR"
        print_info "Please specify the correct target directory with: $0 --target /path/to/quickshell/config"
        exit 1
    fi

    # List of files to update (relative to source directory)
    declare -a files_to_update=(
        "dots/.config/quickshell/ii/modules/common/Config.qml"
        "dots/.config/quickshell/ii/modules/ii/background/Background.qml"
        "dots/.config/quickshell/ii/modules/ii/wallpaperSelector/WallpaperSelectorContent.qml"
        "dots/.config/quickshell/ii/scripts/colors/switchwall.sh"
        "dots/.config/quickshell/ii/services/Wallpapers.qml"
    )

    # Update each file
    local success_count=0
    local total_count=${#files_to_update[@]}

    for rel_path in "${files_to_update[@]}"; do
        local source_file="${SOURCE_DIR}/${rel_path}"
        local target_file="${TARGET_DIR}/${rel_path#dots/.config/quickshell/ii/}"

        print_info "Processing: $rel_path"

        if check_file "$source_file"; then
            copy_file "$source_file" "$target_file"
            if [ $? -eq 0 ]; then
                ((success_count++))
            fi
        fi
        echo ""
    done

    # Initialize shapes submodule
    init_shapes_submodule

    echo ""
    print_info "Update summary:"
    print_info "  Files successfully updated: $success_count/$total_count"

    if [ $success_count -eq $total_count ]; then
        print_success "All files updated successfully!"
        print_info ""
        print_info "Next steps:"
        print_info "1. Restart quickshell to apply changes"
        print_info "2. Check that the wallpaper selector shows monitor dropdown (if multi-monitor)"
        print_info "3. Verify config migration worked in ~/.config/illogical-impulse/config.json"
    else
        print_warning "Some files failed to update. Check errors above."
    fi
}

# Function to show usage
show_usage() {
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Update quickshell with multi-monitor wallpaper support"
    echo ""
    echo "Options:"
    echo "  --target DIR     Specify target quickshell config directory"
    echo "                   (default: ~/.config/quickshell/ii)"
    echo "  --source DIR     Specify source directory containing updated files"
    echo "                   (default: directory where this script is located)"
    echo "  --help           Show this help message"
    echo ""
    echo "Example:"
    echo "  $0 --target /home/user/.config/quickshell/ii"
    echo "  $0 --source /path/to/dots-hyprland --target /home/user/.config/quickshell/ii"
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --target)
            TARGET_DIR="$2"
            shift 2
            ;;
        --source)
            SOURCE_DIR="$2"
            shift 2
            ;;
        --help)
            show_usage
            exit 0
            ;;
        *)
            print_error "Unknown option: $1"
            show_usage
            exit 1
            ;;
    esac
done

# Run the update
update_quickshell