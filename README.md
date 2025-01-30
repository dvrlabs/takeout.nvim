# takeout.nvim

"Dot-Repeat" for any keymap, key-chord.

Store a keymap as the last command.
Hitting the repeat key will do the command again.

# Installation
## Lazy.nvim

```lua
{ 'dvrlabs/takeout.nvim', opts = {}}
```

# Setup

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


# Usage and options

```lua
{ 
    'dvrlabs/takeout.nvim', 
    opts = {
        -- The key to overwrite to rerun the command.
        -- '.', also used to repeat edits in VIM, is default.
        repeat_key = '.',

        -- When the "bag" is empty, the repeat_key has normal functionality.
        -- For '.' in normal mode that means repeating edits.
        -- Emptying the bag is one way to manage a return to normal '.' vim functionality.
        -- This variable specifies the keymap to empty the bag.
        empty_bag = '<leader>.',

        -- A bool to configure whether or not to use a time limit.
        -- If a time limit is enabled, the bag is emptied after that limit
        -- When the bag is empty, the repeat key has normal functionality.
        use_time_limit = true,

        -- The time_limit, in seconds if user_time_limit, after which to empty the bag.
        time_limit_seconds = 15,
    }
}
```

# Design Goals

Originally, I mapped `,` to repeat. This overwrote Vim's default behavior of seeking backward with F.

I want to enhance Vim’s repeat functionality without disrupting its default behavior. Specifically, I want `.` to repeat only a few selected key mappings or key-chords to save keystrokes, while keeping everything else unchanged.

This plugin provides two options:

1. Contextual Override: `.` temporarily overrides its default behavior after using a specific key mapping. Default behavior is restored by emptying the bag with `<leader>.`.

1. Time-Limited Repeat: `.` repeats the bagged key mapping only within a set time limit. After the limit expires, `.` returns to its default behavior, requiring the full key-chord to be executed again before repeating for another time_limit_seconds.

# Other Features

- Accepts a count. Do '5.' to repeat 5 times.


