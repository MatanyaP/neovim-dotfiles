# Neovim Configuration

My personal Neovim configuration focused on Python and Lua development.

## Features

- 🎨 Gruvbox color scheme with hard contrast
- 🔍 Full LSP support with:
  - Python (Pyright)
  - Lua
- ✨ Code formatting with:
  - Black (Python)
  - StyLua (Lua)
- 📝 Code completion using:
  - nvim-cmp
  - Copilot
  - LuaSnip
- 🔎 Fuzzy finding with Telescope
- 🌳 File explorer with Neo-tree
- 📦 Plugin management with lazy.nvim

## Prerequisites

- Neovim >= 0.9.0
- Git
- A Nerd Font (for icons)
- Node.js (for LSP servers)
- Python 3.x

## Installation

1. Backup your existing Neovim configuration if you have one:
```bash
mv ~/.config/nvim ~/.config/nvim.bak
```

2. Clone this repository:
```bash
git clone https://github.com/YOUR_USERNAME/nvim-config.git ~/.config/nvim
```

3. Start Neovim:
```bash
nvim
```

The configuration will automatically:
- Install lazy.nvim (plugin manager)
- Install all plugins
- Install LSP servers, formatters, and linters

## Key Mappings

### General
- `<Space>` - Leader key
- `<C-\>` - Toggle terminal
- `<C-h/j/k/l>` - Window navigation

### LSP
- `K` - Hover documentation
- `gd` - Go to definition
- `gr` - Find references
- `gi` - Find implementation

### File Navigation
- `<leader>fb` - Fuzzy find in current buffer

## Directory Structure

```
~/.config/nvim/
├── init.lua                 # Main configuration entry point
├── lazy-lock.json          # Plugin versions lock file
├── stylua.toml             # Lua formatter configuration
└── lua/
    ├── config/             # Core configuration
    │   ├── autocmds.lua    # Autocommands
    │   ├── keymaps.lua     # Key mappings
    │   ├── lazy.lua        # Plugin manager setup
    │   └── options.lua     # Neovim options
    └── plugins/            # Plugin configurations
        ├── completion.lua  # Completion setup
        ├── lsp.lua        # LSP configuration
        ├── treesitter.lua # Treesitter setup
        └── ...
```

## Updating

1. Update the repository:
```bash
cd ~/.config/nvim
git pull
```

2. Update plugins in Neovim:
```
:Lazy update
```

## Customization

You can customize this configuration by:
1. Modifying plugin configurations in `lua/plugins/`
2. Adjusting core settings in `lua/config/`
3. Adding new plugins to any file in `lua/plugins/`

## License

MIT
