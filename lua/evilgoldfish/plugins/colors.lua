function ColorMyVim(color)
    color = color or "rose-pine"
    vim.cmd("colorscheme " .. color)

    vim.api.nvim_set_hl(0, "Normal", {bg = "none"})
    vim.api.nvim_set_hl(0, "NormalFloat", {bg = "none"})
end


return {
    {
    "folke/tokyonight.nvim",
    config = function()
        require("tokyonight").setup({
            style = "storm",
            transparent = true,
            terminal_colors = true,
            styles = {
                comments = { italic = false },
                keywords = { italic = false },

                sidebars = "dark",
                floats = "dark",
            },
        })
    end
    },

    {
        "AlexvZyl/nordic.nvim",
        name = "nordic",
        config = function ()
            require("nordic").setup({

            })
        end
    },

    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            require('rose-pine').setup({
                transparent = true,
            })

            ColorMyVim()
        end
    },
}
