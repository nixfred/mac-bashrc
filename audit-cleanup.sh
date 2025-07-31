#!/bin/bash
# System Audit and Cleanup Script
# Reviews installed packages and removes unnecessary ones

echo "🔍 Auditing system packages..."

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${YELLOW}=== SECURITY/PENETRATION TESTING TOOLS (CONSIDER REMOVING) ===${NC}"
SECURITY_TOOLS=(
    "metasploit"
    "nmap" 
    "proxychains-ng"
)

for tool in "${SECURITY_TOOLS[@]}"; do
    if brew list "$tool" &> /dev/null || brew list --cask "$tool" &> /dev/null; then
        echo -e "${RED}⚠️  $tool - Security tool (remove if not needed)${NC}"
    fi
done

echo -e "\n${YELLOW}=== DUPLICATE/REDUNDANT TOOLS ===${NC}"
echo -e "${YELLOW}File listers (choose one):${NC}"
brew list | grep -E "^(eza|lsd|exa)$" | sed 's/^/  - /'

echo -e "\n${YELLOW}System monitors (choose one):${NC}"
brew list | grep -E "^(btop|bpytop|htop|glances)$" | sed 's/^/  - /'

echo -e "\n${YELLOW}=== RARELY USED TOOLS ===${NC}"
RARELY_USED=(
    "apache-arrow"
    "aribb24" 
    "asciinema"
    "b2-tools"
    "capstone"
    "cloudflared"
    "docker-machine"
    "dtc"
    "emacs"
    "ffmpeg"
    "figlet"
    "filebrowser"
    "grpc"
    "httrack"
    "iftop"
    "iperf3"
    "libvirt"
    "lolcat"
    "midnight-commander"
    "pandoc"
    "postgresql@14"
    "qemu"
    "screenresolution"
    "tesseract"
    "thefuck"
    "vnstat"
    "xclip"
)

for tool in "${RARELY_USED[@]}"; do
    if brew list "$tool" &> /dev/null; then
        echo -e "${YELLOW}❓ $tool - Consider if needed${NC}"
    fi
done

echo -e "\n${GREEN}=== RECOMMENDED REMOVALS ===${NC}"
cat << 'EOF'
# Remove security tools (unless you're a security professional)
brew uninstall --cask metasploit
brew uninstall nmap proxychains-ng

# Remove duplicate tools (keep preferred ones)
brew uninstall lsd           # Keep eza
brew uninstall bpytop        # Keep btop or htop

# Remove rarely used tools
brew uninstall asciinema b2-tools cloudflared docker-machine
brew uninstall emacs figlet filebrowser httrack iftop
brew uninstall lolcat midnight-commander pandoc qemu
brew uninstall screenresolution tesseract thefuck vnstat

# Clean up
brew autoremove
brew cleanup
EOF

echo -e "\n${YELLOW}Would you like to run the cleanup? (y/N)${NC}"
read -r response
if [[ "$response" =~ ^[Yy]$ ]]; then
    echo -e "${GREEN}Running cleanup...${NC}"
    
    # Remove security tools
    brew uninstall --cask metasploit 2>/dev/null
    brew uninstall nmap proxychains-ng 2>/dev/null
    
    # Remove duplicates
    brew uninstall lsd bpytop 2>/dev/null
    
    # Remove rarely used
    brew uninstall asciinema b2-tools cloudflared docker-machine 2>/dev/null
    brew uninstall emacs figlet filebrowser httrack iftop 2>/dev/null
    brew uninstall lolcat midnight-commander pandoc qemu 2>/dev/null
    brew uninstall screenresolution tesseract thefuck vnstat 2>/dev/null
    
    # Clean up
    brew autoremove
    brew cleanup
    
    echo -e "${GREEN}✅ Cleanup complete!${NC}"
else
    echo "Cleanup skipped. Review the recommendations above."
fi