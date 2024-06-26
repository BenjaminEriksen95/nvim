return {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end,
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
    },
    config = function()
        require("which-key").setup()
        require('which-key').register {
            ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
            ['<leader>G'] = { name = '[G]it', _ = 'which_key_ignore' },
            --['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
            ['<leader>d'] = { name = '[D]ebug', _ = 'which_key_ignore' },
            ['<leader>R'] = { name = '[R]efactor', _ = 'which_key_ignore' },
            ['<leader>h'] = { name = '[H]elp', _ = 'which_key_ignore' },
            --['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
            ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
            ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
        }
    end,

}
