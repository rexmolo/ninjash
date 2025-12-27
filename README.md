# NinjaShell (ninjash)

Developer productivity utilities for macOS and Linux. Quick, focused, single-purpose tools to streamline your development workflow.

## Features

- **Simple CLI interface** - Brew-style command system
- **Automatic virtual environment activation** - No manual sourcing required
- **Git branch cleanup** - Automatically remove merged branches
- **Port management** - Find and kill processes on occupied ports
- **Jupyter kernel setup** - Easy project-specific kernel installation

## Installation

### Option 1: Automated Installation (Recommended)

```bash
# Clone the repository
git clone https://github.com/rexmolo/ninjash.git
cd ninjash

# Run the installer
./install.sh

# Reload your shell
source ~/.bashrc  # or ~/.zshrc
# or restart your terminal
```

### Option 2: Manual Installation

```bash
# Clone the repository
git clone https://github.com/rexmolo/ninjash.git

# Add to your PATH (in ~/.bashrc or ~/.zshrc)
export PATH="/path/to/ninjash:$PATH"

# Make scripts executable
chmod +x ninjash bin/*

# Reload your shell
source ~/.bashrc  # or ~/.zshrc
```

## Quick Start

View all available commands:
```bash
ninjash
```

Run a command:
```bash
ninjash c_venv              # Create/activate virtual environment
ninjash cleanup_branch      # Clean up merged Git branches
ninjash port_checker 3000   # Check port 3000
```

## Available Commands

### c_venv

Create and activate Python virtual environments automatically.

**Usage:** `ninjash c_venv`

**Features:**
- Creates `.venv` directory if it doesn't exist
- Automatically spawns new shell with venv activated
- Type `exit` to return to your normal shell
- Detects if venv is already activated

**Example:**
```bash
$ ninjash c_venv
🐍 Python info:
Python 3.11.5
/usr/bin/python

No virtual environment found.
Do you want to create one here? (yes/no): yes
📦 Creating virtual environment...
✅ Virtual environment created at /path/to/project/.venv
✅ Activating virtual environment...
(Type 'exit' to return to your original shell)
(.venv) $
```

### cleanup_branch

Automatically clean up merged local Git branches.

**Usage:** `ninjash cleanup_branch`

**Features:**
- Removes local branches whose remotes have been deleted
- Only deletes branches that have been merged to main/develop
- Automatically detects your default branch
- Safe - won't delete unmerged branches

**Example:**
```bash
$ ninjash cleanup_branch
Fetching and pruning remote branches...
Cleaning up merged local branches...
Deleting local branch: feature/old-feature
Deleting local branch: bugfix/fixed-bug
✅ Cleanup complete.
```

### jupyter_c_ipy

Install and register Jupyter kernel for current project.

**Usage:** `ninjash jupyter_c_ipy`

**Features:**
- Must be run inside an activated virtual environment
- Installs ipykernel package
- Creates kernel named after your project folder
- Lists all installed kernels when done

**Example:**
```bash
(.venv) $ ninjash jupyter_c_ipy
✅ Virtual environment detected: /path/to/project/.venv
Installing ipykernel...
Installed kernelspec my-project in /Users/you/Library/Jupyter/kernels/my-project
📜 Installed Jupyter kernels:
Available kernels:
  my-project    /Users/you/Library/Jupyter/kernels/my-project
  python3       /usr/local/share/jupyter/kernels/python3
```

### port_checker

Check and kill processes using specified ports.

**Usage:** `ninjash port_checker [PORT...]`

**Features:**
- Checks port occupancy using lsof
- Defaults to ports 3000-3003 if none specified
- Interactive prompts for killing processes
- Attempts graceful shutdown (SIGTERM) before force kill (SIGKILL)
- Handles permission issues with sudo

**Example:**
```bash
$ ninjash port_checker 3000 8080
Checking ports: 3000 8080

Port 3000 — in use
  PID: 12345
  Command: node
  User: yourname

Kill PID 12345 (command: node) on port 3000? [y/N]: y
Sending SIGTERM to 12345...
Killed process 12345.

Port 8080 — free

Done.
```

## Advanced Usage

### Direct Command Access

For convenience, you can enable direct command access (without the `ninjash` prefix):

```bash
# Add this to your ~/.bashrc or ~/.zshrc
source /path/to/ninjash/init.sh

# Reload your shell
source ~/.bashrc  # or ~/.zshrc

# Now you can use commands directly
c_venv              # instead of 'ninjash c_venv'
cleanup_branch      # instead of 'ninjash cleanup_branch'
jupyter_c_ipy       # instead of 'ninjash jupyter_c_ipy'
port_checker        # instead of 'ninjash port_checker'
```

The installer script (`./install.sh`) offers to set this up automatically.

## How c_venv Auto-Activation Works

Unlike other venv tools that require manual sourcing, `ninjash c_venv` uses a clever technique:

1. Creates or finds your `.venv` directory
2. Spawns a new shell with the venv pre-activated
3. You're immediately working in the activated environment
4. Type `exit` to return to your original shell

**Technical note:** Scripts run in subshells and cannot modify the parent shell's environment. The solution is to spawn a new interactive shell with the venv activated using `exec $SHELL -c "source .venv/bin/activate && exec $SHELL"`.

## Requirements

- **macOS or Linux**
- **Bash or Zsh** shell
- **Python 3** (for c_venv and jupyter_c_ipy)
- **Git** (for cleanup_branch)
- **lsof** (for port_checker - standard on macOS)

## Project Structure

```
ninjash/
├── ninjash              # Main CLI entry point
├── init.sh              # Shell functions for direct command access
├── install.sh           # Installation helper script
├── bin/
│   ├── c_venv          # Virtual environment manager
│   ├── cleanup_branch  # Git branch cleanup
│   ├── jupyter_c_ipy   # Jupyter kernel installer
│   └── port_checker    # Port checker and process killer
├── README.md
└── LICENSE
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

Apache License 2.0 - see LICENSE file for details

## Author

Created to make developer workflows faster and more efficient.
