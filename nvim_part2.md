# Neovim as PDE
A good place to start is: [Kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)

# Pros and Cons
## Pros:
1. Reuseability: High, works for any language
2. Get closer to the tools that run under the hood
3. Configurability, easy to extend with lua plugins

## Cons:
1. Learning curve: HARD
2. Setup and maintenaince - custom stuff breaks (not applicable for bindings only)


## [Lazy](https://github.com/folke/lazy.nvim)
Neovim Package Manager
`:Lazy`

## Mason
Manage LSP, DAP, Linter, Formatter installations

## Plugins

### [telescope](https://github.com/nvim-telescope/telescope.nvim)
Customizable fuzzyfinder with many built-in search modes.
`:Telescope ...`

### [which-key.nvim]()
"Autocomplete" for bindings, very helpful when exploring nvim.

### [oil.nvim](https://github.com/stevearc/oil.nvim)
File explorer in a buffer.

### [vim-fugitive](https://github.com/tpope/vim-fugitive)
Alternative is [lazygit](https://github.com/jesseduffield/lazygit) which is a terminal ui and not a nvim plugin.

### [harpoon](https://github.com/ThePrimeagen/harpoon)
Navigation tool for quicly swapping between a small number of files.

### [trouble.nvim](https://github.com/folke/trouble.nvim)
Tool for tracking code issues (Treesitter, Linting, LSP)

### [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
Used for parsing code as a syntax tree that allows for efficient updating when code is edited.
`:InspectTree`

### [cloak.nvim](https://github.com/laytan/cloak.nvim)
Hides secrets in environment files.

# CLI Tools
## [tmux](https://github.com/tmux/tmux/wiki)
Terminal multiplexer. Gives access to terminal side by side with neovim.

## [lazygit](https://github.com/jesseduffield/lazygit)
Better git tool than any IDE!

## Setting up neovim
What do you need to get started?

