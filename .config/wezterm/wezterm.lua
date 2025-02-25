local wezterm = require("wezterm")
local mux = wezterm.mux
local act = wezterm.action
local zsh_path = "/usr/bin/zsh"

local config = {}
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- default workspace config
wezterm.on("gui-startup", function(cmd)
	local args = {}
	local default = ""
	if cmd then
		for key, value in pairs(cmd.args) do
			if value == "yazi" then
				default = "yazi"
				---Yazi-----
				local tab, pane, window = mux.spawn_window({
					workspace = "yazi",
					args = args,
				})
				pane:send_text("y\n")
				------------
				mux.set_active_workspace(default)
				return
			elseif value == "neovim" then
				default = "programming"
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
				mux.set_active_workspace(default)
				return
			end
		end
		if default == "" then
			default = "default"
			---Default---
			local tab, pane, window = mux.spawn_window({
				workspace = "default",
				args = args,
			})
			pane:send_text(tostring(table.concat(cmd.args, " ") .. "\n"))
			-------------
			mux.set_active_workspace(default)
			return
		end
	else
		default = "default"
		---Default---
		local tab, pane, window = mux.spawn_window({
			workspace = "default",
			args = args,
		})
		-------------
		mux.set_active_workspace(default)
		return
	end
end)

-- settings
config.window_close_confirmation = "NeverPrompt"
config.use_fancy_tab_bar = false
config.default_prog = { zsh_path, "-l" }
config.window_decorations = "RESIZE"
config.scrollback_lines = 3000
-- temporarily use for hyprland session
config.enable_wayland = false

-- styles
-- config.color_scheme = "Kanagawa (Gogh)"
config.color_scheme_dirs = { "~/.config/wezterm/colors" }
config.color_scheme = "wallust"
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
config.status_update_interval = 1000
wezterm.on("update-status", function(window, pane)
	local stat = window:active_workspace()
	local stat_color = "#f7768e"

	if window:active_key_table() then
		stat = window:active_key_table()
		stat_color = "#7dcfff"
	end

	if window:leader_is_active() then
		stat = "LDR"
		stat_color = "#bb9af7"
	end

	local basename = function(s)
		return string.gsub(s, "(.*[/\\])(.*)", "%2")
	end

	local cwd = pane:get_current_working_dir()
	if cwd then
		if type(cwd) == "userdata" then
			cwd = basename(cwd.file_path)
		else
			cwd = basename(cwd)
		end
	else
		cwd = ""
	end

	local cmd = pane:get_foreground_process_name()
	cmd = cmd and basename(cmd) or ""

	local time = wezterm.strftime("%H:%M")

	window:set_left_status(wezterm.format({
		{ Foreground = { Color = stat_color } },
		{ Text = " " },
		{ Text = wezterm.nerdfonts.oct_table .. " " .. stat },
		{ Text = " |" },
	}))

	window:set_right_status(wezterm.format({
		{ Text = wezterm.nerdfonts.md_folder .. " " .. cwd },
		{ Text = " | " },
		{ Foreground = { Color = "#e0af68" } },
		{ Text = wezterm.nerdfonts.fa_code .. " " .. cmd },
		"ResetAttributes",
		{ Text = " | " },
		{ Text = wezterm.nerdfonts.md_clock .. " " .. time },
		{ Text = " " },
	}))
end)

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

config.key_tables = {
	resize_panes = {
		{ key = "h", action = act.AdjustPaneSize({ "Left", 2 }) },
		{ key = "k", action = act.AdjustPaneSize({ "Up", 2 }) },
		{ key = "j", action = act.AdjustPaneSize({ "Down", 2 }) },
		{ key = "l", action = act.AdjustPaneSize({ "Right", 2 }) },
	},
}

return config
