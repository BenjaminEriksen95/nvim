return {
    "nvim-telescope/telescope.nvim",

    tag = "0.1.5",

    dependencies = {
        "nvim-lua/plenary.nvim"
    },

    config = function()
        require('telescope').setup({})

        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp'})

        vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles'})

        vim.keymap.set('n', '<leader>sF', builtin.find_files, { desc = '[S]earch All [F]iles'})

        vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope ?'})

        vim.keymap.set('n', '<leader>sg', builtin.git_files, { desc = '[S]earch [G]it'})

        vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume'})

        vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics'})

        vim.keymap.set('n', '<leader>sw', function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word }) end, { desc = '[S]earch [W]ord'})

        vim.keymap.set('n', '<leader>sW', function()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word }) end, { desc = '[S]earch [W]ORD'})

        vim.keymap.set('n', '<leader>sg', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") }) end, { desc = '[S]earch [G]rep'}) -- Requires ribgrep

        vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = ' [ ] Seach buffers'})

        vim.keymap.set('n', '<leader>hk', builtin.keymaps, { desc = '[H]elp [K]eymaps'})

        vim.keymap.set('n', '<leader>/', function()
            builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
            winblend = 15,
            previewer = false})
        end, { desc = '[/] Fuzzy seach current buffer'})
        -- For consideration:
        -- oldfiles,
    end
}


