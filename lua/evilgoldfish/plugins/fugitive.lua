return {
    'tpope/vim-fugitive',

    config = function()
        vim.keymap.set('n', '<leader>gs', vim.cmd.Git, { desc = '[G]it [S]tatus'})
        -- TODO
        -- Autogroup commands

        local custom_fugitive = vim.api.nvim_create_augroup('custom_fugitive', {})

        -- Commands for the :G buffer
        vim.api.nvim_create_autocmd('BufWinEnter', {
            group = custom_fugitive,
            pattern = '*',
            callback = function()
                if vim.bo.filetype ~= 'fugitive' then
                    return
                end

                local current_buffer = vim.api.nvim_get_current_buf()
                vim.keymap.set('n', '<leader>P', function()
                    vim.cmd('Git push')
                end, { buffer = current_buffer, remap = false, desc = 'git push' }
                )

                vim.keymap.set('n', '<leader>p', function()
                    vim.cmd('Git pull --rebase')
                end, { buffer = current_buffer, remap = false, desc = 'git pull -rebase'}
                )

                vim.keymap.set('n', '<leader>c', function()
                    vim.cmd('Gllog')
                end, { buffer = current_buffer, remap = false, desc = 'git commit log'})


            end
        })

        vim.keymap.set('n', '<leader>gc', function()
            local msg = vim.fn.input('Commit message: ')
            if msg ~= '' then
                vim.cmd.Git('commit -m ' .. vim.fn.shellescape(msg))
            else
                print('Commit aborted: No commit message provided')
            end
        end, { noremap = true, silent = true, desc = 'git commit -m' })

        vim.keymap.set('n', '<leader>gA', function()
            vim.cmd('Git add -A')

            vim.notify("add -A", "info", { timeout = 1000, title = 'Git' })
        end, { noremap = true, silent = false, desc = 'git add -A' })
    end

}
