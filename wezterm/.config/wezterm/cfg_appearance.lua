local wezterm = require "wezterm"
local colors = require "cfg_colors"

local cfg = {}

-- Formatting of the tab title
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local edge_background = colors.tab_background_edge
  local background = colors.tab_background
  local foreground = colors.tab_foreground

  if tab.is_active then
    background = colors.tab_background_active
    foreground = colors.tab_foreground_active
  elseif hover then
    background = colors.tab_background_hover
    foreground = colors.tab_foreground_hover
  end

  -- Ensure that the titles fit in the available space,
  -- and that we have room for the edges.
  local title = wezterm.truncate_left(tab.active_pane.title, max_width-2)

  -- Set tab with unseen output as another color
  local has_unseen_output = false
  for _, pane in ipairs(tab.panes) do
    if pane.has_unseen_output then
      has_unseen_output = true
      break;
    end
  end
  if has_unseen_output then
      background = colors.tab_background_unseen
  end

  local edge_foreground = background

  return {
    {Background={Color=edge_background}},
    {Foreground={Color=edge_foreground}},
    {Text=colors.solid_left_arrow},
    {Background={Color=background}},
    {Foreground={Color=foreground}},
    {Text=title},
    {Background={Color=edge_background}},
    {Foreground={Color=edge_foreground}},
    {Text=colors.solid_right_arrow},
  }
end)

cfg.hide_tab_bar_if_only_one_tab = true
cfg.use_fancy_tab_bar = false
cfg.tab_bar_at_bottom = true

-- Pad window to avoid the content to be too close to the border,
-- so it's easier to see and select.
cfg.window_padding = {
  left = 4, right = 3,
  top = 4, bottom = 3,
}

cfg.window_background_opacity = 1.0
cfg.window_decorations = "RESIZE"

cfg.color_scheme = 'Dracula'

return cfg
