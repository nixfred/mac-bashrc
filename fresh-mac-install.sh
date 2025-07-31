#!/bin/bash
# Smart macOS Terminal Setup Script
# Handles both fresh machines and existing setups with intelligent refresh

set -e  # Exit on error

echo "🚀 Smart macOS Terminal Setup - Analyzing your system..."

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Function to print section headers
print_section() {
    echo ""
    echo -e "${BLUE}========================================${NC}"
    echo -e "${BLUE} $1${NC}"
    echo -e "${BLUE}========================================${NC}"
}

# Function to print status
print_status() {
    echo -e "${CYAN}ℹ️  $1${NC}"
}

# Function to print success
print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

# Function to print warning
print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

# Check if running on macOS
if [[ "$(uname)" != "Darwin" ]]; then
    echo -e "${RED}❌ Error: This script is for macOS only${NC}"
    exit 1
fi

# Detect system state
HOMEBREW_INSTALLED=false
DOTFILES_EXIST=false
FRESH_INSTALL=true

if command -v brew &> /dev/null; then
    HOMEBREW_INSTALLED=true
    FRESH_INSTALL=false
    print_status "Homebrew detected - this appears to be an existing system"
fi

if [ -d ~/dotfiles ] || [ -f ~/.bashrc ] || [ -f ~/.zshrc ]; then
    DOTFILES_EXIST=true
    FRESH_INSTALL=false
    print_status "Existing dotfiles detected - will refresh/update"
fi

if $FRESH_INSTALL; then
    print_status "Fresh macOS system detected - full installation mode"
else
    print_status "Existing system detected - refresh/update mode"
fi

print_section "Creating Directory Structure"
mkdir -p ~/.config/shell
mkdir -p ~/Documents/notes
mkdir -p ~/Projects
mkdir -p ~/.vim/{backup,swap,undo}
print_success "Directory structure ready"

print_section "Homebrew Setup"
if $HOMEBREW_INSTALLED; then
    print_status "Homebrew already installed - updating..."
    brew update
    print_success "Homebrew updated"
else
    print_status "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add Homebrew to PATH for Apple Silicon Macs
    if [[ $(uname -m) == "arm64" ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    else
        echo 'eval "$(/usr/local/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/usr/local/bin/brew shellenv)"
    fi
    print_success "Homebrew installed and configured"
fi

print_section "Essential CLI Tools"
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

INSTALLED_COUNT=0
UPDATED_COUNT=0
SKIPPED_COUNT=0

for tool in "${ESSENTIAL_TOOLS[@]}"; do
    if brew list "$tool" &> /dev/null; then
        if $HOMEBREW_INSTALLED; then
            # Check if outdated and upgrade if needed
            if brew outdated | grep -q "^$tool"; then
                echo "Upgrading $tool..."
                brew upgrade "$tool"
                ((UPDATED_COUNT++))
            else
                echo "✅ $tool (up to date)"
                ((SKIPPED_COUNT++))
            fi
        else
            echo "✅ $tool already installed"
            ((SKIPPED_COUNT++))
        fi
    else
        echo "Installing $tool..."
        brew install "$tool"
        ((INSTALLED_COUNT++))
    fi
done

print_success "CLI Tools: $INSTALLED_COUNT installed, $UPDATED_COUNT updated, $SKIPPED_COUNT already current"

print_section "Essential Applications"
ESSENTIAL_APPS=(
    "iterm2"
    "visual-studio-code"
    "rectangle"      # Window management
    "firefox"
)

APP_INSTALLED_COUNT=0
APP_SKIPPED_COUNT=0

for app in "${ESSENTIAL_APPS[@]}"; do
    if brew list --cask "$app" &> /dev/null; then
        echo "✅ $app already installed"
        ((APP_SKIPPED_COUNT++))
    else
        echo "Installing $app..."
        brew install --cask "$app"
        ((APP_INSTALLED_COUNT++))
    fi
done

print_success "Applications: $APP_INSTALLED_COUNT installed, $APP_SKIPPED_COUNT already present"

# Cleanup outdated packages
if $HOMEBREW_INSTALLED; then
    print_section "Homebrew Maintenance"
    print_status "Cleaning up outdated packages..."
    brew cleanup
    brew autoremove
    print_success "Homebrew maintenance complete"
fi

print_section "Git Configuration"
# Always ensure git is properly configured
git config --global init.defaultBranch main
git config --global core.editor vim
git config --global pull.rebase false
git config --global push.default simple
git config --global push.autoSetupRemote true

# Check if user info is set
GIT_EMAIL=$(git config --global user.email || echo "")
GIT_NAME=$(git config --global user.name || echo "")

if [ -z "$GIT_EMAIL" ] || [ -z "$GIT_NAME" ]; then
    print_warning "Git user info not complete. Current settings:"
    echo "  Email: ${GIT_EMAIL:-'(not set)'}"
    echo "  Name: ${GIT_NAME:-'(not set)'}"
    echo ""
    echo "To set your git identity:"
    echo "  git config --global user.email 'your.email@example.com'"
    echo "  git config --global user.name 'Your Name'"
else
    print_success "Git configured for: $GIT_NAME <$GIT_EMAIL>"
fi

print_section "Dotfiles Installation"
DOTFILES_REPO="https://github.com/nixfred/mac-bashrc.git"

if [ -d ~/dotfiles ]; then
    print_status "Updating existing dotfiles repository..."
    cd ~/dotfiles
    git stash push -m "Auto-stash before update $(date)" 2>/dev/null || true
    git pull origin main
    print_success "Dotfiles repository updated"
else
    print_status "Cloning dotfiles repository..."
    git clone "$DOTFILES_REPO" ~/dotfiles
    print_success "Dotfiles repository cloned"
fi

# Backup existing dotfiles if they exist
BACKUP_DIR=~/dotfiles_backup_$(date +%Y%m%d_%H%M%S)
BACKED_UP_FILES=()

cd ~/dotfiles
for file in .bashrc .zshrc .vimrc .tmux.conf .gitconfig .gitignore_global .inputrc; do
    if [ -f "$file" ]; then
        # Check if home file exists and is different
        if [ -f ~/"$file" ] && ! cmp -s "$file" ~/"$file" 2>/dev/null; then
            # Create backup directory only when needed
            if [ ${#BACKED_UP_FILES[@]} -eq 0 ]; then
                mkdir -p "$BACKUP_DIR"
                print_status "Creating backup at $BACKUP_DIR"
            fi
            cp ~/"$file" "$BACKUP_DIR/"
            BACKED_UP_FILES+=("$file")
        fi
        
        print_status "Installing $file..."
        cp "$file" ~/
    fi
done

if [ ${#BACKED_UP_FILES[@]} -gt 0 ]; then
    print_warning "Backed up ${#BACKED_UP_FILES[@]} existing files to $BACKUP_DIR"
    printf '  %s\n' "${BACKED_UP_FILES[@]}"
fi

# Handle environment template
if [ ! -f ~/.env.local ] && [ -f ~/dotfiles/.env.local.template ]; then
    print_status "Creating .env.local from template..."
    cp ~/dotfiles/.env.local.template ~/.env.local
    print_warning "Please edit ~/.env.local with your API keys and tokens"
fi

# Make scripts executable
chmod +x ~/dotfiles/*.sh 2>/dev/null || true
print_success "Dotfiles installation complete"

print_section "macOS System Optimizations"
print_status "Applying macOS optimizations..."

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

print_success "macOS optimizations applied"

print_section "System Health Check"
# Quick system health check
WARNINGS=()

# Check for common issues
if ! command -v code &> /dev/null && brew list --cask visual-studio-code &> /dev/null; then
    WARNINGS+=("VS Code command line tools not in PATH - run 'code' command in VS Code to install")
fi

if [ ! -f ~/.ssh/id_ed25519 ] && [ ! -f ~/.ssh/id_rsa ]; then
    WARNINGS+=("No SSH keys found - consider generating one: ssh-keygen -t ed25519 -C 'your.email@example.com'")
fi

# Check zsh plugins
if [ ! -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    WARNINGS+=("Zsh syntax highlighting may not be working - check Homebrew installation")
fi

if [ ${#WARNINGS[@]} -gt 0 ]; then
    print_warning "System health check found ${#WARNINGS[@]} items to review:"
    printf '  • %s\n' "${WARNINGS[@]}"
else
    print_success "System health check passed"
fi

print_section "Installation Summary"
echo ""
echo -e "${GREEN}🎉 Setup Complete!${NC}"
echo ""
if $FRESH_INSTALL; then
    echo -e "${CYAN}Fresh Installation Summary:${NC}"
else
    echo -e "${CYAN}Refresh/Update Summary:${NC}"
fi

echo "📦 CLI Tools: $INSTALLED_COUNT installed, $UPDATED_COUNT updated"
echo "🚀 Applications: $APP_INSTALLED_COUNT installed"
echo "⚙️  Dotfiles: Refreshed and configured"
echo "🖥️  System: macOS optimizations applied"

if [ ${#BACKED_UP_FILES[@]} -gt 0 ]; then
    echo "💾 Backup: ${#BACKED_UP_FILES[@]} files saved to $(basename "$BACKUP_DIR")"
fi

echo ""
echo -e "${YELLOW}Next Steps:${NC}"
echo "1. Restart your terminal or run: source ~/.zshrc"
if [ -z "$GIT_EMAIL" ] || [ -z "$GIT_NAME" ]; then
    echo "2. Set git user info:"
    echo "   git config --global user.email 'your.email@example.com'"
    echo "   git config --global user.name 'Your Name'"
fi
echo "3. Edit ~/.env.local with your API keys if needed"
echo "4. Generate SSH key if needed: ssh-keygen -t ed25519 -C 'your.email@example.com'"
echo "5. Configure iTerm2 and other applications to your preference"

if [ ${#WARNINGS[@]} -gt 0 ]; then
    echo ""
    echo -e "${YELLOW}💡 Review the health check warnings above${NC}"
fi

echo ""
echo -e "${GREEN}Enjoy your enhanced macOS terminal! 🚀${NC}"
echo -e "${CYAN}Repository: https://github.com/nixfred/mac-bashrc${NC}"