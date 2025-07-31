#!/bin/bash
# Development Tools Setup for macOS
# Install and configure essential development tools

echo "🛠️  Setting up development environment..."

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Development tools via Homebrew
DEVTOOLS=(
    "docker"
    "docker-compose"
    "postman"
    "insomnia"
    "ngrok"
    "yarn"
    "nvm"
    "pyenv"
    "rbenv"
    "go"
    "rust"
    "deno"
    "bun"
)

echo -e "${YELLOW}Installing development tools...${NC}"
for tool in "${DEVTOOLS[@]}"; do
    if ! brew list "$tool" &> /dev/null && ! brew list --cask "$tool" &> /dev/null; then
        echo "Installing $tool..."
        brew install "$tool" 2>/dev/null || brew install --cask "$tool"
    else
        echo "$tool already installed"
    fi
done

# Programming language version managers
echo -e "${YELLOW}Setting up language version managers...${NC}"

# Node.js via nvm
if [ ! -d ~/.nvm ]; then
    # Get latest nvm version dynamically, fallback to known good version
    NVM_VERSION=$(curl -s https://api.github.com/repos/nvm-sh/nvm/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/' 2>/dev/null || echo "v0.39.7")
    echo "Installing nvm $NVM_VERSION..."
    if curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/$NVM_VERSION/install.sh" | bash; then
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
        if command -v nvm &> /dev/null; then
            nvm install --lts
            nvm use --lts
        else
            echo "⚠️  nvm installation completed but not available in current session. Restart terminal and run 'nvm install --lts'"
        fi
    else
        echo "❌ Failed to install nvm. Install manually from https://github.com/nvm-sh/nvm"
    fi
fi

# Python development
echo -e "${YELLOW}Setting up Python development...${NC}"
if command -v pip3 &> /dev/null; then
    pip3 install --user pipenv virtualenv black flake8 pytest requests || echo "⚠️  Some Python packages failed to install"
else
    echo "⚠️  pip3 not found. Install Python 3 first: brew install python"
fi

# Global npm packages
echo -e "${YELLOW}Installing global npm packages...${NC}"
NPMPKGS=(
    "typescript"
    "nodemon"
    "pm2"
    "http-server"
    "live-server"
    "@vercel/ncc"
    "prettier"
    "eslint"
)

if command -v npm &> /dev/null; then
    for pkg in "${NPMPKGS[@]}"; do
        echo "Installing $pkg..."
        npm install -g "$pkg" || echo "⚠️  Failed to install $pkg"
    done
else
    echo "⚠️  npm not found. Install Node.js first or ensure nvm setup completed successfully"
fi

echo -e "${GREEN}✅ Development environment setup complete!${NC}"