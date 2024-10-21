return {
  "ray-x/go.nvim",
  dependencies = {  -- optional packages
    "ray-x/guihua.lua",
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
    "theHamsta/nvim-dap-virtual-text",
  },
  config = function()
    require("go").setup({
        -- verbose = true,
        goimports = "gopls",
        gofmt = "gofumpt",
        -- max_line_len = 120,
        trouble = true,
        lsp_cfg = true,
        lsp_keymaps = true,
        diagnostic = {
            hdlr = true,
            underline = true,
            virtual_text = { spacing = 0, prefix = '■' },
            signs = true,
            update_in_insert = false,
        },
        lsp_inlay_hints = {
            enable = true,
            only_current_line = true,
            only_current_line_autocmd = "CursorHold",
            show_variable_name = false,
        },
        lsp_gopls = {
            settings ={
                gopls = {
                    diagnosticsTrigger = nil,
                    vulncheck = nil,

                },
            },
        },
    })
  end,
  event = {"CmdlineEnter"},
  ft = {"go", 'gomod'},
  build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
}
