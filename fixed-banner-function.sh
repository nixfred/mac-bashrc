#!/bin/bash
# Fixed banner function that works with or without GNU timeout

# Fixed version of print_fun_banner
print_fun_banner() {
  HOST=$(hostname)
  
  # Check if timeout command exists (from coreutils)
  if command -v timeout >/dev/null 2>&1; then
    # Use timeout version
    IPs=$(timeout 1 ifconfig en0 2>/dev/null | grep 'inet ' | awk '{print $2}' || echo "N/A")
    if [ "$IPs" = "N/A" ]; then
      IPs=$(timeout 1 ifconfig en1 2>/dev/null | grep 'inet ' | awk '{print $2}' || echo "N/A")
    fi
    EXTERNAL_IP=$(timeout 2 curl -s ifconfig.me 2>/dev/null || echo "N/A")
    LASTLOGIN=$(timeout 1 last -n 1 "$USER" 2>/dev/null | head -1 | awk '{$1=""; print $0}' | xargs || echo "N/A")
    BREW_OUTDATED=$(timeout 2 brew outdated --quiet 2>/dev/null | wc -l | tr -d ' ' || echo "0")
  else
    # Use version without timeout
    IPs=$(ifconfig en0 2>/dev/null | grep 'inet ' | awk '{print $2}' || echo "N/A")
    if [ "$IPs" = "N/A" ]; then
      IPs=$(ifconfig en1 2>/dev/null | grep 'inet ' | awk '{print $2}' || echo "N/A")
    fi
    EXTERNAL_IP=$(curl -s --max-time 2 ifconfig.me 2>/dev/null || echo "N/A")
    LASTLOGIN=$(last -n 1 "$USER" 2>/dev/null | head -1 | awk '{$1=""; print $0}' | xargs || echo "N/A")
    BREW_OUTDATED=$(brew outdated --quiet 2>/dev/null | wc -l | tr -d ' ' || echo "0")
  fi
  
  UPTIME=$(uptime | sed 's/.*up \([^,]*\).*/\1/')
  USERS=$(who | wc -l | tr -d ' ')
  LOAD=$(uptime | awk -F'load averages: ' '{print $2}')
  DISK=$(df -h / | awk 'NR==2 {print $5 " used on " $2}')

  # Faster memory info - avoid system_profiler
  TOTAL_MEM=$(sysctl -n hw.memsize | awk '{print int($1/1024/1024/1024) "GB"}')
  MEM_INFO=$(vm_stat | awk -v total="$TOTAL_MEM" '
    /page size/ { gsub(/[^0-9]/, "", $0); pagesize = $0 }
    /Pages free/ { free = $3 }
    END {
      gsub(/\./, "", free)
      free_mb = (free * pagesize) / 1024 / 1024
      printf "%.0fMB free / %s", free_mb, total
    }')

  DATE=$(date)

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

  # Brew status
  if [ "$BREW_OUTDATED" -eq 0 ] 2>/dev/null; then
    BREW_STATUS="Up to date"
  else
    BREW_STATUS="$BREW_OUTDATED packages need updates"
  fi

  # Weather using zipcode variable
  WEATHER=$(curl -s --max-time 2 "wttr.in/$WEATHER_ZIPCODE?format=%C+%t" 2>/dev/null || echo "N/A")

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
  printf "${BORDER_COLOR}****************************************************${NC}\n"
}

# Test it
echo "Testing the fixed banner function..."
print_fun_banner