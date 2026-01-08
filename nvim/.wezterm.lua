-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- For example, changing the color scheme:
config.color_scheme = "Batman"
-- config.color_scheme = "Gruvbox Dark (Gogh)"
-- config.color_scheme = "Gruvbox dark, hard (base16)"
-- config.color_scheme = "Belafonte Day"
-- config.color_scheme = "Belafonte Night"
-- config.color_scheme = "Bespin (base16)"

config.keys = {
	-- Activate Copy Mode and scroll to previous prompt with Ctrl + p
	-- {
	-- 	key = "p",
	-- 	mods = "CTRL",
	-- 	action = wezterm.action.Multiple({
	-- 		wezterm.action.ActivateCopyMode,
	-- 		wezterm.action.ScrollToPrompt(-1),
	-- 	}),
	-- },
	-- Split horizontally with Ctrl + shift + h
	{
		key = "h",
		mods = "CTRL|SHIFT",
		action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }),
	},
	-- Split vertically with Ctrl + shfit + v
	{
		key = "v",
		mods = "CTRL|SHIFT",
		action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }),
	},
	-- Pane navigation (Vim-style using CMD/Meta)
	{ key = "h", mods = "CMD", action = wezterm.action.ActivatePaneDirection("Left") },
	{ key = "j", mods = "CMD", action = wezterm.action.ActivatePaneDirection("Down") },
	{ key = "k", mods = "CMD", action = wezterm.action.ActivatePaneDirection("Up") },
	{ key = "l", mods = "CMD", action = wezterm.action.ActivatePaneDirection("Right") },
	-- Close pane/tab (using CMD/Meta)
	{ key = "w", mods = "CMD", action = wezterm.action.CloseCurrentPane({ confirm = true }) },
	{ key = "w", mods = "CMD|SHIFT", action = wezterm.action.CloseCurrentTab({ confirm = true }) },
	-- Toggle zoom (maximize pane) (using CMD/Meta)
	{ key = "z", mods = "CMD", action = wezterm.action.TogglePaneZoomState },
	-- Tab navigation (using CMD/Meta)
	{ key = "{", mods = "CMD|SHIFT", action = wezterm.action.ActivateTabRelative(-1) },
	{ key = "}", mods = "CMD|SHIFT", action = wezterm.action.ActivateTabRelative(1) },
	-- Show tab navigator (using CMD/Meta)
	{ key = "p", mods = "CMD", action = wezterm.action.ShowTabNavigator },
	-- Rename tab (using CMD/Meta)
	{
		key = "E",
		mods = "CMD|SHIFT",
		action = wezterm.action.PromptInputLine({
			description = "Enter new name for tab",
			action = wezterm.action_callback(function(window, _, line)
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},
}
-- config.window_decorations = "RESIZE" -- Allow resizing without full title bar
config.window_background_opacity = 0.95
config.macos_window_background_blur = 10 -- Frosted glass effect
config.enable_scroll_bar = true -- Us

-- config.font = wezterm.font("JetBrains Mono", { italic = true })
-- config.font_size = 12.0 --

-- and finally, return the configuration to wezterm
return config
