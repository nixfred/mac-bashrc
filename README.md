# 🚀 Enhanced macOS Terminal Configuration
### Version 1.0 - Production Ready

> Smart terminal environment setup for macOS with intelligent system detection, automated package management, and comprehensive dotfiles management. Featuring colorful system dashboard, portable configurations, and robust error handling.

## 📋 TLDR - Quick Install

**🧠 Smart Installation (Works for BOTH fresh AND existing machines):**

```bash
# One-line install - automatically detects your system type
curl -fsSL https://raw.githubusercontent.com/nixfred/mac-bashrc/main/fresh-mac-install.sh | bash
```

**🔄 For Existing Setups (Refresh/Update):**

```bash
# Clone once, then refresh anytime
git clone https://github.com/nixfred/mac-bashrc.git ~/dotfiles
~/dotfiles/fresh-mac-install.sh  # Intelligently updates your system
```

**⚡ Manual Dotfiles Only:**

```bash
git clone https://github.com/nixfred/mac-bashrc.git ~/dotfiles
cd ~/dotfiles
cp .bashrc .zshrc .vimrc .tmux.conf .gitconfig .gitignore_global .inputrc ~/
source ~/.zshrc
```

---

## ✨ Features

### 🧠 **Intelligent System Detection**
- **Smart Setup**: Automatically detects fresh vs existing macOS systems
- **Package Management**: Install new, upgrade outdated, skip current packages
- **Backup Protection**: Creates timestamped backups of existing configurations
- **Health Monitoring**: System health checks with actionable warnings

### 🎨 **Beautiful Colorful System Dashboard**
- **System stats**: CPU, memory, disk usage, uptime with accurate readings
- **Weather integration**: Real-time weather for your location (zipcode 30677)
- **Network info**: Internal/external IPs, load averages, SSH status
- **Homebrew status**: Package update notifications and maintenance
- **Git integration**: Repository status and branch information
- **🌈 Colorful Display**: Bright cyan headers, yellow labels, green values, magenta borders

### 🛠️ **Productivity Powerhouse**
- **200+ aliases**: Common tasks simplified (`ll`, `la`, `weather`, `cleanup`, `aa`)
- **Smart functions**: `extract`, `mkcd`, `backup`, `killport`, `genpass`, `calc`
- **Todo management**: Built-in `todo` command for task tracking
- **Git enhancements**: 20+ aliases with colored output and shortcuts
- **System maintenance**: Automated cleanup and optimization scripts

### 🔧 **Development Environment**
- **Modern CLI tools**: `bat`, `eza`, `ripgrep`, `fzf`, `htop`, `btop`, `fd`, `zoxide`
- **Language support**: Node.js, Python 3.13, Go development ready
- **Editor configs**: Enhanced Vim, Tmux, and shell configurations
- **Git workflow**: Streamlined branching, committing, and collaboration tools

---

## 📦 What Gets Installed

### 🔧 **Smart Installation Process**

**Fresh macOS Machine:**
- ✅ Installs Homebrew from scratch
- ✅ Installs all essential CLI tools and applications
- ✅ Sets up complete dotfiles configuration
- ✅ Applies macOS system optimizations

**Existing macOS Machine:**
- 🔄 Updates Homebrew and upgrades outdated packages
- 🔄 Refreshes dotfiles with automatic backup
- 🔄 Runs system health check and maintenance
- 🔄 Patches configuration gaps

### Essential CLI Tools
```
Core: git, wget, curl, tree, jq, vim, tmux
Enhanced: htop, btop, eza, bat, fd, ripgrep, fzf, zoxide
System: neofetch, tldr, ncdu, duf, osx-cpu-temp
Dev: node, python@3.13, gh (GitHub CLI)
Shell: zsh-syntax-highlighting, zsh-autosuggestions
```

### Applications (via Homebrew Cask)
```
iTerm2, Visual Studio Code, Rectangle, Firefox
```

### Complete Dotfiles Suite
- **`.bashrc`** / **`.zshrc`** - Enhanced shells with intelligent system dashboard
- **`.vimrc`** - Modern Vim configuration with backup/undo management
- **`.tmux.conf`** - Tmux with better key bindings, mouse support, and styling
- **`.gitconfig`** - 20+ Git aliases, colors, and workflow optimizations
- **`.gitignore_global`** - Comprehensive ignore patterns for all projects
- **`.inputrc`** - Enhanced bash/readline completion and Vi mode
- **`.env.local.template`** - Secure environment variable template

---

## 🎯 Key Commands

### 🏠 **System & Productivity**
```bash
c               # Clear screen
ll              # Detailed file listing with colors and sizes
la              # List all files including hidden
weather         # Show current weather (30677)
forecast        # Detailed weather forecast
cleanup         # Deep system cleanup (caches, logs, temp files)
aa              # Update all Homebrew packages
sysinfo         # Detailed system information and specs
ports           # Show listening network ports
listening 3000  # Check what's listening on specific port
```

### 📁 **File Operations**
```bash
extract <file>      # Extract any archive format (zip, tar, etc.)
mkcd <dir>          # Create directory and cd into it
backup <file>       # Create timestamped backup copy
ff <pattern>        # Find files by name pattern
dirsize             # Show directory sizes sorted
tree                # Display directory tree structure
```

### ⚡ **Development & Git**
```bash
gs              # git status
ga              # git add
gc              # git commit
gp              # git push
gl              # git pull
glog            # Pretty git log graph with branches
gco             # git checkout
gcm "msg"       # git commit -m "message"
undo            # git reset --soft HEAD~1
killport 3000   # Kill process running on port 3000
serve           # Start HTTP server in current directory
calc "2+2*3"    # Quick calculator
genpass 20      # Generate secure 20-char password
```

### ✅ **Todo Management**
```bash
todo add "Task description"    # Add new task with timestamp
todo list                      # Show all tasks numbered
todo done 1                    # Mark task 1 as complete
todo clear                     # Clear all tasks
```

### 🔧 **System Utilities**
```bash
~/dotfiles/fresh-mac-install.sh    # Smart system refresh/setup
~/dotfiles/audit-cleanup.sh        # Remove unnecessary packages
~/dotfiles/cleanup.sh              # Deep system cleanup
upzsh                              # Push .zshrc changes to Git
downzsh                            # Pull .zshrc updates from Git
```

---

## 🔧 Configuration

### 🏠 **Portable Configuration System**

This repository is now **machine-agnostic**! The dotfiles work on any Mac without hardcoded paths or personal data.

#### **Template-Based Setup**
- **`.bashrc.template`** - Portable bash configuration (configurable zipcode, no hardcoded SSH aliases)
- **`.zshrc.template`** - Portable zsh configuration (configurable zipcode, no hardcoded SSH aliases)
- **Personal files** (kept private, not in git):
  - `~/.bashrc.personal` - Your SSH shortcuts and personal aliases
  - `~/.env.local` - API keys and sensitive environment variables

#### **First-Time Setup on Any Mac**
1. **Set your weather location**:
```bash
echo 'export WEATHER_ZIPCODE="30677"' >> ~/.env.local
```

2. **Add your SSH shortcuts**:
```bash
cat > ~/.bashrc.personal << 'EOF'
# Personal SSH shortcuts
alias myserver='ssh user@hostname'
alias prod='ssh user@production-server'
EOF
```

3. **Copy your API keys to `~/.env.local`**:
```bash
export OPENAI_API_KEY="your-key-here"
export GITHUB_TOKEN="your-token-here"
# etc...
```

> ✅ **Privacy**: Personal data stays in `~/.bashrc.personal` and `~/.env.local` (git-ignored)  
> ✅ **Portable**: Template files work on any Mac without modification  
> ✅ **Secure**: No sensitive data in public repository

### 🔐 **Environment Variables** (Secure Setup)
1. **Copy the template**: `cp ~/dotfiles/.env.local.template ~/.env.local`
2. **Edit with your API keys and tokens**:
```bash
export OPENAI_API_KEY="your-key-here"
export GITHUB_TOKEN="your-token-here"
export AWS_ACCESS_KEY_ID="your-aws-key"
# etc...
```
> ⚠️ `.env.local` is automatically excluded from git commits for security

### ⚙️ **Git Setup** (Automated Check)
The smart install script checks your git config automatically:
```bash
git config --global user.email "your.email@example.com"
git config --global user.name "Your Name"
```

### 🔑 **SSH Key Generation** (With Health Check)
```bash
ssh-keygen -t ed25519 -C "your.email@example.com"
pbcopy < ~/.ssh/id_ed25519.pub  # Copy public key
# Add to GitHub: Settings → SSH Keys
```
> 💡 The install script will warn you if no SSH keys are found

### 📍 **Weather Location** (Custom Zipcode)
Set your zipcode in the portable configuration:
```bash
# Add to ~/.env.local (private, get your zipcode from weather.com)
echo 'export WEATHER_ZIPCODE="30677"' >> ~/.env.local
```
> The templates automatically use `$WEATHER_ZIPCODE` variable, defaulting to 30677 if not set

---

## 🎉 Version 1.0 New Features

### 🌈 **Colorful System Dashboard**
- Beautiful bright cyan headers with emoji icons
- Yellow labels and green values for easy reading
- Magenta borders for professional appearance
- Enhanced visual feedback on system status

### 🛠️ **Enhanced Error Handling**
- Comprehensive error handling in all scripts
- Graceful degradation when components fail
- Clear user feedback on partial failures
- Dynamic version detection with fallbacks

### 📱 **User Experience Improvements**
- `sudo EDITOR=nano visudo` for easy editing (Ctrl+O to save, Ctrl+X to exit)
- Better installation feedback and progress tracking
- Automatic detection of fresh vs existing systems
- Improved health check warnings

### 🔧 **Technical Enhancements**
- Dynamic NVM version detection with fallback
- Better package dependency checking
- Individual tool verification before operations
- Robust cleanup processes with error recovery

---

## 🧹 System Maintenance

### Cleanup Unnecessary Packages
```bash
~/dotfiles/audit-cleanup.sh    # Interactive cleanup
```

### Keep System Updated
```bash
aa                    # Update Homebrew packages
~/dotfiles/cleanup.sh # Deep system cleanup
```

### Backup Your Dotfiles
The repository includes aliases for syncing your dotfiles:
```bash
upbash              # Push .bashrc changes to GitHub
upzsh               # Push .zshrc changes to GitHub
downbash            # Pull .bashrc from GitHub
downzsh             # Pull .zshrc from GitHub
```

---

## 📱 System Requirements

- **macOS**: 10.15+ (tested on Sequoia 15.x, Tahoe 26.x)
- **Architecture**: Intel x64 and Apple Silicon (arm64) supported
- **Homebrew**: Automatically installed by setup script (or updated if present)
- **Shell**: Zsh (default) or Bash - both fully supported
- **Git**: For dotfiles management and updates
- **Internet**: For package installations, weather, and repository updates

## 🧠 Smart Features

### **Intelligent System Detection**
The setup script automatically detects your system state:
- **Fresh macOS**: Full installation with Homebrew setup
- **Existing setup**: Refresh/update mode with package upgrades
- **Dotfiles present**: Automatic backup before replacement
- **Missing components**: Installs only what's needed

### **Automatic Package Management**
- **New packages**: Installs missing tools
- **Outdated packages**: Upgrades to latest versions  
- **Current packages**: Skips to save time
- **Maintenance**: Automatic cleanup and autoremove

### **System Health Monitoring**
- **SSH keys**: Warns if none found
- **VS Code**: Checks CLI tool installation
- **Zsh plugins**: Validates syntax highlighting
- **Git config**: Ensures proper user setup

---

## 🎨 Customization

### **Personal Configuration**
Use the portable system for all customizations:

1. **Weather Location**:
```bash
echo 'export WEATHER_ZIPCODE="30677"' >> ~/.env.local
```

2. **SSH Shortcuts**:
```bash
echo 'alias prod="ssh user@prod-server"' >> ~/.bashrc.personal
```

3. **Custom Aliases**:
```bash
echo 'alias ll="ls -la"' >> ~/.bashrc.personal
```

### **Color Themes**
The configuration uses standard terminal colors. For advanced theming:
1. Install iTerm2 color schemes
2. Configure terminal.app themes  
3. Modify prompt colors in shell template files

> 💡 **Personal files** (`~/.bashrc.personal`, `~/.env.local`) are git-ignored for privacy

---

## 🐛 Troubleshooting

### Permission Issues
```bash
chmod +x ~/dotfiles/*.sh
```

### Homebrew Path Issues
```bash
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
source ~/.zprofile
```

### Shell Not Updating
```bash
source ~/.zshrc        # For zsh
source ~/.bashrc       # For bash
```

### Git Issues
```bash
git config --global --list  # Check current config
git config --global init.defaultBranch main
```

---

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch: `git checkout -b feature/amazing-feature`
3. Commit your changes: `git commit -m 'Add amazing feature'`
4. Push to the branch: `git push origin feature/amazing-feature`
5. Open a Pull Request

---

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

---

## 🙏 Acknowledgments

- Inspired by the Unix philosophy of simple, composable tools
- Built for the modern macOS developer workflow
- Community-driven improvements and suggestions welcome

---

## 📈 Version History

### Version 1.0 (July 2025) - Production Ready 🎉
- 🌈 **Colorful system dashboard** with emoji icons and bright colors
- 🛠️ **Enhanced error handling** and graceful degradation  
- 📱 **Improved UX** with nano visudo support (`Ctrl+O` save, `Ctrl+X` exit)
- 🔧 **Dynamic version detection** and robust cleanup processes
- 🐛 **Comprehensive bug fixes** and syntax validation
- 🏠 **Portable configuration system** with template files
- 📊 **Smart installation** detection (fresh vs existing systems)

### Initial Release (July 2025)
- Smart installation for fresh and existing macOS systems
- Comprehensive dotfiles management with backup protection
- Automated Homebrew package management
- System health monitoring and macOS optimizations

**Enjoy your enhanced macOS terminal experience! 🚀🎉**