return {
    "smoka7/hop.nvim",
    version = "*",
    config = function()
        require'hop'.setup {}
        -- Define a keybinding for starting a two-character search
        local hop = require('hop')
        local directions = require('hop.hint').HintDirection
        vim.keymap.set('', 'f', function()
            hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
        end, {remap=true})
        vim.keymap.set('', 'F', function()
            hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
        end, {remap=true})
        vim.keymap.set('', 't', function()
            hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
        end, {remap=true})
        vim.keymap.set('', 'T', function()
            hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
        end, {remap=true})
        vim.keymap.set({'n', 'v'}, 's', "<cmd>HopChar1<CR>", { silent = true, noremap = true })
        vim.keymap.set({'n', 'v'}, 'S', "<cmd>HopChar2<CR>", { silent = true, noremap = true })
    end
}

