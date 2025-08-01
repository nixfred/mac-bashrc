# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a comprehensive macOS dotfiles repository that provides an enhanced terminal environment with intelligent system detection, automated package management, and multi-machine synchronization capabilities. The repository uses a portable configuration system with template-based dotfiles that work across different Mac machines.

## Architecture

### Configuration System
- **Template Files**: `.bashrc.template`, `.zshrc.template` - Portable configurations that work on any Mac
- **Active Files**: `.bashrc`, `.zshrc`, `.bash_profile` - Working configurations copied from templates
- **Personal Files**: `~/.bashrc.personal`, `~/.env.local` - Machine-specific settings (git-ignored)
- **System Dashboard**: Colorful terminal banner showing system stats, weather, network info, and Git status

### Multi-Machine Sync
- **Repository Structure**: Git-based dotfiles management with SSH authentication
- **Sync Commands**: `syncup`, `syncdown`, `syncstatus` for quick synchronization
- **Git Integration**: Enhanced `gitcommit`/`gitc` function with automatic push/pull detection
- **Machine Isolation**: Personal data stays local while configurations sync globally

### Bash Enhancement Features
- **Modern Bash Support**: Auto-detection and switching from macOS bash 3.2 to Homebrew bash 5.3+
- **Completion System**: Enhanced directory completion and programmable completion
- **System Integration**: Weather API, Homebrew status, system monitoring
- **Development Tools**: 200+ aliases, Git shortcuts, todo management

## Common Commands

### Dotfiles Management
```bash
syncup          # Copy local configs to repo, commit, and push
syncdown        # Pull repo changes and apply to local configs  
syncstatus      # Check git status of dotfiles repo
gitc "message"  # Enhanced git commit with auto-push/pull detection
```

### System Maintenance
```bash
aa              # Update all Homebrew packages
cleanup         # Deep system cleanup (caches, logs, temp files)
sysinfo         # System information and hardware specs
weather         # Current weather for configured zipcode
```

### Development Workflow
```bash
ll              # Enhanced file listing with colors
mkcd <dir>      # Create directory and cd into it
extract <file>  # Extract any archive format
killport 3000   # Kill process on specific port
genpass 20      # Generate secure password
```

### Setup and Installation
```bash
./fresh-mac-install.sh    # Smart system setup (fresh or existing Mac)
./audit-cleanup.sh        # Remove unnecessary packages
```

## Key Files and Their Purpose

### Core Configuration Files
- `.bashrc` - Main bash configuration with system dashboard, aliases, and functions
- `.bash_profile` - Bash login configuration with auto-switch to modern bash
- `.zshrc` - Zsh configuration (mirrors bash functionality)
- `.gitconfig` - Git configuration with 20+ aliases and workflow optimizations

### System Integration
- `fresh-mac-install.sh` - Intelligent installation script with system detection
- `audit-cleanup.sh` - Interactive cleanup for unnecessary packages
- `dev-tools.sh` - Development environment setup

### Template System
- `.bashrc.template` - Portable bash configuration without hardcoded values
- `.env.local.template` - Template for environment variables and API keys

## Important Implementation Details

### Bash Version Management
The system automatically detects and switches from macOS's old bash (3.2.57) to modern Homebrew bash (5.3+) for better completion and features. The auto-switch logic is in `.bash_profile`.

### Directory Completion Issues
Common issues with cd autocomplete are typically related to:
1. Using old bash version (solved by auto-switch)
2. Bash completion not properly loaded (handled in AUTO-COMPLETION section)
3. Missing `cdspell` and `autocd` options (enabled in configuration)

### System Dashboard
The colorful terminal banner (`print_fun_banner` function) displays real-time system information including:
- Host, macOS version, network IPs
- System load, disk usage, memory statistics  
- Homebrew status, weather data, last login info
- Proper alignment using printf formatting with fixed-width fields

### Git Integration
The `gitcommit`/`gitc` function provides intelligent Git workflow:
- Auto-commits modified tracked files
- Checks for commits to push/pull
- Interactive pull prompts for safety
- Status reporting with emoji indicators

### Personal Configuration
Machine-specific settings are isolated in:
- `~/.env.local` - API keys, weather zipcode, sensitive data
- `~/.bashrc.personal` - SSH shortcuts, personal aliases
These files are git-ignored to maintain privacy while syncing configurations.

## Development Workflow

When making changes to this repository:
1. Test changes locally first
2. Use `syncup` to commit and push changes
3. Use `syncdown` on other machines to apply updates
4. Personal configurations stay in `~/.env.local` and `~/.bashrc.personal`
5. Template files should remain portable (no hardcoded paths/data)

## Architecture Benefits
- **Portable**: Works on any Mac without modification
- **Secure**: Personal data never committed to repository
- **Intelligent**: Auto-detects system state and adapts accordingly
- **Maintainable**: Clean separation between synced and local configurations
- **Enhanced**: Modern bash features with completion and productivity tools