return {
    "neovim/nvim-lspconfig",

    dependencies = {
        -- Mason
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",

        -- Autocompletion
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/nvim-cmp",

        -- Snippets
        "L3MON4D3/LuaSnip",

        -- Utils
        "j-hui/fidget.nvim",

        -- Mason Tool Installer
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },

    config = function()
        -- Setup capabilities for LSP and autocompletion
        local cmp = require("cmp")
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

        -- Setup Fidget for LSP progress notifications
        require("fidget").setup({})

        -- Mason setup
        require("mason").setup({})
        require("mason-lspconfig").setup({
            ensure_installed = {
                -- LSP servers to be installed
                "lua_ls",
                "pyright",
                "gopls",
            },
            handlers = {
                -- Default handler for all servers
                function(server_name)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities,
                    }
                end,

                -- Lua-specific configuration
                ["lua_ls"] = function()
                    require("lspconfig").lua_ls.setup {
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

                -- Pyright-specific configuration
                ["pyright"] = function()
                    require("lspconfig").pyright.setup {
                        capabilities = capabilities,
                    }
                end,

                -- -- gopls-specific configuration
                -- ["gopls"] = function()
                --     require("lspconfig").gopls.setup {
                --         capabilities = capabilities,
                --         settings = {
                --             gopls = {
                --                 analyses = {
                --                     unusedparams = true,
                --                 },
                --                 staticcheck = true,
                --             }
                --         }
                --     }
                -- end,
            }
        })

        -- Mason Tool Installer setup
        require("mason-tool-installer").setup({
            ensure_installed = {
                -- Tools to be automatically installed (formatters, linters, debuggers, etc.)
                "black",      -- Python formatter
                "pylint",     -- Python linter
                "flake8",     -- Python linter
                "debugpy",    -- Python debugger
                "mypy",       -- Python type checker
                "gofumpt",    -- Go formatter
            },
        })


        -- Use deprecated unpack for old versions if new isn't available.
        local unpack = table.unpack or unpack
        -- Helper function to check if there are words before cursor
        local has_words_before = function()
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end
        -- Autocompletion setup
        cmp.setup({
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<CR>'] = cmp.mapping.confirm({ select = false }),
                ['<C-Space>'] = cmp.mapping.complete(),
                -- ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                -- ['<C-f>'] = cmp.mapping.scroll_docs(4),
                -- Inserted Tab and Shift-Tab behavior for navigating suggestions
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
                ['<S-Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
            }, {
                { name = 'buffer' },
            })
        })



        -- Configure diagnostic display
        vim.diagnostic.config({
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

