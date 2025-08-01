# Auto-switch to modern bash if we're still in old bash (interactive terminals only)
if [ "$BASH_VERSION" = "3.2.57(1)-release" ] && [ -x "/opt/homebrew/bin/bash" ] && [ -t 0 ] && [ -t 1 ]; then
    exec /opt/homebrew/bin/bash "$@"
fi

# Optional Fabric bootstrap (if it exists)
if [ -f "$HOME/.config/fabric/fabric-bootstrap.inc" ]; then
  . "$HOME/.config/fabric/fabric-bootstrap.inc"
fi

# Ensure /usr/local/bin comes first (Intel Homebrew compatibility)
export PATH="/usr/local/bin:$PATH"

# Load Homebrew environment (Apple Silicon) - with timeout
if [ -x "/opt/homebrew/bin/brew" ]; then
    eval "$(timeout 3 /opt/homebrew/bin/brew shellenv 2>/dev/null || echo 'export PATH="/opt/homebrew/bin:$PATH"')"
fi

# Load .bashrc if it exists (skip if DISABLE_BASHRC is set)
if [ -f ~/.bashrc ] && [ -z "$DISABLE_BASHRC" ]; then
    source ~/.bashrc
fi

# Install bash-completion@2 for modern bash (after .bashrc)
if command -v brew >/dev/null 2>&1; then
    HOMEBREW_PREFIX=$(brew --prefix)
    if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]; then
        source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
    fi
fi

# Disable POSIX mode and enable bash completion features
set +o posix
bind 'set completion-ignore-case on' 2>/dev/null
bind 'set show-all-if-ambiguous on' 2>/dev/null

# Enable directory completion specifically
complete -o default -o dirnames cd 2>/dev/null
complete -o default -o dirnames pushd 2>/dev/null
complete -o default -o dirnames popd 2>/dev/null
