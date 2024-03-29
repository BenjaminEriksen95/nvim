require("evilgoldfish.remap")
require("evilgoldfish.set")
require("evilgoldfish.lazy_init")

local my_group = vim.api.nvim_create_augroup("evilgoldfish", {})


local yank_group = vim.api.nvim_create_augroup('HighlightYank', {})

vim.api.nvim_create_autocmd({ 'TextYankPost' }, {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

-- Remove end of line whitespace
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    group = my_group,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})
vim.api.nvim_create_autocmd('LspAttach', {
    group = my_group,
    callback = function(e)
        local buffer = e.buf
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end,
            { buffer = buffer, desc = "[G]o to [D]efinition" })
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, { buffer = buffer, desc = "Show hover information" })
        vim.keymap.set("n", "<leader>ws", function() vim.lsp.buf.workspace_symbol() end,
            { buffer = buffer, desc = "[W]orkspace [S]ymbols" })
        vim.keymap.set("n", "<leader>fd", function() vim.diagnostic.open_float() end,
            { buffer = buffer, desc = "[F]loat [D]iagnostics" })
        vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end,
            { buffer = buffer, silent = true, noremap = true, desc = "[C]ode [A]ctions" })
        vim.keymap.set("n", "<leader>rr", function() vim.lsp.buf.references() end,
            { buffer = buffer, desc = "[R]efe[r]ences" })
        vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end,
            { buffer = buffer, desc = "[R]e[n]ame symbol" })
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end,
            { buffer = buffer, desc = "Signature [H]elp" })
        vim.keymap.set("n", "<leader>d", function() vim.diagnostic.goto_next() end,
            { buffer = buffer, desc = "Next [D]iagnostic" })
        vim.keymap.set("n", "<leader>D", function() vim.diagnostic.goto_prev() end,
            { buffer = buffer, desc = "Previous [D]iagnostic" })
        vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Diagnostic [Q]uickfix list' })
    end
})

-- Move
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
