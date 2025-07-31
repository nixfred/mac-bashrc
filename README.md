# macOS Terminal Configuration

Enhanced terminal setup for macOS with comprehensive aliases, functions, and system monitoring.

## Features

- 🎨 Beautiful login banner with system stats
- 🌤️ Weather integration (30677)
- 📊 Memory, CPU, disk monitoring
- 🚀 Productivity aliases and functions
- 📝 Todo management system
- 🧹 System cleanup utilities
- 🔐 SSH configurations

## Installation

```bash
# Clone the repository
git clone git@github.com:nixfred/mac-bashrc.git ~/dotfiles

# Run setup script
~/init/setup-mac.sh

# Or manually copy configs
cp ~/dotfiles/.bashrc ~/.bashrc
cp ~/dotfiles/.zshrc ~/.zshrc
source ~/.zshrc
```

## Key Aliases

- `c` - Clear screen
- `ll` - Detailed file listing
- `aa` - Update all (brew)
- `weather` - Quick weather
- `todo` - Task management
- `cleanup` - System cleanup
- `sysinfo` - System information

## SSH Shortcuts

- `ron` - ssh pi@100.100.111.39
- `pp` - ssh pi@pi
- `mm` - ssh macpro-bta.humpback-cloud.ts.net
- `fnix` - ssh 10.0.0.120

## Useful Functions

- `extract <file>` - Extract any archive
- `mkcd <dir>` - Create and enter directory
- `backup <file>` - Quick backup with timestamp
- `killport <port>` - Kill process on port
- `genpass [length]` - Generate secure password
- `calc <expression>` - Quick calculator

## Dotfile Management

- `upbash` - Push .bashrc updates to repo
- `downbash` - Pull .bashrc from repo
- `upzsh` - Push .zshrc updates
- `downzsh` - Pull .zshrc updates

## System Requirements

- macOS (tested on Tahoe 26.0)
- Homebrew
- Zsh or Bash