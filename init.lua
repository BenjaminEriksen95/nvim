vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.env.PATH = vim.env.PATH .. ":" .. vim.fn.expand("~/.local/bin")

-- Options --------------------------------------------------------------------
vim.o.number = true
vim.o.cursorline = true
vim.o.relativenumber = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.wrap = false
vim.o.swapfile = false
vim.o.backup = false
vim.o.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.o.undofile = true
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.inccommand = "split"
vim.o.termguicolors = true
vim.o.scrolloff = 8
vim.o.signcolumn = "yes"
vim.o.updatetime = 50
vim.o.colorcolumn = "125"
vim.opt.shortmess:append("I")

-- General Mappings --------------------------------------------------------------------
local map = vim.keymap.set
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- map("n", "<leader>Y", [["+Y]], { desc = '[Y]ank line OS'})
map({ "v", "x" }, "<leader>y", [["+y]], { desc = "[Y]ank selection OS" })

-- Let visual-mode J/K win over LSP hover
map("v", "J", ":move '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":move '<-2<CR>gv=gv", { desc = "Move selection up" })

map("n", "n", "nzzzv", { desc = "Overwrite [n]ext to center around item" })
map("n", "N", "Nzzzv", { desc = "Overwrite reverse [N]ext to center around item" })

-- Bind format only when LSP is attached
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        map("n", "<leader>lf", vim.lsp.buf.format, { buffer = args.buf })
    end,
})

-- Plugins --------------------------------------------------------------------
vim.pack.add({
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
	{ src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
	{ src = "https://github.com/Saghen/blink.cmp"},
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim", version = "0.1.8" },
	{ src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },
	{ src = "https://github.com/folke/which-key.nvim" },
	{ src = "https://github.com/folke/trouble.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/sustech-data/wildfire.nvim" },
	{ src = "https://github.com/smoka7/hop.nvim" },
	{ src = "https://github.com/0Risotto/rainbow12" },
	{ src = "https://github.com/nvimdev/dashboard-nvim" },
	{ src = "https://github.com/folke/snacks.nvim" },

	-- Plugins --------------------------------------------------------------------

	-- { src = "https://github.com/L3MON4D3/LuaSnip" },
	-- { src = "https://github.com/rafamadriz/friendly-snippets" },
})

require("snacks").setup({
	bigfile = { enabled = true },
	dashboard = { enabled = false },
	indent = { enabled = true },
	input = { enabled = true },
	notifier = { enabled = true },
	quickfile = { enabled = true },
	scope = { enabled = true },
	scroll = { enabled = true },
	statuscolumn = { enabled = true },
	words = { enabled = true },
	image = { enabled = true },
})

vim.cmd("colorscheme rainbow12")

-- Package manager --------------------------------------------------------------------
require("mason").setup()

-- Lsp --------------------------------------------------------------------
require("mason-lspconfig").setup()
require("mason-tool-installer").setup({
	ensure_installed = {
		"lua_ls",
		"stylua",
		"basedpyright",
		"rust-analyzer",
	},
})

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = {
					"vim",
					"require",
				},
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
			telemetry = {
				enable = false,
			},
		},
	},
})

require'nvim-treesitter'.install { 'java', 'python' }
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "java", "python" },
    callback = function() pcall(vim.treesitter.start) end,
})

require("blink.cmp").setup({
    signature = { enabled = true },
    keymap = {
        preset = "default",
        ["<C-space>"] = {},
        ["<C-p>"] = {},
        ["<Tab>"] = {},
        ["<S-Tab>"] = {},
        ["<C-y>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-n>"] = { "select_and_accept" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-b>"] = { "scroll_documentation_down", "fallback" },
        ["<C-f>"] = { "scroll_documentation_up", "fallback" },
        ["<C-l>"] = { "snippet_forward", "fallback" },
        ["<C-h>"] = { "snippet_backward", "fallback" },
        -- ["<C-e>"] = { "hide" },
    },
    completion = {
		documentation = { auto_show = true, auto_show_delay_ms = 500 },
		menu = {
			auto_show = true,
			draw = {
				treesitter = { "lsp" },
				columns = { { "kind_icon", "label", "label_description", gap = 1 }, { "kind" } },
			},
		},
	},
    fuzzy = { implementation = "prefer_rust", prebuilt_binaries = { force_version = "1.8.0"}}

})

-- File Navigation
require("oil").setup()
local telescope = require("telescope")

telescope.setup({
	defaults = {
		preview = { treesitter = false },
		color_devicons = true,
		selection_caret = "➜ ",
		sorting_strategy = "ascending",
		layout_strategy = "horizontal",
		path_display = { "smart" },
		layout_config = {
			prompt_position = "top",
			preview_cutoff = 40,
		},
	},
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
		["ui-select"] = {
			require("telescope.themes").get_dropdown(),
		},
	},
})

telescope.load_extension("fzf")
telescope.load_extension("ui-select")

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
vim.keymap.set("n", "<leader>/", function()
	builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end, { desc = "Fuzzy search current buffer" })

require("trouble").setup({
    cmd = "Trouble",
})

local wk = require("which-key")
wk.setup({})
wk.add({
	{ "<leader>f", group = "File" },
	{ "<leader>s", group = "Search" },
	{ "<leader>d", group = "Debug" },
	{ "<leader>x", group = "Diagnostics" },
	{ "<leader>fn", desc = "New File" },
	{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File", mode = "n" },
	{ "<leader>fo", "<cmd>Oil<cr>", desc = "Find Oil", mode = "n" },
	{
		"<leader>xL",
		"<cmd>Trouble loclist toggle<cr>",
		desc = "Location List (Trouble)",
	},
	{
		"<leader>xx",
		"<cmd>Trouble diagnostics toggle<cr>",
		desc = "Diagnostics (Trouble)",
	},
	{
		"<leader>xX",
		"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
		desc = "Buffer Diagnostics (Trouble)",
	},
	{
		"<leader>cs",
		"<cmd>Trouble symbols toggle focus=false<cr>",
		desc = "Symbols (Trouble)",
	},
	{
		"<leader>cl",
		"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
		desc = "LSP Definitions / references / ... (Trouble)",
	},
	{
		"<leader>xQ",
		"<cmd>Trouble qflist toggle<cr>",
		desc = "Quickfix List (Trouble)",
	},
	{
		mode = { "n", "v" },
		{ "<leader>o", "<cmd>update<cr> :source<cr>", desc = "Source" },
		{ "<leader>q", "<cmd>quit<cr>", desc = "Quit" },
		{ "<leader>w", "<cmd>write<cr>", desc = "Write" },
	},
})

require("wildfire").setup()

-- Hop
local hop = require("hop")
local directions = require("hop.hint").HintDirection
hop.setup()
map("", "f", function() hop.hint_char1({ direction = directions.AFTER_CURSOR,  current_line_only = true }) end, { remap = true })
map("", "F", function() hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true }) end, { remap = true })
map("", "t", function() hop.hint_char1({ direction = directions.AFTER_CURSOR,  current_line_only = true, hint_offset = -1 }) end, { remap = true })
map("", "T", function() hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1  }) end, { remap = true })
map({ "n", "v" }, "s", "<cmd>HopChar1<CR>", { silent = true, noremap = true })
map({ "n", "v" }, "S", "<cmd>HopChar2<CR>", { silent = true, noremap = true })

-- Plugin Mappings --------------------------------------------------------------------
map("n", "<leader>pv", "<Cmd>Oil<CR>", { desc = "Oil" })
map("n", "<leader>bd", function() Snacks.bufdelete() end, { desc = "Delete Buffer" })
map("n", "<leader>n", function() Snacks.notifier.show_history() end, { desc = "Notification History" })
map("n", "<leader>un", function() Snacks.notifier.hide() end, { desc = "Dismiss Notifications" })
map("n", "<leader>.", function() Snacks.scratch() end, { desc = "Scratch Buffer" })
map("n", "<leader>z", function() Snacks.zen() end, { desc = "Zen Mode" })
map("n", "<leader>gg", function() Snacks.lazygit() end, { desc = "Lazygit" })
map({ "n", "v" }, "<leader>gB", function() Snacks.gitbrowse() end, { desc = "Git Browse" })
map("n", "<c-/>", function() Snacks.terminal() end, { desc = "Terminal" })
map("n", "<c-_>", function() Snacks.terminal() end, { desc = "which_key_ignore" })
map({ "n", "t" }, "]]", function() Snacks.words.jump(vim.v.count1) end, { desc = "Next Reference" })
map({ "n", "t" }, "[[", function() Snacks.words.jump(-vim.v.count1) end, { desc = "Prev Reference" })

-- Dashboard --------------------------------------------------------------------
require("dashboard").setup({
	theme = "hyper",
	config = {
		week_header = { enable = true },
		shortcut = {
			{ desc = "Files", group = "Function", action = "Telescope find_files", key = "f" },
			{ desc = "Grep", group = "Identifier", action = "Telescope live_grep", key = "g" },
			{ desc = "Oil", group = "Type", action = "Oil", key = "e" },
			{ desc = "Quit", group = "Statement", action = "qa", key = "q" },
		},
		packages = { enable = true },
		project = { enable = true, limit = 8, action = "Telescope find_files cwd=" },
		mru = { enable = true, limit = 8 },
	},
})

vim.api.nvim_set_hl(0, "DashboardHeader", { fg = "#36afc7" })
vim.api.nvim_set_hl(0, "DashboardFooter", { fg = "#695c59" })
vim.api.nvim_set_hl(0, "DashboardProjectTitle", { fg = "#6a41a7", bold = true })
vim.api.nvim_set_hl(0, "DashboardProjectTitleIcon", { fg = "#d68d45" })
vim.api.nvim_set_hl(0, "DashboardProjectIcon", { fg = "#4665b0" })
vim.api.nvim_set_hl(0, "DashboardMruTitle", { fg = "#6a41a7", bold = true })
vim.api.nvim_set_hl(0, "DashboardMruIcon", { fg = "#d68d45" })
vim.api.nvim_set_hl(0, "DashboardFiles", { fg = "#d0d2cd" })
vim.api.nvim_set_hl(0, "DashboardShortCut", { fg = "#e5d32f" })
vim.api.nvim_set_hl(0, "DashboardShortCutIcon", { fg = "#3bd37f" })
