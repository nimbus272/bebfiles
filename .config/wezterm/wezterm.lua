local wezterm = require("wezterm")
local zsh_path = "/usr/bin/zsh"
local act = wezterm.action
local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
local modal = wezterm.plugin.require("https://github.com/MLFlexer/modal.wezterm")

local config = {}
if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.ssh_domains = {
	{
		name = "media-server",
		remote_address = "10.0.0.179",
		username = "bebbis",
		multiplexing = "None",
	},
	{
		name = "monitors",
		remote_address = "10.0.0.48",
		username = "bebbis",
		multiplexing = "None",
	},
	{
		name = "other-dockers",
		remote_address = "10.0.0.69",
		username = "bebbis",
		multiplexing = "None",
	},
}

-- keybinds
config.leader = { key = "Space", mods = "ALT|CTRL", timeout_milliseconds = 1000 }
config.keys = {
	{ key = "t", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
	{ key = "\\", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "-", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "l", mods = "LEADER", action = act.ActivateTabRelative(-1) },
	{ key = "h", mods = "LEADER", action = act.ActivateTabRelative(1) },
	{ key = "h", mods = "CTRL", action = act.ActivatePaneDirection("Left") },
	{ key = "l", mods = "CTRL", action = act.ActivatePaneDirection("Right") },
	{ key = "k", mods = "CTRL", action = act.ActivatePaneDirection("Up") },
	{ key = "j", mods = "CTRL", action = act.ActivatePaneDirection("Down") },
	{ key = "p", mods = "LEADER", action = act.ActivateCommandPalette },
	{
		key = "r",
		mods = "LEADER",
		action = act.ActivateKeyTable({ name = "resize_panes", timeout_milliseconds = 1000, one_shot = false }),
	},
	{
		key = "p",
		mods = "CTRL|SHIFT",
		action = "DisableDefaultAssignment",
	},
}

local copy_mode = wezterm.gui.default_key_tables().copy_mode
table.insert(copy_mode, {
	key = "y",
	mods = "NONE",
	action = act.Multiple({ { CopyTo = "ClipboardAndPrimarySelection" }, { CopyMode = "ClearSelectionMode" } }),
})

config.key_tables = {
	resize_panes = {
		{ key = "h", action = act.AdjustPaneSize({ "Left", 2 }) },
		{ key = "k", action = act.AdjustPaneSize({ "Up", 2 }) },
		{ key = "j", action = act.AdjustPaneSize({ "Down", 2 }) },
		{ key = "l", action = act.AdjustPaneSize({ "Right", 2 }) },
	},
	copy_mode = copy_mode,
}

local tabline_config = {
	options = {
		icons_enabled = true,
		theme = "duckbones",
		tabs_enabled = true,
		theme_overrides = {},
		section_separators = {
			left = wezterm.nerdfonts.pl_left_hard_divider,
			right = wezterm.nerdfonts.pl_right_hard_divider,
		},
		component_separators = {
			left = wezterm.nerdfonts.pl_left_soft_divider,
			right = wezterm.nerdfonts.pl_right_soft_divider,
		},
		tab_separators = {
			left = wezterm.nerdfonts.pl_left_hard_divider,
			right = wezterm.nerdfonts.pl_right_hard_divider,
		},
	},
	sections = {
		tabline_a = { "mode" },
		tabline_b = { "workspace" },
		tabline_c = { " " },
		tab_active = {
			"index",
			{ "parent", padding = 0 },
			"/",
			{ "cwd", padding = { left = 0, right = 1 } },
			{ "zoomed", padding = 0 },
		},
		tab_inactive = { "index", { "process", padding = { left = 0, right = 1 } } },
		tabline_x = { "cpu" },
		tabline_y = { "datetime" },
		tabline_z = { "domain" },
	},
}

-- settings
config.window_close_confirmation = "NeverPrompt"
config.use_fancy_tab_bar = false
config.default_prog = { zsh_path, "-l" }
config.window_decorations = "RESIZE"
config.scrollback_lines = 3000
-- temporarily use for hyprland session
config.enable_wayland = true

-- styles
-- config.color_scheme = "duckbones"
config.font = wezterm.font_with_fallback({ "Iosevka Nerd Font Mono" })
config.font_size = 13.5
config.window_background_opacity = 0.97
config.initial_cols = 190
config.initial_rows = 40
config.inactive_pane_hsb = {
	saturation = 0.2,
	brightness = 0.5,
}

tabline.setup(tabline_config)
tabline.apply_to_config(config)
modal.enable_defaults("https://github.com/MLFlexer/modal.wezterm")

config.colors = {
	-- COLORS: duckbones
	-- The default text color
	foreground = "#ebefc0",
	-- The default background color
	background = "#0e101a",

	-- Overrides the cell background color when the current cell is occupied by the
	-- cursor and the cursor style is set to Block
	cursor_bg = "#edf2c2",
	-- Overrides the text color when the current cell is occupied by the cursor
	cursor_fg = "#0e101a",
	-- Specifies the border color of the cursor when the cursor style is set to Block,
	-- or the color of the vertical or horizontal bar when the cursor style is set to
	-- Bar or Underline.
	cursor_border = "#edf2c2",

	-- the foreground color of selected text
	selection_fg = "#ebefc0",
	-- the background color of selected text
	selection_bg = "#37382d",
	ansi = {
		"#0e101a",
		"#e03600",
		"#5dcd97",
		"#e39500",
		"#00a3cb",
		"#795ccc",
		"#00a3cb",
		"#ebefc0",
	},
	brights = {
		"#2b2f46",
		"#ff4821",
		"#58db9e",
		"#f6a100",
		"#00b4e0",
		"#b3a1e6",
		"#00b4e0",
		"#b3b692",
	},
}
modal.apply_to_config(config)

local smart_splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")
-- you can put the rest of your Wezterm config here
smart_splits.apply_to_config(config, {
	direction_keys = { "h", "j", "k", "l" },
	modifiers = {
		move = "CTRL", -- modifier to use for pane movement, e.g. CTRL+h to move left
		resize = "ALT", -- modifier to use for pane resize, e.g. META+h to resize to the left
	},
	log_level = "info",
})

return config
