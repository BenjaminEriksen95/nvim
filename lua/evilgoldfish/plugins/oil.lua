return {
    "stevearc/oil.nvim",
    config = function ()
        require("oil").setup()

        vim.keymap.set("n", "<leader>pv", "<CMD>Oil<CR>", { desc = "Filedir"} )
    end
}

