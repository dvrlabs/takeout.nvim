-- takeout

local M = {}

-- Default options
local opts = {
    -- Default repeat key
    repeat_key = ',',
    default_none_bagged = function()
        local last_macro = vim.fn.getreg '@'
        if last_macro and last_macro ~= '' then
            vim.api.nvim_command 'normal! @@'
        end
    end,
}

-- Function to store the last command
local last_command = nil

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

    -- Correctly wrap the callback to ensure last_command is updated each time
    local function wrapped_callback()
        last_command = callback -- Update last_command each time this is invoked
        callback()
    end

    -- Set the key mapping to our wrapped callback
    vim.keymap.set(mode, lhs, wrapped_callback, keymap_opts)
end

-- Function to repeat the last command with support for counted repeats
M.repeat_last_command = function()
    if last_command then
        -- Get the count provided by the user or default to 1 if no count was provided
        local count = vim.v.count > 0 and vim.v.count or 1
        -- Execute the last_command 'count' times
        for _ = 1, count do
            last_command()
        end
    else
        -- Get the count provided by the user or default to 1 if no count was provided
        local count = vim.v.count > 0 and vim.v.count or 1
        -- Execute the default_none_bagged 'count' times
        for _ = 1, count do
            opts.default_none_bagged()
        end
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
