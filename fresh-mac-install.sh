#!/bin/bash
# Fresh macOS Machine Setup Script
# Complete terminal environment setup from scratch

set -e  # Exit on error

echo "🚀 Setting up fresh macOS machine..."

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to print section headers
print_section() {
    echo ""
    echo -e "${BLUE}========================================${NC}"
    echo -e "${BLUE} $1${NC}"
    echo -e "${BLUE}========================================${NC}"
}

# Check if running on macOS
if [[ "$(uname)" != "Darwin" ]]; then
    echo -e "${RED}❌ Error: This script is for macOS only${NC}"
    exit 1
fi

print_section "Creating Directory Structure"
mkdir -p ~/.config/shell
mkdir -p ~/Documents/notes
mkdir -p ~/Projects
mkdir -p ~/.vim/{backup,swap,undo}
echo -e "${GREEN}✅ Directories created${NC}"

print_section "Installing Homebrew"
if ! command -v brew &> /dev/null; then
    echo -e "${YELLOW}Installing Homebrew...${NC}"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add Homebrew to PATH for Apple Silicon Macs
    if [[ $(uname -m) == "arm64" ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    else
        echo 'eval "$(/usr/local/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/usr/local/bin/brew shellenv)"
    fi
else
    echo -e "${GREEN}✅ Homebrew already installed${NC}"
fi

# Update Homebrew
brew update

print_section "Installing Essential CLI Tools"
ESSENTIAL_TOOLS=(
    # Core utilities
    "git"
    "wget"
    "curl"
    "tree"
    "jq"
    "vim"
    "tmux"
    
    # Enhanced replacements
    "htop"          # Better top
    "btop"          # Even better system monitor
    "eza"           # Better ls
    "bat"           # Better cat
    "fd"            # Better find
    "ripgrep"       # Better grep
    "fzf"           # Fuzzy finder
    "zoxide"        # Better cd
    
    # System tools
    "neofetch"      # System info
    "tldr"          # Better man pages
    "ncdu"          # Disk usage analyzer
    "duf"           # Better df
    "osx-cpu-temp"  # CPU temperature
    
    # Development essentials
    "node"          # Node.js
    "python@3.13"   # Python
    "gh"            # GitHub CLI
    
    # Zsh enhancements
    "zsh-syntax-highlighting"
    "zsh-autosuggestions"
)

for tool in "${ESSENTIAL_TOOLS[@]}"; do
    if ! brew list "$tool" &> /dev/null; then
        echo "Installing $tool..."
        brew install "$tool"
    else
        echo "✅ $tool already installed"
    fi
done

print_section "Installing Essential Applications"
ESSENTIAL_APPS=(
    "iterm2"
    "visual-studio-code"
    "rectangle"      # Window management
    "firefox"
)

for app in "${ESSENTIAL_APPS[@]}"; do
    if ! brew list --cask "$app" &> /dev/null; then
        echo "Installing $app..."
        brew install --cask "$app"
    else
        echo "✅ $app already installed"
    fi
done

print_section "Configuring Git"
echo "Setting up git configuration..."
git config --global init.defaultBranch main
git config --global core.editor vim
git config --global pull.rebase false
git config --global push.default simple
git config --global push.autoSetupRemote true

# Set user info if not already set
if [ -z "$(git config --global user.email)" ]; then
    echo -e "${YELLOW}Git user email not set. Please run:${NC}"
    echo "git config --global user.email 'your.email@example.com'"
fi

if [ -z "$(git config --global user.name)" ]; then
    echo -e "${YELLOW}Git user name not set. Please run:${NC}"
    echo "git config --global user.name 'Your Name'"
fi

print_section "Installing Dotfiles"
DOTFILES_REPO="https://github.com/nixfred/mac-bashrc.git"

if [ -d ~/dotfiles ]; then
    echo "Updating existing dotfiles..."
    cd ~/dotfiles && git pull
else
    echo "Cloning dotfiles repository..."
    git clone "$DOTFILES_REPO" ~/dotfiles
fi

# Copy dotfiles to home directory
cd ~/dotfiles
for file in .bashrc .zshrc .vimrc .tmux.conf .gitconfig .gitignore_global .inputrc; do
    if [ -f "$file" ]; then
        echo "Installing $file..."
        cp "$file" ~/
    fi
done

# Make init scripts executable
chmod +x ~/dotfiles/*.sh 2>/dev/null || true

print_section "macOS System Optimizations"
echo "Applying macOS optimizations..."

# Show hidden files in Finder
defaults write com.apple.finder AppleShowAllFiles -bool true

# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Set fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Save screenshots to Desktop
defaults write com.apple.screencapture location -string "${HOME}/Desktop"

# Show path bar in Finder
defaults write com.apple.finder ShowPathbar -bool true

# Show status bar in Finder
defaults write com.apple.finder ShowStatusBar -bool true

# Restart Finder to apply changes
killall Finder 2>/dev/null || true

print_section "Final Setup"
# Source the new shell configuration
if [ -f ~/.zshrc ]; then
    echo "Reloading zsh configuration..."
    # Note: We can't source in a script, user needs to restart terminal
fi

echo ""
echo -e "${GREEN}🎉 Setup Complete!${NC}"
echo ""
echo -e "${YELLOW}Next Steps:${NC}"
echo "1. Restart your terminal or run: source ~/.zshrc"
echo "2. Set git user info:"
echo "   git config --global user.email 'your.email@example.com'"
echo "   git config --global user.name 'Your Name'"
echo "3. Generate SSH key if needed: ssh-keygen -t ed25519 -C 'your.email@example.com'"
echo "4. Configure iTerm2 and other applications"
echo ""
echo -e "${GREEN}Enjoy your enhanced macOS terminal! 🚀${NC}"