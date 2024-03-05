-- takeout.nvim.lua

local M = {}

-- Default options
local opts = {
    repeat_key = ',', -- Default repeat key
}

-- Function to store the last command
local last_command = nil

-- Enhanced 'bag' function to replace 'vim.keymap.set'
-- It sets the keymap and makes the command repeatable
function M.bag(mode, lhs, rhs, keymap_opts)
    keymap_opts = keymap_opts or {}
    local callback

    if type(rhs) == 'function' then
        callback = rhs
    else
        callback = function()
            vim.api.nvim_exec(rhs, false)
        end
    end

    -- Store the command for repeat
    local wrapped_callback = function()
        last_command = callback
        callback()
    end

    -- Set the key mapping
    vim.keymap.set(mode, lhs, wrapped_callback, keymap_opts)
end

-- Function to repeat the last command
function M.repeat_last_command()
    if last_command then
        last_command()
    end
end

-- Setup function to configure the plugin and set the repeat key
function M.setup(user_opts)
    user_opts = user_opts or {}
    for k, v in pairs(user_opts) do
        if opts[k] ~= nil then
            opts[k] = v
        end
    end
    -- Apply the repeat key configuration
    M.set_repeat_key()
end

-- Function to set or update the repeat key mapping
function M.set_repeat_key()
    -- Set the new key mapping for repeating the last command
    vim.keymap.set('n', opts.repeat_key, M.repeat_last_command, { noremap = true, silent = true })
end

return M
