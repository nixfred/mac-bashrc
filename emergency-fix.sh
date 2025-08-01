#!/bin/sh
echo "Emergency bash fix - this will backup and create minimal config files"
echo "Press Ctrl+C to cancel, or Enter to continue..."
read -r

# Backup existing files
echo "Backing up existing files..."
[ -f ~/.bashrc ] && cp ~/.bashrc ~/.bashrc.backup.$(date +%Y%m%d-%H%M%S)
[ -f ~/.bash_profile ] && cp ~/.bash_profile ~/.bash_profile.backup.$(date +%Y%m%d-%H%M%S)

# Create minimal .bash_profile
cat > ~/.bash_profile << 'EOF'
# Minimal .bash_profile to fix hanging

# Auto-switch to modern bash if available
if [ "$BASH_VERSION" = "3.2.57(1)-release" ] && [ -x "/opt/homebrew/bin/bash" ]; then
    exec /opt/homebrew/bin/bash "$@"
fi

# Basic PATH setup
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"

# Load .bashrc if it exists
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi
EOF

# Create minimal .bashrc  
cat > ~/.bashrc << 'EOF'
# Minimal .bashrc to test

# Basic prompt
PS1='\u@\h:\w\$ '

# Essential aliases
alias ll='ls -la'
alias sb='source ~/.bashrc'

echo "Minimal bash configuration loaded successfully!"
EOF

echo "✓ Created minimal configuration files"
echo "✓ Original files backed up with timestamp"
echo ""
echo "Now try opening a new terminal to test if bash works."
echo "If it works, you can gradually add back features from the backup files."