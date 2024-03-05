# takeout.nvim

A simple implementation of "Dot-Repeat" for any keymap.

# Usage

```lua
local takeout = require('takeout.nvim')

-- Use 'bag' to set a repeatable keymap, instead of vim.keymap.set()
takeout.bag('n', '<leader>e', function() print("Example command") end, {noremap = true, silent = true})
```

Now do '<leader>e' to __bag__ your __takeout__. Access bag with the repeat command ','
