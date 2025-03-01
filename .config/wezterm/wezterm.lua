local wezterm = require("wezterm")
local mux = wezterm.mux
local act = wezterm.action
local zsh_path = "/usr/bin/zsh"
--flashes on x11 or wayland currently
local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")

local config = {}
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- settings
config.window_close_confirmation = "NeverPrompt"
config.use_fancy_tab_bar = false
config.default_prog = { zsh_path, "-l" }
config.window_decorations = "RESIZE"
config.scrollback_lines = 3000
-- temporarily use for hyprland session
config.enable_wayland = false

-- styles
config.color_scheme = "duckbones"
config.font = wezterm.font_with_fallback({ "Iosevka Nerd Font Mono" })
config.font_size = 13.5
config.window_background_opacity = 0.97
config.initial_cols = 190
config.initial_rows = 40
config.inactive_pane_hsb = {
	saturation = 0.2,
	brightness = 0.5,
}

-- tab-bar
config.tab_bar_at_bottom = false

-- keybinds
config.leader = { key = "Space", mods = "ALT|CTRL", timeout_milliseconds = 1000 }
config.keys = {
	{ key = "t", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
	{ key = "\\", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "-", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "LeftArrow", mods = "LEADER", action = act.ActivateTabRelative(-1) },
	{ key = "RightArrow", mods = "LEADER", action = act.ActivateTabRelative(1) },
	{ key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
	{ key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
	{ key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
	{ key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
	{ key = "p", mods = "LEADER", action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES|TABS" }) },
	{ key = "x", mods = "LEADER", action = act.QuitApplication },
	{ key = "q", mods = "LEADER", action = act.CloseCurrentPane({ confirm = false }) },
	{
		key = "r",
		mods = "LEADER",
		action = act.ActivateKeyTable({ name = "resize_panes", timeout_milliseconds = 1000, one_shot = false }),
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
		theme = "kanagawabones",
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
	extensions = {},
}

-- default workspace config
wezterm.on("gui-startup", function(cmd)
	tabline.setup(tabline_config)
	tabline.apply_to_config(config)
	local args = {}
	if cmd then
		for key, value in pairs(cmd.args) do
			if value == "yazi" then
				---Yazi-----
				local tab, pane, window = mux.spawn_window({
					workspace = "yazi",
					args = args,
				})
				pane:send_text("y\n")
				------------
				mux.set_active_workspace("yazi")
				return
			elseif value == "neovim" then
				---Programming-----
				local tab, terminal_pane, window = mux.spawn_window({
					workspace = "programming",
					args = args,
				})
				local editor_pane = terminal_pane:split({
					direction = "Top",
					size = 0.80,
				})
				editor_pane:send_text("nvim\n")
				-------------------
				mux.set_active_workspace("programming")
				return
			elseif value == "btop" then
				---BTOP-----
				local tab, pane, window = mux.spawn_window({
					workspace = "default",
					args = args,
				})
				pane:send_text("btop\n")
				------------
				mux.set_active_workspace("default")
				return
			end
		end
		---Default---
		local tab, pane, window = mux.spawn_window({
			workspace = "default",
			args = args,
		})
		pane:send_text(tostring(table.concat(cmd.args, " ") .. "\n"))
		-------------
		mux.set_active_workspace("default")
		return
	end
	---Default---
	local tab, pane, window = mux.spawn_window({
		workspace = "default",
		args = args,
	})
	-------------
	mux.set_active_workspace("default")
end)

return config
