return {
    "neovim/nvim-lspconfig",

    dependencies = {

        -- Mason
        "williamboman/mason.nvim",
        "williamboman/mason.lspconfig.nvim",

        -- LSP Support
        "neovim/nvim-lspconfig",

        -- Autocompletion
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/nvim-cmp",

        -- Snippets
        "L3MON4D3/LuaSnip",
        -- Utils
        "j-hui/fidget.nvim",

        -- Mason Tool Installer
        "WhoIsSethDaniel/mason-tool-installer.nvim"
    },

    config = function()
        local cmp = require("cmp")
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())

        require("fidget").setup({})
        require("mason").setup({})
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                -- Python
                "pyright",

            },
            handlers = {
                function(server_name)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,

                -- Specific configuration for Lua
                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "vim", "it", "describe", "before_each", "after_each" },
                                }
                            }
                        }
                    }
                end,

                -- Add specific configurations for Pyright if needed
                ["pyright"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.pyright.setup {
                        capabilities = capabilities,
                        -- Add any Pyright-specific settings here
                    }
                end,
            }
        })

        -- Automatic install of tools
        require("mason-tool-installer").setup({
           ensure_installed = {
            'black',
            'pylint',
            'debugpy',
            'flake8',
            'mypy'
            }
        })

        vim.api.nvim_command('MasonToolsInstall')

        local cmp_select = { behavior = cmp.SelectBehavior.Select }


        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<Tab>'] = cmp.mapping.select_next_item(cmp_select),
                ['<CR>'] = cmp.mapping.confirm({ select = false }),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' }, -- For luasnip users.
            }, {
                    { name = 'buffer' },
                })
        })

        vim.diagnostic.config({
            -- update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })

    end
}

