# Multi-Machine Dotfiles Sync Guide

Complete guide for keeping your terminal environment synchronized across multiple Macs.

## Overview

This dotfiles repository supports seamless synchronization between multiple machines using Git and SSH authentication. Each machine maintains its own SSH keys while sharing the same terminal configuration.

## Initial Setup

### First Machine (Already Done - fnix)
- ✅ Cloned dotfiles repository  
- ✅ Ran fresh-mac-install.sh
- ✅ Generated SSH keys
- ✅ Added SSH keys to GitHub
- ✅ Configured git for SSH authentication
- ✅ Created private SSH key backup

### Adding Second Machine (MacAir)

1. **Generate SSH keys**:
   ```bash
   ssh-keygen -t ed25519 -C "your-email@example.com"
   pbcopy < ~/.ssh/id_ed25519.pub
   ```

2. **Add SSH key to GitHub**:
   - Go to https://github.com/settings/ssh/new
   - Title: "MacAir Personal"
   - Paste key and save

3. **Clone and setup dotfiles**:
   ```bash
   git clone git@github.com:nixfred/mac-bashrc.git ~/dotfiles
   cd ~/dotfiles
   ./fresh-mac-install.sh
   ```

4. **Test sync capability**:
   ```bash
   cd ~/dotfiles
   echo "# Test from MacAir" >> sync-test.txt
   git add . && git commit -m "Test sync from MacAir"
   git push
   ```

## Daily Sync Workflow

### Making Changes
On any machine, after modifying dotfiles:

```bash
cd ~/dotfiles

# Stage all changes
git add .

# Commit with descriptive message
git commit -m "Add new aliases for Docker commands"

# Push to GitHub
git push
```

### Pulling Changes
On other machines:

```bash
cd ~/dotfiles

# Pull latest changes
git pull

# Reload shell if needed
source ~/.zshrc  # or source ~/.bashrc
```

### Quick Sync Aliases (Built-in)
These aliases are already configured in your shell:

```bash
# Push changes
upzsh       # Push .zshrc changes
upbash      # Push .bashrc changes  

# Pull changes
downzsh     # Pull and reload .zshrc
downbash    # Pull and reload .bashrc
```

## Configuration Management

### Machine-Specific Settings
Use the portable configuration system for machine-specific customizations:

**Personal settings** (not synced):
```bash
# ~/.env.local - Environment variables and API keys
export WEATHER_ZIPCODE="30677"
export OPENAI_API_KEY="your-key"

# ~/.bashrc.personal - SSH shortcuts and personal aliases
alias macair='ssh user@macair.local'
alias homeserver='ssh admin@192.168.1.100'
```

**Template files** (synced across machines):
- `.bashrc.template` - Portable bash configuration
- `.zshrc.template` - Portable zsh configuration  
- `.env.local.template` - Template for environment variables

### Adding New Configurations

1. **Add to template files** for settings that should sync
2. **Add to personal files** for machine-specific settings
3. **Test on current machine**
4. **Commit and push** to sync with other machines

```bash
# Example: Add new alias to sync across machines
echo 'alias ll="eza -la"' >> ~/dotfiles/.zshrc.template

# Commit and push
cd ~/dotfiles
git add .zshrc.template
git commit -m "Add enhanced ll alias using eza"
git push
```

## SSH Key Management

### Key Strategy
- Each machine has its own SSH key pair
- Private keys stay on their respective machines
- Public keys are added to GitHub
- Private backup repositories for recovery

### Backup SSH Keys (Optional)
For important machines, create private backup repositories:

```bash
# Create backup for new machine
mkdir ~/macair-ssh-keys && cd ~/macair-ssh-keys
git init
cp ~/.ssh/id_* .
cp ~/.ssh/authorized_keys .
echo "# SSH Keys for MacAir" > README.md
git add . && git commit -m "Initial SSH backup"

# Create private repo on GitHub, then:
git remote add origin git@github.com:nixfred/macair-ssh-keys.git
git push -u origin main
```

## Troubleshooting

### Sync Issues

**Git push fails with authentication error:**
```bash
# Check remote URL (should be SSH, not HTTPS)
git remote -v

# If HTTPS, switch to SSH:
git remote set-url origin git@github.com:nixfred/mac-bashrc.git
```

**SSH authentication fails:**
```bash
# Test GitHub connection
ssh -T git@github.com

# Add SSH key to agent if needed
ssh-add ~/.ssh/id_ed25519
```

### Merge Conflicts
If you modify the same files on multiple machines:

```bash
cd ~/dotfiles
git pull  # May show merge conflict

# Edit conflicted files to resolve
git add .
git commit -m "Resolve merge conflict"
git push
```

### Shell Not Updating
After pulling changes:

```bash
# Reload shell configuration
source ~/.zshrc     # For zsh
source ~/.bashrc    # For bash

# Or restart terminal
```

## Best Practices

1. **Commit frequently** - Small, focused commits are easier to manage
2. **Pull before push** - Avoid conflicts by staying up to date
3. **Use descriptive commit messages** - Makes it easier to track changes
4. **Test changes** - Ensure new configurations work before committing
5. **Keep personal data private** - Use `.env.local` and `.bashrc.personal`
6. **Backup SSH keys** - For critical machines, maintain private backups

## Advanced Sync

### Automated Sync (Optional)
Add to your shell configuration for automatic sync:

```bash
# Add to ~/.bashrc.personal or ~/.zshrc.personal
dotfiles_sync() {
    cd ~/dotfiles
    git add . 2>/dev/null
    if git diff --staged --exit-code >/dev/null; then
        echo "No changes to sync"
    else
        git commit -m "Auto-sync from $(hostname) - $(date)"
        git push
        echo "Dotfiles synced successfully"
    fi
    cd - >/dev/null
}

# Optional: Auto-sync on shell exit
trap dotfiles_sync EXIT
```

This system ensures your terminal environment stays consistent across all your machines while maintaining security and flexibility.