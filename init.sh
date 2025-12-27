#!/bin/bash
# NinjaShell initialization file
# Source this in ~/.bashrc or ~/.zshrc for direct command access
#
# Usage:
#   echo 'source /path/to/ninjash/init.sh' >> ~/.bashrc
#   source ~/.bashrc
#
# This allows you to use commands directly:
#   c_venv             instead of    ninjash c_venv
#   cleanup_branch     instead of    ninjash cleanup_branch
#   jupyter_c_ipy      instead of    ninjash jupyter_c_ipy
#   port_checker       instead of    ninjash port_checker

# Detect ninjash directory
NINJASH_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Create convenience functions for each command
c_venv() {
  "$NINJASH_DIR/ninjash" c_venv "$@"
}

cleanup_branch() {
  "$NINJASH_DIR/ninjash" cleanup_branch "$@"
}

jupyter_c_ipy() {
  "$NINJASH_DIR/ninjash" jupyter_c_ipy "$@"
}

port_checker() {
  "$NINJASH_DIR/ninjash" port_checker "$@"
}

# Optional: Export functions so they're available in subshells
export -f c_venv cleanup_branch jupyter_c_ipy port_checker 2>/dev/null || true
