# KeyMapper.spoon

Easily create global and app-specific key binds.

## Install
```bash
mkdir -p ~/.hammerspoon/Spoons
git clone https://github.com/gnudad/KeyMapper.spoon.git ~/.hammerspoon/Spoons/KeyMapper.spoon
```

## Configure
Add to `~/.hammerspoon/init.lua`
```lua
-- [{ lhs_mods, lhs_key }] = { rhs_mods, rhs_key, repeat? <default: false> }

hs.loadSpoon("KeyMapper"):bindHotkeys({
  default = { -- Always enabled
    [{ "cmd", "h" }] = { "",    "left",  true },
    [{ "cmd", "j" }] = { "",    "down" , true },
    [{ "cmd", "k" }] = { "",    "up",    true },
    [{ "cmd", "l" }] = { "",    "right", true },
    [{ "alt", "h" }] = { "cmd", "left" },
    [{ "alt", "j" }] = { "cmd", "down" },
    [{ "alt", "k" }] = { "cmd", "up" },
    [{ "alt", "l" }] = { "cmd", "right" },
  },
  Finder = { -- Enabled only when Finder focused
    [{ "cmd", "h" }] = { "cmd", "up" },
    [{ "cmd", "l" }] = { "cmd", "down" },
  },
  Mail = { -- Enabled only when Mail.app focused
    [{ "alt", "j" }] = { "alt,cmd", "down" },
    [{ "alt", "k" }] = { "alt,cmd", "up" },
  },
}):start()
```
