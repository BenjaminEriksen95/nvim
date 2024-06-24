return {
    'wfxr/minimap.vim',

    config = function ()
        vim.keymap.set("n", "<leader>mm", vim.cmd.MinimapToggle, { desc = 'Toggle [m]ini[m]ap'})


    end
}
