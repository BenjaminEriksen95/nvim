return {
    "cameron-wags/rainbow_csv.nvim",
    config = function() 
        require("rainbow_csv").setup({})

        vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
            pattern = "*.csv",
            command = "set filetype=csv_semicolon",
        }) 

    end
}
