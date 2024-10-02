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

        vim.keymap.set("n", '<leader>dc', vim.cmd.DapContinue, {desc="[d]ebugger [c]ontinue"})
        vim.keymap.set("n", '<leader>db', vim.cmd.DapToggleBreakpoint, {desc="[d]ebugger [b]reakpoint"})
        vim.keymap.set("n", '<leader>dC', "<cmd>lua require'dap'.clear_breakpoints()<cr>", {desc="[d]ebugger [C]lear"})
        vim.keymap.set("n", '<leader>dtc', function()
            if vim.bo.filetype == 'python' then
                dap_py.test_class();
            end
        end, { desc = "[d]ebug [t]est [c]lass"})
        vim.keymap.set("n", '<leader>dtm', function()
            if vim.bo.filetype == 'python' then
                dap_py.test_method();
            end
        end, { desc = "[d]ebug [t]est [m]ethod"})
    end
}

