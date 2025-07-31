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
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    nvm install --lts
    nvm use --lts
fi

# Python development
echo -e "${YELLOW}Setting up Python development...${NC}"
pip3 install --user pipenv virtualenv black flake8 pytest requests

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

for pkg in "${NPMPKGS[@]}"; do
    npm install -g "$pkg"
done

echo -e "${GREEN}✅ Development environment setup complete!${NC}"