# Personal Setup Instructions

## 🔑 Private Backup Created

A backup of your personal configurations has been saved to `~/personal-config-backup.txt` 
**Keep this file private and secure!**

## 🏠 Portable Configuration System  

The dotfiles in this repository are now **machine-agnostic**! Template files (`.bashrc.template`, `.zshrc.template`) contain no hardcoded paths, IPs, or personal data.

### 🎯 **Quick Setup for Any Mac**

#### 1. Set Your Weather Location
```bash
echo 'export WEATHER_ZIPCODE="30677"' >> ~/.env.local
```

#### 2. Add Your SSH Shortcuts
Create `~/.bashrc.personal` and `~/.zshrc.personal`:
```bash
# Personal SSH shortcuts
alias ron='ssh pi@100.100.111.39'
alias pp='ssh pi@pi'  
alias rr='ssh pi@10.0.0.155'
alias mm='ssh macpro-bta.humpback-cloud.ts.net'
alias pi='ssh pi@100.90.162.30'

# Add other personal aliases and functions here
alias myserver='ssh user@your-server.com'
```

#### 3. Add API Keys to ~/.env.local
```bash
export OPENAI_API_KEY="your-key-here"
export ANTHROPIC_API_KEY="your-key-here"
export GITHUB_TOKEN="your-github-token"
# etc...
```

### 📋 **File Organization**
- **Public Repository**: Template files with no personal data
- **Private Local Files**: Personal customizations (git-ignored)
  - `~/.env.local` - API keys and environment variables
  - `~/.bashrc.personal` - Personal aliases and SSH shortcuts
  - `~/.zshrc.personal` - Personal zsh customizations

## 🛡️ Sudo Without Password (macOS)

⚠️ **SECURITY WARNING**: This removes sudo password prompts. Only do this on personal machines!

### Method 1: User-specific (Recommended)
```bash
sudo visudo
```
Add this line at the end:
```
pi ALL=(ALL) NOPASSWD:ALL
```

### Method 2: Admin group (Less secure)
```bash
sudo visudo
```
Find the line:
```
%admin ALL=(ALL) ALL
```
Change it to:
```
%admin ALL=(ALL) NOPASSWD:ALL
```

### Method 3: Specific commands only (Most secure)
```bash
sudo visudo
```
Add:
```
pi ALL=(ALL) NOPASSWD: /usr/bin/brew, /usr/sbin/brew, /bin/rm, /usr/bin/killall
```

## 🗑️ Remove Metasploit Manually

Since Homebrew can't use sudo, remove metasploit manually:
```bash
# Method 1: Manual removal
sudo rm -rf /opt/metasploit-framework
sudo pkgutil --forget com.rapid7.metasploit

# Method 2: Try without cask
brew uninstall metasploit 2>/dev/null || echo "Already removed"
```

## 🔄 Apply Changes

After setup, reload your shell:
```bash
source ~/.bashrc
source ~/.zshrc
```

## 📁 File Organization

- `~/.env.local` - API keys and secrets (not in git)
- `~/.bashrc.personal` - Personal aliases and functions (not in git)  
- `~/personal-config-backup.txt` - Your private backup (keep secure)
- `~/dotfiles/` - Portable dotfiles repository