local wezterm = require("wezterm")
local config = wezterm.config_builder()

local is_windows = wezterm.target_triple:find("windows") ~= nil

-- Ported from kitty/gruvbox-dark.conf
config.colors = {
  foreground = "#ebdbb2",
  background = "#272727",
  cursor_bg = "#ebdbb2",
  cursor_fg = "#272727",
  cursor_border = "#ebdbb2",
  selection_fg = "#655b53",
  selection_bg = "#ebdbb2",
  ansi = { "#272727", "#cc231c", "#989719", "#d79920", "#448488", "#b16185", "#689d69", "#a89983" },
  brights = { "#928373", "#fb4833", "#b8ba25", "#fabc2e", "#83a597", "#d3859a", "#8ec07b", "#ebdbb2" },
}

config.font = wezterm.font("GeistMono Nerd Font")
config.font_size = is_windows and 12.0 or 16.0
config.harfbuzz_features = { "calt=1", "liga=1" }

if is_windows then
  config.default_prog = { "C:/Program Files/Git/bin/bash.exe", "-i", "-l" }
end

return config
