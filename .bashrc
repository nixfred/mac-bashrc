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
#### Version check v3.3
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
alias fnix='ssh 100.100.212.35'
alias mac='ssh 100.107.213.88'
alias ron='ssh ron'
alias eh='sudo nano /etc/hosts'
alias reboot='sudo reboot'
alias si='brew install'
alias neo='neofetch || screenfetch'
alias fullbanner='print_fun_banner'  # Show full banner anytime
alias ip='ifconfig'
alias df='df -h'
alias myip='curl -s ifconfig.me'
alias ll='ls -alFhG'
alias la='ls -AhG'
alias l='ls -CFhG'
alias aa='brew update && brew upgrade && brew cleanup'
alias c='clear'
alias e='exit'

# Enhanced directory navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ~='cd ~'
alias -- -='cd -'  # Go back to previous directory
alias dirs='dirs -v'  # Show directory stack with numbers
alias sb='source ~/.bashrc'
alias bm='nano ~/.bashrc && source ~/.bashrc'
alias top='htop'
alias htop='htop'
# System monitoring aliases
alias du='du -sh * | sort -h'
alias dudir='du -sh */ | sort -hr'  # Directory sizes only
alias memtop='ps aux | sort -k4 -nr | head -n 15'
alias cputop='ps aux | sort -k3 -nr | head -n 15'
alias temp='sysctl -n machdep.xcpm.cpu_thermal_state 2>/dev/null || echo "Temperature not available"'

# Quick system info
alias sysinfo='system_profiler SPSoftwareDataType SPHardwareDataType'
alias diskinfo='df -h'
alias meminfo='vm_stat | head -20'
alias loadavg='uptime'
alias proccount='ps aux | wc -l'
alias netstat='netstat -tuln'
alias ports='lsof -i -P -n | grep LISTEN'

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

# Git commit with automatic timestamp, push, and pull check
gitcommit() {
    local message
    if [ $# -eq 0 ]; then
        message="Update $(date '+%Y-%m-%d %H:%M:%S')"
    else
        message="$*"
    fi

    # Check if we're in a git repository
    if ! git rev-parse --git-dir >/dev/null 2>&1; then
        echo "❌ Not in a git repository"
        return 1
    fi

    echo "🔄 Starting git sync..."
    
    # Special handling for mac-bashrc repo - auto-copy dotfiles
    if [[ "$(basename "$(pwd)")" == "mac-bashrc" ]]; then
        echo "📂 Detected mac-bashrc repo - copying dotfiles..."
        [ -f ~/.bashrc ] && cp ~/.bashrc . && echo "  ✅ Copied .bashrc"
        [ -f ~/.bash_profile ] && cp ~/.bash_profile . && echo "  ✅ Copied .bash_profile"  
        [ -f ~/.zshrc ] && cp ~/.zshrc . && echo "  ✅ Copied .zshrc"
        [ -f ~/.inputrc ] && cp ~/.inputrc . && echo "  ✅ Copied .inputrc"
    fi
    
    # Fetch first to get latest remote info
    echo "📡 Fetching from remote..."
    git fetch --quiet

    # Add all files and commit if there are changes
    if [ -n "$(git status --porcelain)" ]; then
        echo "📝 Adding all files..."
        git add -A
        echo "💾 Committing changes..."
        git commit -m "$message"
        echo "✅ Changes committed: $message"
    else
        echo "ℹ️  No local changes to commit"
    fi

    # Show current status
    git status --short

    # Check if we have commits to push
    local commits_ahead=$(git rev-list --count @{u}..HEAD 2>/dev/null || echo "0")
    if [ "$commits_ahead" -gt 0 ]; then
        echo "📤 Pushing $commits_ahead commit(s) to remote..."
        git push && echo "✅ Push completed"
    else
        echo "ℹ️  No commits to push"
    fi

    # Check if there are commits to pull
    local commits_behind=$(git rev-list --count HEAD..@{u} 2>/dev/null || echo "0")
    if [ "$commits_behind" -gt 0 ]; then
        echo "📥 $commits_behind commit(s) available from remote"
        git pull && echo "✅ Pull completed"
    else
        echo "✅ Repository is up to date with remote"
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

# Enhanced Git branch function with status indicators
# Status symbols:
#   * = uncommitted changes (dirty)
#   + = staged changes
#   ? = untracked files
#   ↑ = ahead of remote
#   ↓ = behind remote  
#   $ = stash exists
# Colors: Green = clean, Red = dirty
git_branch() {
    # Quick check if we're in a git repository
    git rev-parse --git-dir >/dev/null 2>&1 || return
    
    # Get current branch
    local branch=$(git branch 2>/dev/null | grep '^*' | colrm 1 2)
    if [ -z "$branch" ]; then
        return
    fi
    
    local status=""
    local color=""
    
    # Check for uncommitted changes
    if [ -n "$(git status --porcelain 2>/dev/null)" ]; then
        status="${status}*"  # dirty/modified
        color="\033[1;31m"   # red
    else
        color="\033[1;32m"   # green
    fi
    
    # Check if we're ahead/behind remote
    local ahead_behind=$(git status --porcelain=v1 --branch 2>/dev/null | head -1)
    if echo "$ahead_behind" | grep -q "ahead"; then
        status="${status}↑"  # ahead
    fi
    if echo "$ahead_behind" | grep -q "behind"; then
        status="${status}↓"  # behind
    fi
    
    # Check for staged changes
    if git diff --cached --quiet 2>/dev/null; then
        : # no staged changes
    else
        status="${status}+"  # staged changes
    fi
    
    # Check for untracked files
    if [ -n "$(git ls-files --others --exclude-standard 2>/dev/null)" ]; then
        status="${status}?"  # untracked files
    fi
    
    # Check for stash
    if git rev-parse --verify refs/stash >/dev/null 2>&1; then
        status="${status}$"  # stash exists
    fi
    
    # Output the branch with color and status
    echo -e "${color}(${branch}${status})\033[0m"
}

# Show git status legend
git_legend() {
    echo "Git prompt status indicators:"
    echo "  🟢 (branch)     = Clean repository"
    echo "  🔴 (branch*)    = Uncommitted changes"
    echo "  📝 (branch+)    = Staged changes"
    echo "  ❓ (branch?)    = Untracked files"
    echo "  ⬆️  (branch↑)    = Ahead of remote"
    echo "  ⬇️  (branch↓)    = Behind remote"
    echo "  💾 (branch$)    = Stash exists"
    echo "  🔄 (branch*+?↑) = Multiple indicators combine"
}

######################################################################
# ENHANCED DIRECTORY NAVIGATION
######################################################################

# Smart cd function that creates directory if it doesn't exist
mkcd() {
    if [ $# -ne 1 ]; then
        echo "Usage: mkcd <directory>"
        return 1
    fi
    mkdir -p "$1" && cd "$1"
}

# Quick jump to common directories
cdl() { cd ~/Downloads; }
cdd() { cd ~/Desktop; }
cdh() { cd ~; }
cdt() { cd /tmp; }
cdr() { cd /; }

# Show directory tree with depth limit
tree() {
    local depth=${1:-2}
    if command -v tree >/dev/null 2>&1; then
        command tree -L "$depth" -C
    elif command -v find >/dev/null 2>&1; then
        find . -maxdepth "$depth" -type d | sed -e 's;[^/]*/;|____;g;s;____|; |;g'
    else
        echo "Neither 'tree' nor 'find' command available"
    fi
}

# Quick directory size check
dirsize() {
    local dir=${1:-.}
    du -sh "$dir"/* 2>/dev/null | sort -hr
}

# Find directories by name
finddir() {
    if [ $# -eq 0 ]; then
        echo "Usage: finddir <pattern>"
        return 1
    fi
    find . -type d -iname "*$1*" 2>/dev/null
}

# Show navigation help
navhelp() {
    echo "Directory Navigation Commands:"
    echo "  ..        = cd .."
    echo "  ...       = cd ../.."  
    echo "  ....      = cd ../../.."
    echo "  .....     = cd ../../../.."
    echo "  -         = cd - (previous directory)"
    echo "  ~         = cd ~ (home)"
    echo "  dirs      = show directory stack"
    echo ""
    echo "Quick jumps:"
    echo "  cdl       = cd ~/Downloads"
    echo "  cdd       = cd ~/Desktop"  
    echo "  cdh       = cd ~"
    echo "  cdt       = cd /tmp"
    echo "  cdr       = cd /"
    echo ""
    echo "Utilities:"
    echo "  mkcd <dir>     = mkdir -p and cd"
    echo "  tree [depth]   = show directory tree"
    echo "  dirsize [dir]  = show directory sizes"
    echo "  finddir <name> = find directories by name"
}

######################################################################
# SYSTEM HEALTH MONITORING
######################################################################

# Health check thresholds (configurable)
HEALTH_DISK_WARNING=80      # Disk usage warning at 80%
HEALTH_DISK_CRITICAL=90     # Disk usage critical at 90%
HEALTH_MEM_WARNING=80       # Memory usage warning at 80%
HEALTH_MEM_CRITICAL=90      # Memory usage critical at 90%
HEALTH_LOAD_WARNING=4.0     # Load average warning
HEALTH_LOAD_CRITICAL=8.0    # Load average critical

# Check system health and return alerts
get_health_alerts() {
    local alerts=()
    
    # Check disk usage
    local disk_usage=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')
    if [ "$disk_usage" -ge "$HEALTH_DISK_CRITICAL" ]; then
        alerts+=("🔴 CRITICAL: Disk ${disk_usage}% full")
    elif [ "$disk_usage" -ge "$HEALTH_DISK_WARNING" ]; then
        alerts+=("🟡 WARNING: Disk ${disk_usage}% full")
    fi
    
    # Check memory usage
    local mem_info=$(vm_stat | awk '
        /page size/ { gsub(/[^0-9]/, "", $0); pagesize = $0 }
        /Pages free/ { free = $3 }
        /Pages active/ { active = $3 }
        /Pages inactive/ { inactive = $3 }
        /Pages speculative/ { speculative = $3 }
        /Pages wired/ { wired = $3 }
        END {
            gsub(/\./, "", free); gsub(/\./, "", active); gsub(/\./, "", inactive);
            gsub(/\./, "", speculative); gsub(/\./, "", wired);
            total_pages = free + active + inactive + speculative + wired
            used_pages = active + inactive + wired
            if (total_pages > 0) {
                mem_usage = (used_pages * 100) / total_pages
                print int(mem_usage)
            } else {
                print 0
            }
        }')
    
    if [ "$mem_info" -ge "$HEALTH_MEM_CRITICAL" ]; then
        alerts+=("🔴 CRITICAL: Memory ${mem_info}% used")
    elif [ "$mem_info" -ge "$HEALTH_MEM_WARNING" ]; then
        alerts+=("🟡 WARNING: Memory ${mem_info}% used")
    fi
    
    # Check load average (1-minute load)
    local load_avg=$(uptime | awk -F'load averages: ' '{print $2}' | awk '{print $1}')
    if command -v bc >/dev/null 2>&1; then
        if (( $(echo "$load_avg > $HEALTH_LOAD_CRITICAL" | bc -l) )); then
            alerts+=("🔴 CRITICAL: Load average ${load_avg}")
        elif (( $(echo "$load_avg > $HEALTH_LOAD_WARNING" | bc -l) )); then
            alerts+=("🟡 WARNING: Load average ${load_avg}")
        fi
    fi
    
    # Print alerts
    for alert in "${alerts[@]}"; do
        echo "$alert"
    done
}

# Manual health check command
healthcheck() {
    echo "🏥 System Health Report:"
    echo "======================="
    
    # Current status
    local disk_usage=$(df -h / | awk 'NR==2 {print $5, "used on", $2}')
    local load_avg=$(uptime | awk -F'load averages: ' '{print $2}')
    local uptime=$(uptime | sed 's/.*up \([^,]*\).*/\1/')
    
    echo "💾 Disk Usage: $disk_usage"
    echo "⚡ Load Average: $load_avg"
    echo "⏱️  Uptime: $uptime"
    echo ""
    
    # Health alerts
    local alerts=$(get_health_alerts)
    if [ -n "$alerts" ]; then
        echo "🚨 Health Alerts:"
        echo "$alerts"
    else
        echo "✅ All systems healthy"
    fi
    echo ""
    
    # Thresholds
    echo "⚙️  Current Thresholds:"
    echo "   Disk Warning: ${HEALTH_DISK_WARNING}% Critical: ${HEALTH_DISK_CRITICAL}%"
    echo "   Memory Warning: ${HEALTH_MEM_WARNING}% Critical: ${HEALTH_MEM_CRITICAL}%"
    echo "   Load Warning: ${HEALTH_LOAD_WARNING} Critical: ${HEALTH_LOAD_CRITICAL}"
}

# Set custom health thresholds
set_health_thresholds() {
    echo "Current health monitoring thresholds:"
    echo "  Disk warning: ${HEALTH_DISK_WARNING}% critical: ${HEALTH_DISK_CRITICAL}%"
    echo "  Memory warning: ${HEALTH_MEM_WARNING}% critical: ${HEALTH_MEM_CRITICAL}%"
    echo "  Load warning: ${HEALTH_LOAD_WARNING} critical: ${HEALTH_LOAD_CRITICAL}"
    echo ""
    echo "To modify, add to ~/.bashrc.personal:"
    echo "  export HEALTH_DISK_WARNING=85"
    echo "  export HEALTH_DISK_CRITICAL=95"
    echo "  # etc..."
}

######################################################################
# QUICK MONITORING COMMANDS
######################################################################

# Show top processes by CPU and memory
procs() {
    echo "🔥 Top CPU Users:"
    ps aux | head -1
    ps aux | sort -k3 -nr | head -10
    echo ""
    echo "🧠 Top Memory Users:"
    ps aux | head -1  
    ps aux | sort -k4 -nr | head -10
}

# Network connection summary
netsum() {
    echo "🌐 Network Connections Summary:"
    netstat -an | awk '
    /^tcp/ { 
        states[$6]++ 
    } 
    END { 
        for (state in states) 
            printf "  %-12s: %d\n", state, states[state] 
    }'
    echo ""
    echo "📡 Listening Ports:"
    lsof -i -P -n | grep LISTEN | awk '{print $1, $9}' | sort -u
}

# Disk usage summary with warnings
disksum() {
    echo "💾 Disk Usage Summary:"
    df -h | grep -E '^/dev/' | while read line; do
        usage=$(echo $line | awk '{print $5}' | sed 's/%//')
        if [ "$usage" -ge 90 ]; then
            echo "🔴 $line"
        elif [ "$usage" -ge 80 ]; then
            echo "🟡 $line"  
        else
            echo "✅ $line"
        fi
    done
}

# System resource summary
syssum() {
    echo "🖥️  System Resource Summary:"
    echo "=========================="
    
    # Uptime and load
    local uptime_info=$(uptime)
    echo "⏱️  $uptime_info"
    echo ""
    
    # Memory summary
    local mem_total=$(sysctl -n hw.memsize | awk '{print int($1/1024/1024/1024) "GB"}')
    local mem_free=$(vm_stat | awk '/Pages free/ {print int($3 * 4096 / 1024 / 1024) "MB"}')
    echo "🧠 Memory: $mem_free free of $mem_total total"
    
    # Disk summary
    echo "💾 Disk Usage:"
    df -h / | tail -1 | awk '{printf "   Root: %s used (%s free of %s)\n", $5, $4, $2}'
    
    # Process count
    local proc_count=$(ps aux | wc -l)
    echo "⚙️  Processes: $proc_count running"
    
    # Network
    local connections=$(netstat -an | grep ESTABLISHED | wc -l)
    echo "🌐 Network: $connections active connections"
    
    echo ""
    get_health_alerts
}

# Monitor system in real-time (Ctrl+C to exit)
monitor() {
    echo "🔄 Real-time System Monitor (Ctrl+C to exit)"
    echo "============================================="
    while true; do
        clear
        echo "$(date)"
        echo ""
        syssum
        sleep 5
    done
}

# Show all monitoring commands
monhelp() {
    echo "🔍 System Monitoring Commands:"
    echo "=============================="
    echo ""
    echo "📊 Quick Info Aliases:"
    echo "  sysinfo     = Full system information"
    echo "  diskinfo    = Disk usage (df -h)"
    echo "  meminfo     = Memory statistics"
    echo "  loadavg     = Load average and uptime"
    echo "  proccount   = Number of running processes"
    echo "  ports       = Listening network ports"
    echo "  netstat     = Network connections"
    echo ""
    echo "🔥 Process Monitoring:"
    echo "  memtop      = Top 15 memory users"
    echo "  cputop      = Top 15 CPU users"
    echo "  procs       = Combined CPU + memory top lists"
    echo ""
    echo "💾 Disk Monitoring:"
    echo "  du          = Directory sizes (sorted)"
    echo "  dudir       = Directory sizes only"
    echo "  disksum     = Color-coded disk usage warnings"
    echo ""
    echo "🌐 Network Monitoring:"
    echo "  netsum      = Network connection summary"
    echo "  ports       = Listening ports"
    echo ""
    echo "🏥 System Health:"
    echo "  healthcheck = Full health report"
    echo "  syssum      = System resource summary"
    echo "  monitor     = Real-time monitoring (5s refresh)"
    echo ""
    echo "⚙️  Configuration:"
    echo "  set_health_thresholds = Show threshold settings"
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
# MAC BANNER - Enhanced version with caching
######################################################################

# Cache expensive operations with timestamps
CACHE_DIR="$HOME/.bashrc_cache"
mkdir -p "$CACHE_DIR"

# Cache external IP (valid for 30 minutes)
get_external_ip() {
    local cache_file="$CACHE_DIR/external_ip"
    local cache_time=1800  # 30 minutes
    
    if [[ -f "$cache_file" ]] && [[ $(($(date +%s) - $(stat -f %m "$cache_file" 2>/dev/null || echo 0))) -lt $cache_time ]]; then
        cat "$cache_file"
    else
        local ip=$(timeout 3 curl -s ifconfig.me 2>/dev/null || echo "N/A")
        echo "$ip" > "$cache_file" 2>/dev/null
        echo "$ip"
    fi
}

# Cache weather (valid for 15 minutes)
get_weather() {
    local cache_file="$CACHE_DIR/weather"
    local cache_time=900  # 15 minutes
    
    if [[ -f "$cache_file" ]] && [[ $(($(date +%s) - $(stat -f %m "$cache_file" 2>/dev/null || echo 0))) -lt $cache_time ]]; then
        cat "$cache_file"
    else
        local weather=$(curl -s --max-time 2 "wttr.in/$WEATHER_ZIPCODE?format=%C+%t" 2>/dev/null || echo "N/A")
        echo "$weather" > "$cache_file" 2>/dev/null
        echo "$weather"
    fi
}

# Cache brew status (valid for 2 hours)
get_brew_status() {
    local cache_file="$CACHE_DIR/brew_status"
    local cache_time=7200  # 2 hours
    
    if [[ -f "$cache_file" ]] && [[ $(($(date +%s) - $(stat -f %m "$cache_file" 2>/dev/null || echo 0))) -lt $cache_time ]]; then
        cat "$cache_file"
    else
        local outdated=$(brew outdated --quiet 2>/dev/null | wc -l | tr -d ' ')
        local status
        if [ "$outdated" -eq 0 ] 2>/dev/null; then
            status="Up to date"
        else
            status="$outdated packages need updates"
        fi
        echo "$status" > "$cache_file" 2>/dev/null
        echo "$status"
    fi
}

# Cache management function
clear_banner_cache() {
    if [[ -d "$CACHE_DIR" ]]; then
        rm -f "$CACHE_DIR"/*
        echo "Banner cache cleared"
    else
        echo "No cache directory found"
    fi
}

print_fun_banner() {
  HOST=$(hostname)
  IPs=$(ifconfig | grep 'inet ' | grep -v 127.0.0.1 | awk '{print $2}' | tr '\n' ' ')
  EXTERNAL_IP=$(get_external_ip)  # Use cached version
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

  # Use cached brew status
  BREW_STATUS=$(get_brew_status)

  # Use cached weather
  WEATHER=$(get_weather)

  # SSH failures from system log (last 24 hours) - simplified for speed
  SSH_FAILS="Check manually with 'log show --last 24h'"

  # Colors for banner
  local BANNER_COLOR='\033[1;36m'  # Bright cyan
  local LABEL_COLOR='\033[1;33m'   # Bright yellow
  local VALUE_COLOR='\033[0;32m'   # Green
  local BORDER_COLOR='\033[1;35m'  # Bright magenta
  local NC='\033[0m'               # No color
  
  printf "${BORDER_COLOR}****************************************************${NC}\n"
  printf "${BORDER_COLOR}*${BANNER_COLOR}  🖥️  macOS Terminal System Dashboard  🖥️${BORDER_COLOR}        *${NC}\n"
  printf "${BORDER_COLOR}****************************************************${NC}\n"
  printf "${BORDER_COLOR}*${LABEL_COLOR}  Host:        ${VALUE_COLOR}%-30s${BORDER_COLOR}*${NC}\n" "$HOST"
  printf "${BORDER_COLOR}*${LABEL_COLOR}  macOS:       ${VALUE_COLOR}%-30s${BORDER_COLOR}*${NC}\n" "$MACOS_VER"
  printf "${BORDER_COLOR}*${LABEL_COLOR}  IPs (int):   ${VALUE_COLOR}%-30s${BORDER_COLOR}*${NC}\n" "$IPs"
  printf "${BORDER_COLOR}*${LABEL_COLOR}  IP (ext):    ${VALUE_COLOR}%-30s${BORDER_COLOR}*${NC}\n" "$EXTERNAL_IP"
  printf "${BORDER_COLOR}*${LABEL_COLOR}  Uptime:      ${VALUE_COLOR}%-30s${BORDER_COLOR}*${NC}\n" "$UPTIME"
  printf "${BORDER_COLOR}*${LABEL_COLOR}  Users:       ${VALUE_COLOR}%-30s${BORDER_COLOR}*${NC}\n" "$USERS"
  printf "${BORDER_COLOR}*${LABEL_COLOR}  Load:        ${VALUE_COLOR}%-30s${BORDER_COLOR}*${NC}\n" "$LOAD"
  printf "${BORDER_COLOR}*${LABEL_COLOR}  Disk:        ${VALUE_COLOR}%-30s${BORDER_COLOR}*${NC}\n" "$DISK"
  printf "${BORDER_COLOR}*${LABEL_COLOR}  Memory:      ${VALUE_COLOR}%-30s${BORDER_COLOR}*${NC}\n" "$MEM_INFO"
  printf "${BORDER_COLOR}*${LABEL_COLOR}  CPU Temp:    ${VALUE_COLOR}%-30s${BORDER_COLOR}*${NC}\n" "$TEMP"
  printf "${BORDER_COLOR}*${LABEL_COLOR}  Brew:        ${VALUE_COLOR}%-30s${BORDER_COLOR}*${NC}\n" "$BREW_STATUS"
  printf "${BORDER_COLOR}*${LABEL_COLOR}  Weather:     ${VALUE_COLOR}%-30s${BORDER_COLOR}*${NC}\n" "$WEATHER ($WEATHER_ZIPCODE)"
  printf "${BORDER_COLOR}*${LABEL_COLOR}  Date:        ${VALUE_COLOR}%-30s${BORDER_COLOR}*${NC}\n" "$DATE"
  printf "${BORDER_COLOR}*${LABEL_COLOR}  Last Login:  ${VALUE_COLOR}%-30s${BORDER_COLOR}*${NC}\n" "$LASTLOGIN"
  printf "${BORDER_COLOR}*${LABEL_COLOR}  SSH Fails:   ${VALUE_COLOR}%-30s${BORDER_COLOR}*${NC}\n" "$SSH_FAILS"
  
  # Show health alerts if any
  local health_alerts=$(get_health_alerts)
  if [ -n "$health_alerts" ]; then
    printf "${BORDER_COLOR}*${NC}\n"
    printf "${BORDER_COLOR}*${BANNER_COLOR}  🚨 SYSTEM HEALTH ALERTS:${BORDER_COLOR}                    *${NC}\n"
    while IFS= read -r alert; do
      # Strip ANSI codes for length calculation
      local plain_alert=$(echo "$alert" | sed 's/\x1b\[[0-9;]*m//g')
      local padding=$((48 - ${#plain_alert}))
      if [ $padding -lt 0 ]; then padding=0; fi
      printf "${BORDER_COLOR}*  ${alert}${BORDER_COLOR}$(printf '%*s' $padding '')*${NC}\n"
    done <<< "$health_alerts"
  fi
  
  printf "${BORDER_COLOR}****************************************************${NC}\n"
}

# Lightweight SSH banner for quick machine identification
print_ssh_banner() {
  local HOST=$(hostname -s 2>/dev/null || hostname)
  local USER=$(whoami)
  local IP=$(echo $SSH_CLIENT | awk '{print $1}' 2>/dev/null || echo "local")
  local MACOS=$(sw_vers -productVersion 2>/dev/null || echo "macOS")
  local UPTIME=$(uptime | awk -F'up ' '{print $2}' | awk -F',' '{print $1}' | xargs)
  local DISK=$(df -h / | awk 'NR==2 {print $5}')
  
  # Colors for SSH banner
  local BANNER_COLOR='\033[1;36m'  # Bright cyan
  local LABEL_COLOR='\033[1;33m'   # Bright yellow
  local VALUE_COLOR='\033[0;32m'   # Green
  local BORDER_COLOR='\033[1;35m'  # Bright magenta
  local NC='\033[0m'               # No color
  
  printf "${BORDER_COLOR}****************************************************${NC}\n"
  printf "${BORDER_COLOR}*${BANNER_COLOR}  🖥️  SSH: ${VALUE_COLOR}${USER}@${HOST}${BANNER_COLOR} (macOS ${MACOS})${BORDER_COLOR}     *${NC}\n"
  printf "${BORDER_COLOR}*${LABEL_COLOR}  From: ${VALUE_COLOR}%-15s ${LABEL_COLOR}Up: ${VALUE_COLOR}%-15s${BORDER_COLOR}*${NC}\n" "$IP" "$UPTIME"
  printf "${BORDER_COLOR}*${LABEL_COLOR}  Disk: ${VALUE_COLOR}%-15s ${LABEL_COLOR}Type 'neo' for full stats${BORDER_COLOR} *${NC}\n" "$DISK used"
  
  # Show critical health alerts only (for SSH brevity)
  local health_alerts=$(get_health_alerts | grep "🔴 CRITICAL")
  if [ -n "$health_alerts" ]; then
    printf "${BORDER_COLOR}*${NC}\n"
    while IFS= read -r alert; do
      printf "${BORDER_COLOR}*  ${alert}${BORDER_COLOR}$(printf '%*s' $((48 - ${#alert})) '')*${NC}\n"
    done <<< "$health_alerts"
  fi
  
  printf "${BORDER_COLOR}****************************************************${NC}\n"
}

# Smart banner display logic
if [[ $- == *i* ]] && [[ -z "$SCRIPT_MODE" ]] && [[ "$TERM" != "dumb" ]]; then
    if [[ -n "$SSH_CLIENT" ]]; then
        # SSH session - show lightweight banner
        print_ssh_banner
    else
        # Local session - show full banner
        print_fun_banner
    fi
fi

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
    eval "$(timeout 3 rbenv init - 2>/dev/null || echo '')"
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
if [ -f /opt/homebrew/etc/profile.d/bash_completion.sh ]; then
    . /opt/homebrew/etc/profile.d/bash_completion.sh
elif [ -f /opt/homebrew/etc/bash_completion ]; then
    . /opt/homebrew/etc/bash_completion
elif [ -f /usr/local/etc/bash_completion ]; then
    . /usr/local/etc/bash_completion
fi

# Enable completion enhancements for old bash (3.2)
shopt -s cdspell 2>/dev/null
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

# System information - using alias instead of function

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

# Terminal title - disabled to prevent -ne output
# case "$TERM" in
# xterm*|rxvt*)
#     PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
#     ;;
# *)
#     ;;
# esac

# Completion for custom commands
complete -W "add list done clear" todo
complete -d proj

# Enable directory completion for cd command
complete -d cd pushd popd

######################################################################

# Disable bracketed paste mode
printf '\e[?2004l' >/dev/null 2>&1

######################################################################

# Load personal customizations if they exist
if [ -f ~/.bashrc.personal ]; then
    source ~/.bashrc.personal
fi
printf '\e[?2004l'
printf '\e[?2004l'
# Add npm global bin to PATH (with timeout to prevent hanging)
if command -v npm >/dev/null 2>&1; then
    NPM_PREFIX=$(timeout 3 npm config get prefix 2>/dev/null || echo "")
    if [ -n "$NPM_PREFIX" ] && [ -d "$NPM_PREFIX/bin" ]; then
        export PATH="$NPM_PREFIX/bin:$PATH"
    fi
fi
