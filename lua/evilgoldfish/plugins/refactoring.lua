return {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter"
    },
    config = function()
        require("refactoring").setup()

        -- Extract the selected text into a new function
        vim.keymap.set("x", "<leader>Re", ":Refactor extract ", { desc = '[R]efactor [e]xtract' })

        -- Extract the selected text into a new file
        vim.keymap.set("x", "<leader>Rf", ":Refactor extract_to_file ", { desc = '[R]efactor extract to [f]ile' })

        -- Extract the selected text into a new variable
        vim.keymap.set("x", "<leader>Rv", ":Refactor extract_var ", { desc = '[R]efactor extract [v]ar' })

        -- Inline the variable under the cursor or selected text
        vim.keymap.set({ "n", "x" }, "<leader>Ri", ":Refactor inline_var", { desc = '[R]efactor [i]nline variable' })

        -- Inline the function under the cursor
        vim.keymap.set("n", "<leader>RI", ":Refactor inline_func", { desc = '[R]efactor inline [I]nline function' })

        -- Extract the block of code under the cursor into a new function
        vim.keymap.set("n", "<leader>Rb", ":Refactor extract_block", { desc = '[R]efactor extract [b]lock' })

        -- Extract the block of code under the cursor into a new file
        vim.keymap.set("n", "<leader>Rbf", ":Refactor extract_block_to_file", { desc = '[R]efactor extract block to [f]ile' })

        -- Open a menu to select a refactoring operation
        vim.keymap.set({"n", "x"}, "<leader>Rr", function() require('refactoring').select_refactor() end, { desc = '[R]efactor select' })
    end
}
