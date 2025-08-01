# Auto-switch to modern bash if we're still in old bash
if [ "$BASH_VERSION" = "3.2.57(1)-release" ] && [ -x "/opt/homebrew/bin/bash" ]; then
    exec /opt/homebrew/bin/bash "$@"
fi

# Optional Fabric bootstrap (if it exists)
# Temporarily disabled - may cause hanging
# if [ -f "$HOME/.config/fabric/fabric-bootstrap.inc" ]; then
#   . "$HOME/.config/fabric/fabric-bootstrap.inc"
# fi

# Ensure /usr/local/bin comes first (Intel Homebrew compatibility)
export PATH="/usr/local/bin:$PATH"

# Load Homebrew environment (Apple Silicon)
eval "$(/opt/homebrew/bin/brew shellenv)"

# Load .bashrc if it exists
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

# Install bash-completion@2 for modern bash (after .bashrc)
# Temporarily disabled - may cause hanging
# if command -v brew >/dev/null 2>&1; then
#     HOMEBREW_PREFIX=$(brew --prefix)
#     if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]; then
#         source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
#     fi
# fi

# Enable bash completion features
set +o posix
bind 'set completion-ignore-case on'
bind 'set show-all-if-ambiguous on'

# Enable directory completion specifically
complete -o default -o dirnames cd
complete -o default -o dirnames pushd  
complete -o default -o dirnames popd
