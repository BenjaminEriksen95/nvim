return {
    "tpope/vim-fugitive",

    config = function()
        vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
        -- TODO
        -- Autogroup commands 

        local custom_fugitive = vim.api.nvim_create_augroup("custom_fugitive", {})
        
        vim.api.nvim_create_autocmd("BufWinEnter", {
            group = custom_fugitive,
            pattern = "*",
            callback = function() 
                if vim.bo.filetype ~= "fugitive" then
                    return
                end

                local current_buffer = vim.api.nvim_get_current_buf()
                local opts = { buffer = current_buffer, remap = false }

                vim.keymap.set("n", "<leader>P", function() 
                    vim.cmd('Git push')
                end, opts)

                vim.keymap.set("n", "<leader>p", function()
                    vim.cmd('Git pull --rebase')
                end, opts)
            end
        })

        vim.keymap.set("n", "<leader>gc", function() 
            local msg = vim.fn.input("Commit message: ")
            if msg ~= "" then
                vim.cmd.Git('commit -m '..vim.fn.shellescape(msg))
            else
                print("Commit aborted: No commit message provided")
            end
        end, {noremap = true, silent = true})
  
        vim.keymap.set("n", "<leader>gA", function() 
            vim.cmd('Git add -A')
            print("Git add -A")
            end, { noremap = true, silent = false })



    end

}

