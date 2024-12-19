return {
    "mfussenegger/nvim-lint",

    config = function ()
        -- Set linters
        require('lint').linters_by_ft = {
            python = {'pylint'}
        }
        vim.api.nvim_create_autocmd({"BufWritePost"}, {
            callback = function()
                require("lint").try_lint()
                vim.notify("Linting", "debug", {timeout = 100} )
            end,
        })
        require('lint').linters.pylint.cmd = 'python'
        require("lint").linters.pylint.args = { "-m", "pylint", "-f", "json", "--from-stdin", function() return vim.api.nvim_buf_get_name(0) end, }
    end
}
