local wezterm = require("wezterm")

local config = wezterm.config_builder()

local function executable_path(candidates)
	for _, path in ipairs(candidates) do
		local file = io.open(path, "r")
		if file then
			file:close()
			return path
		end
	end
	return nil
end

local zellij = executable_path({
	"/opt/homebrew/bin/zellij",
	"/usr/local/bin/zellij",
})

config.automatically_reload_config = true
config.set_environment_variables = {
	PATH = table.concat({
		"/opt/homebrew/bin",
		"/usr/local/bin",
		os.getenv("PATH") or "/usr/bin:/bin:/usr/sbin:/sbin",
	}, ":"),
}
if zellij then
	config.default_prog = { zellij, "attach", "--create", "main" }
end
config.enable_tab_bar = false
config.window_close_confirmation = "NeverPrompt"
config.check_for_updates = false
config.audible_bell = "Disabled"

config.color_scheme = "Gruvbox dark, pale (base16)"
config.font = wezterm.font_with_fallback({
	"JetBrains Mono",
	"Symbols Nerd Font Mono",
	"Maple Mono NF",
})
config.font_size = 13.0
config.line_height = 1.0
config.window_padding = {
	left = "1 cell",
	right = "1 cell",
	top = 0,
	bottom = 0,
}

config.use_dead_keys = false
config.enable_kitty_keyboard = true
config.send_composed_key_when_left_alt_is_pressed = false
config.send_composed_key_when_right_alt_is_pressed = false

config.keys = {
	-- keep shift-enter behavior for alternate newline
	{ key = "Enter", mods = "SHIFT", action = wezterm.action.SendString("\x1b\r") },
}

config.colors = {
	foreground = "#ECE1D7",
	background = "#292522",
	cursor_bg = "#ECE1D7",
	cursor_border = "#ECE1D7",
	cursor_fg = "#292522",
	selection_bg = "#403A36",
	selection_fg = "#ECE1D7",
	ansi = {
		"#34302C",
		"#BD8183",
		"#78997A",
		"#E49B5D",
		"#7F91B2",
		"#B380B0",
		"#7B9695",
		"#C1A78E",
	},
	brights = {
		"#867462",
		"#D47766",
		"#85B695",
		"#EBC06D",
		"#A3A9CE",
		"#CF9BC2",
		"#89B3B6",
		"#ECE1D7",
	},
}

return config
