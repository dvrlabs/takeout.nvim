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

```lua
local takeout = require('takeout')
takeout.bag('n', '<leader>e', function() print("Example command") end, {noremap = true, silent = true})
```

Now do LEADER + E to __bag__ your __takeout__. Access bag with the repeat command ','

# repeat_key

You should be able to remap the repeat key from ',' by using repeat_key in the opts table. 



