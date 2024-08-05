local wezterm = require("wezterm")

config = wezterm.config_builder()

config = {
	automatically_reload_config = true,
	enable_tab_bar = false,
	window_close_confirmation = "NeverPrompt",
	color_scheme = "Gruvbox dark, pale (base16)",
	font = wezterm.font_with_fallback({
		"Ubuntu Mono",
		"JetBrains Mono",
	}),
	font_size = 14.0,
	line_height = 1.15,
}

return config
