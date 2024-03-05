local pickers = require 'telescope.pickers'
local finders = require 'telescope.finders'
local config = require 'telescope.config'.values
local action_state = require 'telescope.actions.state'
local actions = require 'telescope.actions'



local function list_files(directory)
    directory = directory or "."
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

local file_explorer = function ()
    pickers.new({}, {
        promt_title = "File Explorer",
        finder = finders.new_table({
            --entries = list_files(),
            results = list_files()
        }),
        sorter = config.file_sorter({}),
        attach_mappings = function(prompt_buffer, map)
            actions.select_default:replace(function ()
                actions.close(prompt_buffer)
                local selection = action_state.get_selected_entry()
                if selection then
                    vim.cmd('edit ' .. selection[1])
                end
            end)
            return true
        end,
    }):find()

end

file_explorer()
