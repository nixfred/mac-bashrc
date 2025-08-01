#!/bin/bash

# Ultra-fast version of print_fun_banner
print_fun_banner() {
  HOST=$(hostname)
  # Use hostname -I alternative for Mac that's faster
  IPs=$(ifconfig -a inet 2>/dev/null | grep -E "inet[[:space:]]" | grep -v 127.0.0.1 | awk '{print $2}' | head -3 | tr '\n' ' ')
  UPTIME=$(uptime | sed 's/.*up \([^,]*\).*/\1/')
  USERS=$(who | wc -l | tr -d ' ')
  LOAD=$(uptime | awk -F'load averages: ' '{print $2}')
  DISK=$(df -h / | awk 'NR==2 {print $5 " used"}')
  
  # Simple memory info
  MEM_INFO="Run 'vm_stat' for details"
  
  DATE=$(date '+%Y-%m-%d %H:%M:%S')
  
  # macOS version
  MACOS_VER=$(sw_vers -productVersion)
  
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
  printf "${BORDER_COLOR}*${LABEL_COLOR}  IPs:         ${VALUE_COLOR}%-30s${BORDER_COLOR}*${NC}\n" "${IPs:-checking...}"
  printf "${BORDER_COLOR}*${LABEL_COLOR}  Uptime:      ${VALUE_COLOR}%-30s${BORDER_COLOR}*${NC}\n" "$UPTIME"
  printf "${BORDER_COLOR}*${LABEL_COLOR}  Users:       ${VALUE_COLOR}%-30s${BORDER_COLOR}*${NC}\n" "$USERS"
  printf "${BORDER_COLOR}*${LABEL_COLOR}  Load:        ${VALUE_COLOR}%-30s${BORDER_COLOR}*${NC}\n" "$LOAD"
  printf "${BORDER_COLOR}*${LABEL_COLOR}  Disk:        ${VALUE_COLOR}%-30s${BORDER_COLOR}*${NC}\n" "$DISK"
  printf "${BORDER_COLOR}*${LABEL_COLOR}  Memory:      ${VALUE_COLOR}%-30s${BORDER_COLOR}*${NC}\n" "$MEM_INFO"
  printf "${BORDER_COLOR}*${LABEL_COLOR}  Date:        ${VALUE_COLOR}%-30s${BORDER_COLOR}*${NC}\n" "$DATE"
  printf "${BORDER_COLOR}****************************************************${NC}\n"
}

# Simple fast version without network calls
print_minimal_banner() {
  HOST=$(hostname)
  UPTIME=$(uptime | awk -F'up ' '{print $2}' | awk -F',' '{print $1}')
  LOAD=$(uptime | awk -F'load averages: ' '{print $2}')
  DISK=$(df -h / | awk 'NR==2 {print $5}')
  DATE=$(date '+%a %b %d %H:%M')
  
  echo "================================================"
  echo "  🖥️  $HOST | macOS $(sw_vers -productVersion)"
  echo "  ⏱️  Up: $UPTIME | Load: $LOAD | Disk: $DISK"
  echo "  📅  $DATE"
  echo "================================================"
}

# Test both versions
echo "Testing minimal banner..."
time print_minimal_banner

echo -e "\nTesting full banner with timeout..."
timeout 2 bash -c "$(declare -f print_fun_banner); print_fun_banner" || echo "Banner timed out"