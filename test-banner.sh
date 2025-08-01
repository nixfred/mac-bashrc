#!/bin/bash

# Fast version of print_fun_banner without slow operations
print_fast_banner() {
  HOST=$(hostname)
  IPs=$(ifconfig | grep 'inet ' | grep -v 127.0.0.1 | awk '{print $2}' | tr '\n' ' ')
  UPTIME=$(uptime | sed 's/.*up \([^,]*\).*/\1/')
  USERS=$(who | wc -l | tr -d ' ')
  LOAD=$(uptime | awk -F'load averages: ' '{print $2}')
  DISK=$(df -h / | awk 'NR==2 {print $5 " used on " $2}')
  
  # Faster memory calculation (no system_profiler)
  MEM_INFO=$(vm_stat | awk '
    /page size/ { gsub(/[^0-9]/, "", $0); pagesize = $0 }
    /Pages free/ { free = $3 }
    /Pages active/ { active = $3 }
    /Pages wired/ { wired = $3 }
    END {
      gsub(/\./, "", free)
      gsub(/\./, "", active) 
      gsub(/\./, "", wired)
      free_mb = (free * pagesize) / 1024 / 1024
      used_mb = ((active + wired) * pagesize) / 1024 / 1024
      total_mb = (free_mb + used_mb)
      printf "%.0fMB free / %.0fGB total", free_mb, total_mb/1024
    }')
  
  DATE=$(date)
  
  # macOS version - cached
  MACOS_VER=$(sw_vers -productVersion)
  
  # Skip slow operations
  EXTERNAL_IP="(skipped)"
  TEMP="(skipped)"
  BREW_STATUS="(run 'brew outdated' to check)"
  WEATHER="(run 'weather' to check)"
  SSH_FAILS="(check manually)"
  LASTLOGIN="(skipped)"
  
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
  printf "${BORDER_COLOR}*${LABEL_COLOR}  Uptime:      ${VALUE_COLOR}%-30s${BORDER_COLOR}*${NC}\n" "$UPTIME"
  printf "${BORDER_COLOR}*${LABEL_COLOR}  Users:       ${VALUE_COLOR}%-30s${BORDER_COLOR}*${NC}\n" "$USERS"
  printf "${BORDER_COLOR}*${LABEL_COLOR}  Load:        ${VALUE_COLOR}%-30s${BORDER_COLOR}*${NC}\n" "$LOAD"
  printf "${BORDER_COLOR}*${LABEL_COLOR}  Disk:        ${VALUE_COLOR}%-30s${BORDER_COLOR}*${NC}\n" "$DISK"
  printf "${BORDER_COLOR}*${LABEL_COLOR}  Memory:      ${VALUE_COLOR}%-30s${BORDER_COLOR}*${NC}\n" "$MEM_INFO"
  printf "${BORDER_COLOR}*${LABEL_COLOR}  Date:        ${VALUE_COLOR}%-30s${BORDER_COLOR}*${NC}\n" "$DATE"
  printf "${BORDER_COLOR}****************************************************${NC}\n"
}

# Test execution time
echo "Testing fast banner..."
time print_fast_banner