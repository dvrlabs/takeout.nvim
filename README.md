# takeout.nvim

A simple implementation of "Dot-Repeat" for any keymap.

Store any selected keymaps as the last command.
Hitting the repeat key will do the command again.

# Installation
## Lazy.nvim

```lua
{ 'dvrlabs/takeout.nvim', opts = {}}
```

# Usage

Instead of using vim.keymap.set(), use takeout.

This is how I use it in my nvim-lspconfig:

```lua
local takeout = require('takeout')
takeout.bag('n', '<leader>lp', vim.diagnostic.goto_prev, { desc = 'Go to [P]revious diagnostic message' })
takeout.bag('n', '<leader>ln', vim.diagnostic.goto_next, { desc = 'Go to [N]ext diagnostic message' })
```
Can also be used like this:

```lua
local takeout = require('takeout')
takeout.bag('n', '<leader>p', ':Lazy<CR>', { desc = '[P]ackage Manager' })
```

> [!IMPORTANT]
> The below keymap won't work. Just use the ':' syntax and pass in silent = true option
>
> ```lua
> local takeout = require('takeout')
> takeout.bag('n', '<leader>p', '<Cmd>Lazy<CR>', { desc = '[P]ackage Manager' })
> ```

For all keymaps created with bag(), using the keymap once changes the last stored keymap in the bag.


# repeat_key and default key

You should be able to remap the repeat key from ',' by using repeat_key in the opts table. 

```lua
{ 
    'dvrlabs/takeout.nvim', 
    opts = {
        -- If you wanted F5 to repeat, as an example
        repeat_key = '<F5>',
        -- If there is no bagged command, will run function assigned to default_none_bagged.
        default_none_bagged = function()
            vim.api.nvim_command 'normal! @@'
        end,
    }
}
```

# Other Features

- Accepts a count. Do '5,' to repeat 5 times.


