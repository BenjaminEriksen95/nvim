return {
    "elentok/format-on-save.nvim",

    config = function ()
        require("format-on-save").setup({
            formatter_by_ft = {
                python = require("format-on-save.formatters").black
        }

        })
    end
}
