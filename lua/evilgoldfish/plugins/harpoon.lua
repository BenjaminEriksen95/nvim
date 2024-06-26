return {
    "theprimeagen/harpoon",

    config = function()
        require("harpoon").setup({})


    local mark = require("harpoon.mark")
    local ui = require("harpoon.ui")

    vim.keymap.set("n", "<leader>a", mark.add_file, { desc = 'Add to Harpoon'})
    vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu, { desc = "Harpoon Menu"})

    vim.keymap.set("n", "<C-s>", function() ui.nav_file(1) end, { desc = 'Harpoon goto 1'})
    vim.keymap.set("n", "<C-d>", function() ui.nav_file(2) end, { desc = 'Harpoon goto 2'})
    vim.keymap.set("n", "<C-f>", function() ui.nav_file(3) end, { desc = 'Harpoon goto 3'})
    vim.keymap.set("n", "<C-g>", function() ui.nav_file(4) end, { desc = 'Harpoon goto 4'})

    end

}

