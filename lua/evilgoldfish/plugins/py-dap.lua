return {
    'mfussenegger/nvim-dap-python',
    ft = 'python',
    dependencies = {
    'mfussenegger/nvim-dap',
    'rcarriga/nvim-dap-ui'
    },
    config = function ()
        local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
        local dap_py = require('dap-python')
        dap_py.setup(path)

        vim.keymap.set("n", '<leader>dc', vim.cmd.DapContinue)

        vim.keymap.set("n", '<leader>bb', vim.cmd.DapToggleBreakpoint)
        vim.keymap.set("n", '<leader>bc', "<cmd>lua require'dap'.clear_breakpoints()<cr>")
        vim.keymap.set("n", '<leader>tc', function()
            if vim.bo.filetype == 'python' then
                dap_py.test_class();
            end
        end, { desc = "[T]est [C]lass Debug"})
        vim.keymap.set("n", '<leader>tm', function()
            if vim.bo.filetype == 'python' then
                dap_py.test_method();
            end
        end, { desc = "[T]est [M]ethod Debug"})
    end
}

