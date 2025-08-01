# ~/.bashrc: executed by bash(1) for non-login shells.
# Enhanced macOS Terminal Configuration - Portable Version
# Version 2.1 - Machine-agnostic

# Suppress macOS zsh default shell warning
export BASH_SILENCE_DEPRECATION_WARNING=1

case $- in
    *i*) ;;
      *) return;;
esac

####
#### Version check v3
####

######################################################################
# PERSONAL CONFIGURATION - CUSTOMIZE THESE
######################################################################

# Weather Location - Change to your zipcode
WEATHER_ZIPCODE="${WEATHER_ZIPCODE:-12345}"

# Personal SSH shortcuts - Add your own servers
# Example: alias myserver='ssh user@hostname'
# alias ron='ssh pi@100.100.111.39'
# alias pp='ssh pi@pi'

######################################################################
# ALIASES - Mac-optimized version
######################################################################

# System management
alias ron='ssh ron'
alias eh='sudo nano /etc/hosts'
alias reboot='sudo reboot'
alias si='brew install'
alias neo='neofetch || screenfetch'
alias ip='ifconfig'
alias df='df -h'
alias myip='curl -s ifconfig.me'
alias ll='ls -alFhG'
alias la='ls -AhG'
alias l='ls -CFhG'
alias aa='brew update && brew upgrade && brew cleanup'
alias c='clear'
alias e='exit'
alias sb='source ~/.bashrc'
alias bm='nano ~/.bashrc && source ~/.bashrc'
alias top='htop'
alias htop='htop'
alias du='du -sh * | sort -h'
alias memtop='ps aux | sort -k4 -nr | head -n 15'
alias cputop='ps aux | sort -k3 -nr | head -n 15'
alias temp='sysctl -n machdep.xcpm.cpu_thermal_state 2>/dev/null || echo "Temperature not available"'

# Additional useful aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias h='history | tail -20'
alias hg='history | grep'
alias ports='netstat -tuln'
alias psg='ps aux | grep'
alias mkdir='mkdir -pv'
alias wget='wget -c'
alias path='echo -e ${PATH//:/\\n}'
alias now='date +"%T"'
alias nowtime='date +"%d-%m-%Y %T"'
alias vi='vim'
alias svi='sudo vim'
alias log='tail -f /var/log/system.log'
alias tarx='tar -xvzf'
alias tarc='tar -cvzf'
alias myprocesses='ps -ef | grep $USER'
alias reload='source ~/.bashrc'

# Mac-specific aliases  
alias brewlist='brew list'
alias brewsearch='brew search'
alias brewinfo='brew info'
alias brewout='brew outdated'
alias brewdeps='brew deps --tree'
alias finder='open -a Finder'
alias preview='open -a Preview'

# From original .bashrc
alias gpt='ollama run llama3.2'

# Git shortcuts
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'
alias gd='git diff'
alias gb='git branch'
alias gco='git checkout'
alias gcm='git commit -m'
alias glog='git log --oneline --graph --decorate'

# Dotfiles sync shortcuts
alias syncup='cd ~/mac-bashrc && cp ~/.bashrc . && cp ~/.bash_profile . && cp ~/.zshrc . && git add . && git commit -m "Sync from $(hostname)" && git push && cd -'
alias syncdown='cd ~/mac-bashrc && git pull && cp .bashrc ~/ && cp .bash_profile ~/ && cp .zshrc ~/ && source ~/.bashrc && cd -'
alias syncstatus='cd ~/mac-bashrc && git status && cd -'

# Git commit with automatic timestamp
gitcommit() {
    local message
    if [ $# -eq 0 ]; then
        message="Update $(date '+%Y-%m-%d %H:%M:%S')"
    else
        message="$*"
    fi

    # Check if we're in a git repository
    if ! git rev-parse --git-dir >/dev/null 2>&1; then
        echo "Not in a git repository"
        return 1
    fi

    # Check if there are changes to commit
    if [ -n "$(git status --porcelain)" ]; then
        # Add modified tracked files only (not new untracked files)
        git add -u
        git commit -m "$message"
    else
        echo "No changes to commit. Current status:"
        git status --short
    fi
}

# Alias for shorter command
alias gitc='gitcommit'

# Weather shortcuts - uses WEATHER_ZIPCODE variable
alias weather="curl -s --max-time 5 \"wttr.in/\${WEATHER_ZIPCODE}?format=3\" 2>/dev/null || echo \"Weather service unavailable\""
alias forecast="curl -s \"wttr.in/\${WEATHER_ZIPCODE}\""

######################################################################
# HISTORY AND SHELL OPTIONS
######################################################################

HISTCONTROL=ignoreboth:erasedups
shopt -s histappend
HISTSIZE=5000
HISTFILESIZE=10000
HISTTIMEFORMAT="%d/%m/%y %T "
shopt -s checkwinsize
shopt -s cdspell
shopt -s autocd 2>/dev/null

######################################################################
# PROMPT CONFIGURATION
######################################################################

# Set chroot name (if any)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Prompt color support
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        color_prompt=yes
    else
        color_prompt=
    fi
fi

# Prompt colors
RED="\[\033[0;31m\]"
GREEN="\[\033[0;32m\]"
BLUE="\[\033[0;34m\]"
CYAN="\[\033[0;36m\]"
YELLOW="\[\033[0;33m\]"
PURPLE="\[\033[0;35m\]"
BOLD_GREEN="\[\033[1;32m\]"
BOLD_BLUE="\[\033[1;34m\]"
BOLD_YELLOW="\[\033[1;33m\]"
BOLD_CYAN="\[\033[1;36m\]"
RESET="\[\033[0m\]"

# Git branch function for prompt
git_branch() {
    git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

PS1="${GREEN}\u${RED}@${YELLOW}\h${CYAN}:(\w)${PURPLE}\$(git_branch)${CYAN}\$ ${RESET}"

case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

######################################################################
# COLOR SUPPORT
######################################################################

# Mac uses different ls color option
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

######################################################################
# USEFUL FUNCTIONS
######################################################################

# Extract various archive formats
extract() {
    if [ -f "$1" ] ; then
        case "$1" in
            *.tar.bz2)   tar xjf "$1"     ;;
            *.tar.gz)    tar xzf "$1"     ;;
            *.bz2)       bunzip2 "$1"     ;;
            *.rar)       unrar e "$1"     ;;
            *.gz)        gunzip "$1"      ;;
            *.tar)       tar xf "$1"      ;;
            *.tbz2)      tar xjf "$1"     ;;
            *.tgz)       tar xzf "$1"     ;;
            *.zip)       unzip "$1"       ;;
            *.Z)         uncompress "$1"  ;;
            *.7z)        7z x "$1"        ;;
            *)     echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Find files by name
ff() {
    find . -type f -iname '*'"$*"'*' -ls ;
}

# Quick backup function
backup() {
    cp "$1"{,.bak-$(date +%Y%m%d-%H%M%S)}
}

# Show directory size sorted
dirsize() {
    du -sh */ 2>/dev/null | sort -hr
}

# Weather function with timeout and error handling
weather_detailed() {
    local city=${1:-$WEATHER_ZIPCODE}
    curl -s --max-time 5 "wttr.in/${city}?format=3" 2>/dev/null || echo "Weather service unavailable"
}

######################################################################
# MAC BANNER - Enhanced version
######################################################################

print_fun_banner() {
  HOST=$(hostname)
  IPs=$(ifconfig | grep 'inet ' | grep -v 127.0.0.1 | awk '{print $2}' | tr '\n' ' ')
  EXTERNAL_IP=$(timeout 3 curl -s ifconfig.me 2>/dev/null || echo "N/A")
  UPTIME=$(uptime | sed 's/.*up \([^,]*\).*/\1/')
  USERS=$(who | wc -l | tr -d ' ')
  LOAD=$(uptime | awk -F'load averages: ' '{print $2}')
  DISK=$(df -h / | awk 'NR==2 {print $5 " used on " $2}')

  # Mac memory info (using system_profiler for accuracy)
  TOTAL_MEM=$(system_profiler SPHardwareDataType | grep "Memory:" | awk '{print $2$3}')
  MEM_INFO=$(vm_stat | awk -v total="$TOTAL_MEM" '
    /page size/ { gsub(/[^0-9]/, "", $0); pagesize = $0 }
    /Pages free/ { free = $3 }
    END {
      gsub(/\./, "", free)
      free_mb = (free * pagesize) / 1024 / 1024
      printf "%.0fMB free / %s total", free_mb, total
    }')

  DATE=$(date)
  LASTLOGIN=$(last -n 1 "$USER" 2>/dev/null | awk 'NR==1 {$1=""; print $0}' || echo "N/A")

  # Mac CPU temperature (if available)
  if command -v osx-cpu-temp >/dev/null 2>&1; then
    TEMP_C=$(osx-cpu-temp | sed 's/°C//')
    if [ "$TEMP_C" = "0.0" ]; then
      TEMP="N/A"
    else
      TEMP=$(awk -v c="$TEMP_C" 'BEGIN { printf("%.1f°F", (c * 9 / 5) + 32) }')
    fi
  else
    TEMP="N/A (install osx-cpu-temp)"
  fi

  # macOS version
  MACOS_VER=$(sw_vers -productVersion)

  # Brew outdated count
  BREW_OUTDATED=$(brew outdated --quiet 2>/dev/null | wc -l | tr -d ' ')
  if [ "$BREW_OUTDATED" -eq 0 ] 2>/dev/null; then
    BREW_STATUS="Up to date"
  else
    BREW_STATUS="$BREW_OUTDATED packages need updates"
  fi

  # Weather using zipcode variable
  WEATHER=$(curl -s --max-time 2 "wttr.in/$WEATHER_ZIPCODE?format=%C+%t" 2>/dev/null || echo "N/A")

  # SSH failures from system log (last 24 hours) - simplified for speed
  SSH_FAILS="Check manually with 'log show --last 24h'"

  # Colors for banner
  local BANNER_COLOR='\033[1;36m'  # Bright cyan
  local LABEL_COLOR='\033[1;33m'   # Bright yellow
  local VALUE_COLOR='\033[0;32m'   # Green
  local BORDER_COLOR='\033[1;35m'  # Bright magenta
  local NC='\033[0m'               # No color
  
  echo -e "${BORDER_COLOR}****************************************************${NC}"
  echo -e "${BORDER_COLOR}*${BANNER_COLOR}  🖥️  macOS Terminal System Dashboard  🖥️${BORDER_COLOR}        *${NC}"
  echo -e "${BORDER_COLOR}****************************************************${NC}"
  echo -e "${BORDER_COLOR}*${LABEL_COLOR}  Host:        ${VALUE_COLOR}$HOST${BORDER_COLOR}                        *${NC}"
  echo -e "${BORDER_COLOR}*${LABEL_COLOR}  macOS:       ${VALUE_COLOR}$MACOS_VER${BORDER_COLOR}                    *${NC}"
  echo -e "${BORDER_COLOR}*${LABEL_COLOR}  IPs (int):   ${VALUE_COLOR}$IPs${BORDER_COLOR}     *${NC}"
  echo -e "${BORDER_COLOR}*${LABEL_COLOR}  IP (ext):    ${VALUE_COLOR}$EXTERNAL_IP${BORDER_COLOR}                  *${NC}"
  echo -e "${BORDER_COLOR}*${LABEL_COLOR}  Uptime:      ${VALUE_COLOR}$UPTIME${BORDER_COLOR}                       *${NC}"
  echo -e "${BORDER_COLOR}*${LABEL_COLOR}  Users:       ${VALUE_COLOR}$USERS${BORDER_COLOR}                         *${NC}"
  echo -e "${BORDER_COLOR}*${LABEL_COLOR}  Load:        ${VALUE_COLOR}$LOAD${BORDER_COLOR}              *${NC}"
  echo -e "${BORDER_COLOR}*${LABEL_COLOR}  Disk:        ${VALUE_COLOR}$DISK${BORDER_COLOR}                 *${NC}"
  echo -e "${BORDER_COLOR}*${LABEL_COLOR}  Memory:      ${VALUE_COLOR}$MEM_INFO${BORDER_COLOR}            *${NC}"
  echo -e "${BORDER_COLOR}*${LABEL_COLOR}  CPU Temp:    ${VALUE_COLOR}$TEMP${BORDER_COLOR}                         *${NC}"
  echo -e "${BORDER_COLOR}*${LABEL_COLOR}  Brew:        ${VALUE_COLOR}$BREW_STATUS${BORDER_COLOR}         *${NC}"
  echo -e "${BORDER_COLOR}*${LABEL_COLOR}  Weather:     ${VALUE_COLOR}$WEATHER ($WEATHER_ZIPCODE)${BORDER_COLOR}   *${NC}"
  echo -e "${BORDER_COLOR}*${LABEL_COLOR}  Date:        ${VALUE_COLOR}$DATE${BORDER_COLOR} *${NC}"
  echo -e "${BORDER_COLOR}*${LABEL_COLOR}  Last Login:  ${VALUE_COLOR}$LASTLOGIN${BORDER_COLOR} *${NC}"
  echo -e "${BORDER_COLOR}*${LABEL_COLOR}  SSH Fails:   ${VALUE_COLOR}$SSH_FAILS${BORDER_COLOR}                     *${NC}"
  echo -e "${BORDER_COLOR}****************************************************${NC}"
}

print_fun_banner

######################################################################
# ENVIRONMENT VARIABLES AND PATHS
######################################################################

# Path additions
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:/usr/sbin"

# Editor
export EDITOR=vim
export VISUAL=vim

# Python
export PYTHONDONTWRITEBYTECODE=1

# Node Version Manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Golang
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# Ruby
if command -v rbenv &> /dev/null; then
    eval "$(rbenv init -)"
fi

# Java (suppress warning if not installed)
if [ -f /usr/libexec/java_home ]; then
    export JAVA_HOME=$(/usr/libexec/java_home -v 11 2>/dev/null || /usr/libexec/java_home 2>/dev/null)
fi

# Fabric bootstrap (from original)
if [ -f "$HOME/.config/fabric/fabric-bootstrap.inc" ]; then
    . "$HOME/.config/fabric/fabric-bootstrap.inc"
fi

# SetApp CLI tools (if available)
if [ -d "/Applications/Setapp" ]; then
    export PATH="/Applications/Setapp:$PATH"
fi

# Load sensitive environment variables (keep sensitive data here)
if [ -f ~/.env.local ]; then
    source ~/.env.local
fi

######################################################################
# AUTO-COMPLETION
######################################################################

# Enable programmable completion features
if [ -f /opt/homebrew/etc/bash_completion ]; then
    . /opt/homebrew/etc/bash_completion
elif [ -f /usr/local/etc/bash_completion ]; then
    . /usr/local/etc/bash_completion
fi

# cd into directory just by typing the directory name
shopt -s autocd 2>/dev/null

######################################################################
# DOTFILES MANAGEMENT
######################################################################

# Dotfiles management
alias upbash='cd ~/dotfiles && cp ~/.bashrc . && git add .bashrc && git commit -m "Update .bashrc from $(hostname) - $(date +%Y-%m-%d_%H:%M)" && git push'
alias downbash='cd ~/dotfiles && git pull && cp .bashrc ~/.bashrc && source ~/.bashrc && echo "✅ .bashrc updated!"'
alias bashstat='cd ~/dotfiles && git status'

######################################################################
# TODO MANAGEMENT
######################################################################

todo() {
    local todo_file="$HOME/.config/shell/todos.txt"
    mkdir -p "$(dirname "$todo_file")"
    
    case "$1" in
        add)
            shift
            echo "$(date '+%Y-%m-%d %H:%M') - $*" >> "$todo_file"
            echo "✅ Todo added"
            ;;
        list|ls)
            if [ -f "$todo_file" ]; then
                nl -w2 -s'. ' "$todo_file"
            else
                echo "No todos found"
            fi
            ;;
        done)
            if [ -f "$todo_file" ] && [ -n "$2" ]; then
                sed -i '' "${2}d" "$todo_file"
                echo "✅ Todo marked as done"
            else
                echo "Usage: todo done <number>"
            fi
            ;;
        clear)
            > "$todo_file"
            echo "✅ All todos cleared"
            ;;
        *)
            echo "Usage: todo [add|list|done|clear]"
            ;;
    esac
}

######################################################################
# ADDITIONAL FUNCTIONS
######################################################################

# Create directory and cd into it
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# System information
sysinfo() {
    echo "System Information:"
    system_profiler SPSoftwareDataType SPHardwareDataType
}

# Network utilities
listening() {
    lsof -i -P | grep LISTEN | grep :$1
}

# Kill process on port
killport() {
    if [ -z "$1" ]; then
        echo "Usage: killport <port>"
        return 1
    fi
    
    lsof -ti :"$1" | xargs kill -9
    echo "✅ Killed process on port $1"
}

# Quick calculator
calc() {
    echo "$*" | bc -l
}

# Generate secure passwords
genpass() {
    local length="${1:-20}"
    openssl rand -base64 48 | cut -c1-"$length"
}

# Custom functions for quick access
proj() {
    cd ~/Projects/"$1" 2>/dev/null || cd ~/Documents/"$1" 2>/dev/null || echo "Project not found"
}

# Terminal title
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
    ;;
*)
    ;;
esac

# Completion for custom commands
complete -W "add list done clear" todo
complete -d proj

######################################################################

# Disable bracketed paste mode
printf "\e[?2004l"

######################################################################

# Load personal customizations if they exist
if [ -f ~/.bashrc.personal ]; then
    source ~/.bashrc.personal
fi
