-- .csv is set to use semicolon by default
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
    pattern = "*.csv",
    command = "set filetype=csv_semicolon",
})
