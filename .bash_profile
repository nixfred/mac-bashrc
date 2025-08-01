# Auto-switch to modern bash if we're still in old bash
if [ "$BASH_VERSION" = "3.2.57(1)-release" ] && [ -x "/opt/homebrew/bin/bash" ]; then
    exec /opt/homebrew/bin/bash "$@"
fi

# Optional Fabric bootstrap (if it exists)
if [ -f "$HOME/.config/fabric/fabric-bootstrap.inc" ]; then
  . "$HOME/.config/fabric/fabric-bootstrap.inc"
fi

# Ensure /usr/local/bin comes first (Intel Homebrew compatibility)
export PATH="/usr/local/bin:$PATH"

# Load Homebrew environment (Apple Silicon)
/opt/homebrew/bin/brew shellenv | sed 's/^/export /' >> ~/.bash_profile 2>/dev/null
eval "$(/opt/homebrew/bin/brew shellenv)"

# Load .bashrc if it exists
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

# Install bash-completion@2 for modern bash (after .bashrc)
if command -v brew >/dev/null 2>&1; then
    HOMEBREW_PREFIX=$(brew --prefix)
    if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]; then
        source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
    fi
fi

# Enable bash completion features
set +o posix
bind 'set completion-ignore-case on'
bind 'set show-all-if-ambiguous on'

# Enable directory completion specifically
complete -o default -o dirnames cd
complete -o default -o dirnames pushd  
complete -o default -o dirnames popd
export export HOMEBREW_PREFIX="/opt/homebrew";
export export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
export export HOMEBREW_REPOSITORY="/opt/homebrew";
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin:/Users/pi/Applications/iTerm.app/Contents/Resources/utilities:/usr/local/go/bin:/Users/pi/.local/bin:/Users/pi/go/bin"; export PATH;
export [ -z "${MANPATH-}" ] || export MANPATH=":${MANPATH#:}";
export export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";
export export HOMEBREW_PREFIX="/opt/homebrew";
export export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
export export HOMEBREW_REPOSITORY="/opt/homebrew";
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin:/opt/X11/bin:/Library/Apple/usr/bin:/Applications/VMware Fusion.app/Contents/Public:/Applications/Setapp:/usr/local/go/bin:/Users/pi/.local/bin:/Users/pi/go/bin"; export PATH;
export [ -z "${MANPATH-}" ] || export MANPATH=":${MANPATH#:}";
export export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";
export export HOMEBREW_PREFIX="/opt/homebrew";
export export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
export export HOMEBREW_REPOSITORY="/opt/homebrew";
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin:/opt/X11/bin:/Library/Apple/usr/bin:/Applications/VMware Fusion.app/Contents/Public:/Applications/Setapp:/usr/local/go/bin:/Users/pi/.local/bin:/Users/pi/go/bin"; export PATH;
export [ -z "${MANPATH-}" ] || export MANPATH=":${MANPATH#:}";
export export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";
export export HOMEBREW_PREFIX="/opt/homebrew";
export export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
export export HOMEBREW_REPOSITORY="/opt/homebrew";
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin:/opt/X11/bin:/Library/Apple/usr/bin:/Applications/VMware Fusion.app/Contents/Public:/Applications/Setapp:/usr/local/go/bin:/Users/pi/.local/bin:/Users/pi/go/bin"; export PATH;
export [ -z "${MANPATH-}" ] || export MANPATH=":${MANPATH#:}";
export export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";
export export HOMEBREW_PREFIX="/opt/homebrew";
export export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
export export HOMEBREW_REPOSITORY="/opt/homebrew";
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin:/opt/X11/bin:/Library/Apple/usr/bin:/Applications/VMware Fusion.app/Contents/Public:/Applications/Setapp:/usr/local/go/bin:/Users/pi/.local/bin:/Users/pi/go/bin"; export PATH;
export [ -z "${MANPATH-}" ] || export MANPATH=":${MANPATH#:}";
export export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";
export export HOMEBREW_PREFIX="/opt/homebrew";
export export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
export export HOMEBREW_REPOSITORY="/opt/homebrew";
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin:/opt/X11/bin:/Library/Apple/usr/bin:/Applications/VMware Fusion.app/Contents/Public:/Applications/Setapp:/usr/local/go/bin:/Users/pi/.local/bin:/Users/pi/go/bin"; export PATH;
export [ -z "${MANPATH-}" ] || export MANPATH=":${MANPATH#:}";
export export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";
export export HOMEBREW_PREFIX="/opt/homebrew";
export export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
export export HOMEBREW_REPOSITORY="/opt/homebrew";
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin:/opt/X11/bin:/Library/Apple/usr/bin:/Applications/VMware Fusion.app/Contents/Public:/Applications/Setapp:/usr/local/go/bin:/Users/pi/.local/bin:/Users/pi/go/bin"; export PATH;
export [ -z "${MANPATH-}" ] || export MANPATH=":${MANPATH#:}";
export export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";
