-- takeout

local M = {}

-- Default options
local opts = {
    repeat_key = ',', -- Default repeat key
}

-- Function to store the last command
local last_command = nil

-- Store the command for repeat
M.wrapped_callback = function(callback)
    callback()
    last_command = callback
end

-- Enhanced 'bag' function to replace 'vim.keymap.set'
-- It sets the keymap and makes the command repeatable
M.bag = function(mode, lhs, rhs, keymap_opts)
    keymap_opts = keymap_opts or {}
    local callback

    if type(rhs) == 'function' then
        callback = rhs
    else
        callback = function()
            vim.api.nvim_exec(rhs, false)
        end
    end

    -- Set the key mapping
    vim.keymap.set(mode, lhs, function()
        M.wrapped_callback(callback)
    end, keymap_opts)
end

-- Function to repeat the last command
M.repeat_last_command = function()
    if last_command then
        last_command()
    end
end

-- Setup function to configure the plugin and set the repeat key
M.setup = function(user_opts)
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
M.set_repeat_key = function()
    -- Set the new key mapping for repeating the last command
    vim.keymap.set('n', opts.repeat_key, M.repeat_last_command, { noremap = true, silent = true })
end

return M
