local api = vim.api

local config = {
    show_details = true,

    keymaps = {
        close_explorer = '<Esc>',
        toggle_details = 't'
    }
}

local explorer_state = {
    window = nil,
    file_buffer = nil,
    files = {},
    directory = nil,
    -- Add other state variables as needed
}

local explorer_actions = {

    close_explorer = function()
        if explorer_state.window then
            api.nvim_win_close(explorer_state.window, true)
        end
    end,


}

local function apply_keymaps(buffer)

    vim.api.nvim_buf_set_keymap(buffer, 'n', config.keymaps.close_explorer, '', {
        noremap = true,
        silent = true,
        callback = explorer_actions.close_explorer
    })

end

local function setup(user_config)
    -- Merge with user_config overriding defaults
    config = vim.tbl_deep_extend('force', config, user_config or {})

end

local function list_files(directory)
    -- Make sure to escape the directory path to handle spaces correctly
    local command = 'ls -a "' .. directory .. '"'
    local handle = io.popen(command)
    if not handle then
        print("Error: Unable to list files.")
        return {}
    end

    local files = {}
    for line in handle:lines() do
        table.insert(files, line)
    end
    handle:close()

    return files
end

local function set_breadcrumb(buffer, breadcrumb)
    api.nvim_buf_clear_namespace(buffer, -1, 0, -1)
    api.nvim_buf_set_virtual_text(buffer, -1, 0, {{breadcrumb, 'Comment'}}, {})
end

local function open_directory(directory)
    -- Read folders and files
    directory = directory or vim.fn.getcwd()
    local files = list_files(directory)
    -- Create a new buffer, false for not listed, true for scratch buffer
    local file_buffer = api.nvim_create_buf(false, true)

    -- Inject files into buffer
    api.nvim_buf_set_lines(file_buffer, 0, -1, false, files)
    set_breadcrumb(file_buffer, directory)

     explorer_state.window = api.nvim_open_win(file_buffer, true, {

        relative = 'editor',
        width = math.floor(vim.o.columns * 0.7),
        height = math.floor(vim.o.lines * 0.7),
        col = math.floor(vim.o.columns * 0.15),
        row = math.floor(vim.o.lines * 0.15),
        border = 'single'
    })

    vim.api.nvim_buf_set_keymap(file_buffer, 'n', '<CR>', '', {
        noremap = true,
        silent = true,
        callback = function()
            local cursor_pos = vim.api.nvim_win_get_cursor(0)
            local row = cursor_pos[1]
            local selected = files[row]  -- Assuming the first line is at index 1

            if selected then
                vim.api.nvim_win_close(explorer_state.window, true)  -- Close the explorer window
                local new_path = vim.fn.fnamemodify(directory .. '/' .. selected, ':p')                if vim.fn.isdirectory(new_path) == 1 then
                    open_directory(new_path)  -- Open selected directory
                else
                    -- Open the selected file
                    vim.cmd('edit ' .. vim.fn.fnameescape(new_path))
                end
            end
        end
    })

    apply_keymaps(file_buffer)
end





open_directory()
