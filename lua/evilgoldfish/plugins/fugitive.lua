return {
    "tpope/vim-fugitive",

    config = function()
        vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
        vim.keymap.set("n", "<leader>gA", vim.cmd.Git)
        -- TODO 
        
        vim.keymap.set("n", "<leader>gc", function() 
            local msg = vim.fn.input("Commit message: ")
            if msg ~= "" then
                vim.cmd('Git commit -m '..vim.fn.shellescape(message))
            else
                print("Commit aborted: No commit message provided")
            end
        end, {noremap = true, silent = true})

  



        vim.keymap.set("n", "<leader>gA", function() 
            
            vim.cmd('Git add -A')
            print("Git add -A")
            end, { noremap = true, silent = true })
    end

}

