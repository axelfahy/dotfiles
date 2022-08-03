local wezterm = require "wezterm"
local act = wezterm.action

local cfg = {}

cfg.enable_csi_u_key_encoding = false

-- Move tab relative
cfg.keys = {
    { key = '{', mods = 'SHIFT|ALT', action = act.MoveTabRelative(-1) },
    { key = '}', mods = 'SHIFT|ALT', action = act.MoveTabRelative(1) },
}

return cfg
