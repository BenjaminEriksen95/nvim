return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
    },

    config = function ()
        require("trouble").setup()
        vim.keymap.set("n", "<leader>ct", function() require("trouble").toggle() end, { desc = "Trouble"})
        vim.keymap.set("n", "<leader>cw", function() require("trouble").toggle("workspace_diagnostics") end, {desc = "Trouble workspace_diagnostics"})
        vim.keymap.set("n", "<leader>cd", function() require("trouble").toggle("document_diagnostics") end, {desc = "Trouble document_diagnostics"})
        vim.keymap.set("n", "<leader>cq", function() require("trouble").toggle("quickfix") end, {desc = "Trouble quickfix"})
        vim.keymap.set("n", "<leader>cl", function() require("trouble").toggle("loclist") end, {desc = "Trouble loclist?"})

--        vim.keymap.set("n", "<leader>æ", function () require("trouble").prev({skip_groups = true, jump = true}) end, {desc = ""})
--        vim.keymap.set("n", "<leader>ø", function () require("trouble").next({skip_groups = true, jump = true}) end, {desc = ""})
--        vim.keymap.set("n", "<leader>Æ", function () require("trouble").first({skip_groups = true, jump = true}) end, {desc = ""})
--        vim.keymap.set("n", "<leader>Ø", function () require("trouble").last({skip_groups = true, jump = true}) end, {desc = ""})

        vim.keymap.set("n", "<leader>xr", function() require("trouble").toggle("lsp_references") end, {desc = "Trouble lsp_references"})
    end

}
