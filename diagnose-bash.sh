#!/bin/sh
# Diagnostic script to check bash issues

echo "=== Bash Diagnostic ==="
echo "1. Testing /bin/sh (should work):"
/bin/sh -c "echo '   ✓ /bin/sh works'"

echo -e "\n2. Testing /bin/bash without config:"
/bin/bash --norc --noprofile -c "echo '   ✓ /bin/bash works without config'" || echo "   ✗ /bin/bash failed"

echo -e "\n3. Testing /usr/local/bin/bash (Homebrew):"
if [ -f /usr/local/bin/bash ]; then
    /usr/local/bin/bash --norc --noprofile -c "echo '   ✓ Homebrew bash works'" || echo "   ✗ Homebrew bash failed"
else
    echo "   - Homebrew bash not found at /usr/local/bin/bash"
fi

echo -e "\n4. Testing /opt/homebrew/bin/bash (Apple Silicon):"
if [ -f /opt/homebrew/bin/bash ]; then
    /opt/homebrew/bin/bash --norc --noprofile -c "echo '   ✓ Homebrew bash (ARM) works'" || echo "   ✗ Homebrew bash (ARM) failed"
else
    echo "   - Homebrew bash not found at /opt/homebrew/bin/bash"
fi

echo -e "\n5. Current shell: $SHELL"
echo "6. Bash version: $(/bin/bash --version | head -1)"

echo -e "\n7. Check for problematic startup files:"
for file in ~/.bashrc ~/.bash_profile ~/.profile ~/.bash_login; do
    if [ -f "$file" ]; then
        echo "   - $file exists ($(wc -l < "$file") lines)"
    fi
done

echo -e "\n8. Check for infinite loops or sourcing issues:"
grep -n "source\|^\." ~/.bashrc ~/.bash_profile 2>/dev/null | grep -v "^Binary" || echo "   No sourcing found"

echo -e "\nTo fix bash hanging, try:"
echo "1. Move config files temporarily: mv ~/.bashrc ~/.bashrc.backup"
echo "2. Test bash: /bin/bash"
echo "3. If it works, gradually add back config sections"