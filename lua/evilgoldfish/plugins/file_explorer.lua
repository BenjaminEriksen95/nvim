local api = vim.api

local function list_files(directory)
    local p = io.popen('ls -a "' .. directory .. '"')
    local filenames = {}
    if p then
        local output = p:read("*all")
        p:close()
        for filename in string.gmatch(output, '([^\n]+)') do
            table.insert(filenames, filename)
        end
    end
    return filenames
end



local function open_directory(directory)
    -- Read folders and files
    directory = directory or vim.fn.getcwd()
    local command = 'ls -a ' .. directory
    local handle = io.popen(command)
    if handle == nil then
        print("Handle is nil")
        return
    end
    local result = handle:read("a")
    handle:close()

    -- Load into files
    local files = {} -- use list files?
    for filename in string.gmatch(result, '([^\n\r]+)') do
        table.insert(files, filename)
    end

    -- Create a new buffer, false for not listed, true for scratch buffer
    local file_buffer = api.nvim_create_buf(false, true)
    -- Inject files into buffer
    api.nvim_buf_set_lines(file_buffer, 0, 1, false, files)


    local window = api.nvim_open_win(file_buffer, true, {
        relative = 'editor',
        width = math.floor(vim.o.columns * 0.7),
        height = math.floor(vim.o.lines * 0.7),
        col = math.floor(vim.o.columns * 0.15),
        row = math.floor(vim.o.lines * 0.15),
        border = 'single'
    })

    -- Enter goes to selected file
    api.nvim_buf_set_keymap(file_buffer, 'n', '<CR>', '',
        {
            noremap = true,
            silent = true,
            callback = function()
                local cursor_pos = api.nvim_win_get_cursor(window)
                local row = cursor_pos[1]
                local selected = files[row]
                api.nvim_win_close(window, true)
                local new_path = directory .. '/' .. selected
                if vim.fn.isdirectory(new_path) == 1 then -- Recursive call with new path
                    open_directory(new_path)
                else
                    vim.cmd('edit ' .. vim.fn.fnameescape(new_path))
                end
            end
        })

    api.nvim_buf_set_keymap(file_buffer, 'n', '<Esc>', '', {
        noremap = true,
        silent = true,
        callback = function()
            api.nvim_win_close(window, false)
        end
    })
end

open_directory()
