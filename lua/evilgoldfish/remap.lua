vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = 'Explorer'})

-- Move selected lines up or down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = 'Move marking Down'})
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = 'Move marking Up'})

-- Down and up with centering
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = 'Move [D]own with centering'})
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = 'Move [D]own with centering'})
vim.keymap.set("n", "n", "nzzzv", { desc = 'Overwrite [N]ext to center around item'})
vim.keymap.set("n", "N", "Nzzzv", { desc = 'Overwrite reverse [N]ext to center around item'})


vim.keymap.set("x", "<leader>p", [["_dP]], { desc = '[Paste] without yank'})

vim.keymap.set({"n", "v"}, "<leader>y", [["+y]], { desc = '[Y]ank selection OS'})
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = '[Y]ank line OS'})

vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = '[F]ormat'})

-- Helpers for Danish keyboard
vim.keymap.set({"n","v","o"}, "ø", "$", {desc = 'End of Line'})
vim.keymap.set({"n","v","o"}, "æ", "_", {desc = 'Start of Line(non-blank)'})

