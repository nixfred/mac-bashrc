# 🚀 Enhanced macOS Terminal Configuration

> Complete terminal environment setup for macOS with system monitoring, productivity tools, and modern CLI utilities.

## 📋 TLDR - Quick Install

**For a fresh macOS machine:**

```bash
# One-line install (sets up everything)
curl -fsSL https://raw.githubusercontent.com/nixfred/mac-bashrc/main/fresh-mac-install.sh | bash

# Or manual install:
git clone https://github.com/nixfred/mac-bashrc.git ~/dotfiles
~/dotfiles/fresh-mac-install.sh
```

**For existing machines with Homebrew:**

```bash
git clone https://github.com/nixfred/mac-bashrc.git ~/dotfiles
cd ~/dotfiles
cp .bashrc .zshrc .vimrc .tmux.conf .gitconfig .gitignore_global .inputrc ~/
source ~/.zshrc
```

---

## ✨ Features

### 🎨 Beautiful System Dashboard
- **System stats**: CPU, memory, disk usage, uptime
- **Weather integration**: Automatically shows local weather
- **Network info**: Internal/external IPs, load averages
- **Homebrew status**: Package update notifications
- **Git integration**: Repository status in working directories

### 🛠️ Productivity Tools
- **200+ aliases**: Common tasks simplified (`ll`, `la`, `weather`, `cleanup`)
- **Smart functions**: `extract`, `mkcd`, `backup`, `killport`, `genpass`
- **Todo management**: Built-in `todo` command for task tracking
- **Git enhancements**: Powerful aliases and colored output
- **System cleanup**: Automated maintenance scripts

### 🔧 Development Environment
- **Modern CLI tools**: `bat`, `eza`, `ripgrep`, `fzf`, `htop`, `btop`
- **Language support**: Node.js, Python, Go development ready
- **Editor configs**: Enhanced Vim and Tmux configurations
- **Git workflow**: Streamlined branching, committing, and collaboration

---

## 📦 What Gets Installed

### Essential CLI Tools
```
git, wget, curl, tree, jq, vim, tmux
htop, btop, eza, bat, fd, ripgrep, fzf, zoxide
neofetch, tldr, ncdu, duf, osx-cpu-temp
node, python, gh (GitHub CLI)
zsh-syntax-highlighting, zsh-autosuggestions
```

### Applications (via Homebrew Cask)
```
iTerm2, Visual Studio Code, Rectangle, Firefox
```

### Dotfiles Included
- **`.bashrc`** / **`.zshrc`** - Enhanced shell with system dashboard
- **`.vimrc`** - Modern Vim configuration with sensible defaults
- **`.tmux.conf`** - Tmux with better key bindings and styling
- **`.gitconfig`** - Comprehensive Git aliases and colors
- **`.gitignore_global`** - Global ignore patterns for all projects
- **`.inputrc`** - Enhanced bash/readline completion

---

## 🎯 Key Commands

### System & Productivity
```bash
c               # Clear screen
ll              # Detailed file listing with colors
la              # List all files including hidden
weather         # Show current weather
forecast        # Detailed weather forecast
cleanup         # System cleanup (caches, logs, etc.)
aa              # Update all Homebrew packages
sysinfo         # Detailed system information
ports           # Show listening network ports
```

### File Operations
```bash
extract <file>      # Extract any archive format
mkcd <dir>          # Create directory and cd into it
backup <file>       # Create timestamped backup
ff <pattern>        # Find files by name
fd <pattern>        # Find directories by name
```

### Development
```bash
gs              # git status
ga              # git add
gc              # git commit
gp              # git push
gl              # git pull
glog            # Pretty git log graph
killport 3000   # Kill process running on port 3000
serve           # Start HTTP server in current directory
```

### Todo Management
```bash
todo add "Task description"    # Add new task
todo list                      # Show all tasks
todo done 1                    # Mark task 1 as complete
todo clear                     # Clear all tasks
```

---

## 🔧 Configuration

### Environment Variables
1. Copy the template: `cp ~/dotfiles/.env.local.template ~/.env.local`
2. Edit with your API keys and tokens:
```bash
export OPENAI_API_KEY="your-key-here"
export GITHUB_TOKEN="your-token-here"
# etc...
```

### Git Setup
```bash
git config --global user.email "your.email@example.com"
git config --global user.name "Your Name"
```

### SSH Key Generation
```bash
ssh-keygen -t ed25519 -C "your.email@example.com"
pbcopy < ~/.ssh/id_ed25519.pub  # Copy public key
# Add to GitHub: Settings → SSH Keys
```

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

- **macOS**: 10.15+ (tested on Sequoia/Tahoe)
- **Homebrew**: Automatically installed by setup script
- **Zsh**: Default shell (also supports Bash)
- **Git**: For dotfiles management
- **Internet**: For package installations and weather

---

## 🎨 Customization

### Weather Location
Edit the zipcode in `.bashrc` and `.zshrc`:
```bash
# Change 30677 to your zipcode
WEATHER=$(curl -s --max-time 2 "wttr.in/YOUR_ZIPCODE?format=%C+%t" 2>/dev/null || echo "N/A")
```

### Color Themes
The configuration uses standard terminal colors. For advanced theming:
1. Install iTerm2 color schemes
2. Configure terminal.app themes
3. Modify prompt colors in shell configs

### Adding Custom Aliases
Add to `.bashrc` or `.zshrc`:
```bash
alias myalias='command here'
```

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

**Enjoy your enhanced terminal experience! 🎉**