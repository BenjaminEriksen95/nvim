print("Packer installed use :PackerSync to install packages")

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.5',
		-- or                            , branch = '0.1.x',
		requires = { {'nvim-lua/plenary.nvim'} }
	}
	use({ "rose-pine/neovim", 
	as = "rose-pine",
	config = function()
		vim.cmd('colorscheme rose-pine')
	end})
	use ({"folke/tokyonight.nvim",
	config = function()
		vim.cmd('colorscheme tokyonight')
	end})

	use ( 'nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})

	use ( 'nvim-treesitter/playground', {run = ':TSUpdate'})
	use("theprimeagen/harpoon")
	use {
		"ThePrimeagen/refactoring.nvim",
		requires = {
			{"nvim-lua/plenary.nvim"},
			{"nvim-treesitter/nvim-treesitter"}
		}
	}
	use("mbbill/undotree")
	use("laytan/cloak.nvim")
	use("tpope/vim-fugitive")

	use {
		'cameron-wags/rainbow_csv.nvim',
		config = function()
			require 'rainbow_csv'.setup()
		end,
		-- optional lazy-loading below
		module = {
			'rainbow_csv',
			'rainbow_csv.fns'
		},
		ft = {
			'csv',
			'tsv',
			'csv_semicolon',
			'csv_whitespace',
			'csv_pipe',
			'rfc_csv',
			'rfc_semicolon'
		}
	}

end)
