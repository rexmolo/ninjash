#!/bin/bash
# NinjaShell Installation Script
# This script helps set up ninjash on your system

set -e

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${GREEN}📦 NinjaShell Installation${NC}"
echo

# Get absolute path to ninjash directory
NINJASH_PATH="$(cd "$(dirname "$0")" && pwd)"

# Step 1: Make all scripts executable
echo -e "${CYAN}Step 1: Making scripts executable...${NC}"
chmod +x "$NINJASH_PATH/ninjash"
chmod +x "$NINJASH_PATH/bin"/*
echo -e "${GREEN}✓ Scripts are now executable${NC}"
echo

# Step 2: Detect shell and config file
echo -e "${CYAN}Step 2: Detecting your shell configuration...${NC}"

# Detect shell config files
SHELL_CONFIGS=()
[ -f "$HOME/.bashrc" ] && SHELL_CONFIGS+=("$HOME/.bashrc")
[ -f "$HOME/.zshrc" ] && SHELL_CONFIGS+=("$HOME/.zshrc")

if [ ${#SHELL_CONFIGS[@]} -eq 0 ]; then
  echo -e "${YELLOW}⚠️  No shell config file found (.bashrc or .zshrc)${NC}"
  echo "Please create one and run this installer again."
  exit 1
fi

echo -e "${GREEN}✓ Found shell config(s):${NC}"
for config in "${SHELL_CONFIGS[@]}"; do
  echo "  - $config"
done
echo

# Step 3: Check if PATH is already set up
echo -e "${CYAN}Step 3: Checking PATH configuration...${NC}"

PATH_LINE="export PATH=\"$NINJASH_PATH:\$PATH\""
PATH_ALREADY_SET=false

for config in "${SHELL_CONFIGS[@]}"; do
  if grep -qF "$NINJASH_PATH" "$config" 2>/dev/null; then
    PATH_ALREADY_SET=true
    break
  fi
done

if [ "$PATH_ALREADY_SET" = true ]; then
  echo -e "${GREEN}✓ PATH already configured${NC}"
else
  echo -e "${YELLOW}PATH not yet configured${NC}"
  echo
  echo "Add this line to your shell config (~/.bashrc or ~/.zshrc):"
  echo -e "${CYAN}$PATH_LINE${NC}"
  echo
  read -p "Would you like me to add it automatically? [Y/n]: " add_path

  case "$add_path" in
    [Nn]* )
      echo -e "${YELLOW}Skipping automatic PATH setup${NC}"
      ;;
    * )
      # Add to first config file found
      echo >> "${SHELL_CONFIGS[0]}"
      echo "# NinjaShell PATH" >> "${SHELL_CONFIGS[0]}"
      echo "$PATH_LINE" >> "${SHELL_CONFIGS[0]}"
      echo -e "${GREEN}✓ Added PATH to ${SHELL_CONFIGS[0]}${NC}"
      ;;
  esac
fi
echo

# Step 4: Optional direct command access
echo -e "${CYAN}Step 4: Optional direct command access${NC}"
echo "This allows you to use commands directly without the 'ninjash' prefix"
echo "Example: 'c_venv' instead of 'ninjash c_venv'"
echo
read -p "Enable direct command access? [y/N]: " enable_direct

case "$enable_direct" in
  [Yy]* )
    INIT_LINE="source \"$NINJASH_PATH/init.sh\""
    INIT_ALREADY_SET=false

    for config in "${SHELL_CONFIGS[@]}"; do
      if grep -qF "init.sh" "$config" 2>/dev/null; then
        INIT_ALREADY_SET=true
        break
      fi
    done

    if [ "$INIT_ALREADY_SET" = true ]; then
      echo -e "${GREEN}✓ Direct command access already configured${NC}"
    else
      # Add to first config file found
      echo "# NinjaShell direct command access" >> "${SHELL_CONFIGS[0]}"
      echo "$INIT_LINE" >> "${SHELL_CONFIGS[0]}"
      echo -e "${GREEN}✓ Added init.sh to ${SHELL_CONFIGS[0]}${NC}"
    fi
    ;;
  * )
    echo -e "${YELLOW}Skipping direct command access${NC}"
    ;;
esac
echo

# Final instructions
echo -e "${GREEN}═══════════════════════════════════════${NC}"
echo -e "${GREEN}✅ Installation complete!${NC}"
echo -e "${GREEN}═══════════════════════════════════════${NC}"
echo
echo "Next steps:"
echo
echo "1. Reload your shell configuration:"
echo -e "   ${CYAN}source ~/.bashrc${NC}  # or ~/.zshrc"
echo "   (or restart your terminal)"
echo
echo "2. Try ninjash:"
echo -e "   ${CYAN}ninjash${NC}          # View all available commands"
echo -e "   ${CYAN}ninjash c_venv${NC}   # Create/activate virtual environment"
echo
echo "For more info, see: $NINJASH_PATH/README.md"
echo
