
local col = {}

-- The filled in variant of the < symbol
col.solid_left_arrow = utf8.char(0xe0b2)

-- The filled in variant of the > symbol
col.solid_right_arrow = utf8.char(0xe0b0)

-- Tab default
col.tab_background = "#1b1032"
col.tab_background_edge = "#0b0022"
col.tab_foreground = "#808080"

-- Tab active
col.tab_background_active = "#2b2042"
col.tab_foreground_active = "#c0c0c0"
-- Tab hover
col.tab_background_hover = "#3b3052"
col.tab_foreground_hover = "#909090"
-- Tab unseed
col.tab_background_unseen = "#feeac8"

return col
