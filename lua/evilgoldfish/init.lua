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
        vim.keymap.set("n", "<leader>gd", function() vim.lsp.buf.definition() end,
            { buffer = buffer, desc = "[g]o to [d]efinition" })
        vim.keymap.set("n", "<leader>gD", function()
            vim.cmd("belowright split")
            vim.lsp.buf.definition()
        end, { buffer = buffer, desc = "[g]o to [D]efinition in new split" })
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover()  end,
            { buffer = buffer, desc = "Show hover information" })
        vim.keymap.set("n", "<leader>ws", function() vim.lsp.buf.workspace_symbol() end,
            { buffer = buffer, desc = "[w]orkspace [s]ymbols" })
        vim.keymap.set("n", "<leader>df", function() vim.diagnostic.open_float() end,
            { buffer = buffer, desc = "[d]iagnostics [f]loat" })
        vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end,
            { buffer = buffer, silent = true, noremap = true, desc = "[c]ode [a]ctions" })
        --vim.keymap.set("n", "<leader>rr", function() vim.lsp.buf.references() end,
        --    { buffer = buffer, desc = "[R]efe[r]ences" })
        vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end,
            { buffer = buffer, desc = "Re[n]ame symbol" })
        vim.keymap.set("i", "<C-x>", function() vim.lsp.buf.signature_help() end,
            { buffer = buffer, desc = "Signature expand" })
        vim.keymap.set("n", "<leader>ø", function() vim.diagnostic.goto_next() end,
            { buffer = buffer, desc = "Next diagnostic" })
        vim.keymap.set("n", "<leader>æ", function() vim.diagnostic.goto_prev() end,
            { buffer = buffer, desc = "Previous diagnostic" })
        vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Diagnostic [q]uickfix list' })
    end
})

-- Move
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
