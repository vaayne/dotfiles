local wezterm = require("wezterm")
local config = {}
local act = wezterm.action
if wezterm.config_builder then
    config = wezterm.config_builder()
end

config = {
    default_cursor_style = "SteadyBar",
    automatically_reload_config = true,
    window_close_confirmation = "NeverPrompt",
    adjust_window_size_when_changing_font_size = false,
    window_background_opacity = 0.7,
    text_background_opacity = 0.6,
    window_decorations = "RESIZE",
    check_for_updates = false,
    use_fancy_tab_bar = false,
    tab_bar_at_bottom = false,
    font_size = 12.5,
    font = wezterm.font("JetBrains Mono", { weight = "Bold" }),
    -- enable_tab_bar = false,
    window_padding = {
        left = 3,
        right = 3,
        top = 0,
        bottom = 0,
    },
    leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 },
    keys = {
        -- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
        -- This sends the escape sequence for moving the cursor backward by one word
        { key = "LeftArrow",  mods = "OPT",    action = wezterm.action { SendString = "\x1bb" } },
        -- Make Option-Right equivalent to Alt-f; forward-word
        -- This sends the escape sequence for moving the cursor forward by one word
        { key = "RightArrow", mods = "OPT",    action = wezterm.action { SendString = "\x1bf" } },
        -- Jump to beginning of line
        -- This sends the Control-A character, which is typically used to move to the start of a line
        { key = "LeftArrow",  mods = "CMD",    action = wezterm.action { SendString = "\x01" } },
        -- Jump to end of line
        -- This sends the Control-E character, which is typically used to move to the end of a line
        { key = "RightArrow", mods = "CMD",    action = wezterm.action { SendString = "\x05" } },
        -- Clear screen
        -- This sends the Control-L character, which is commonly used to clear the terminal screen
        { key = "k",          mods = "LEADER", action = wezterm.action.SendString("\x0c") },
        -- Split pane horizontally
        -- This creates a new pane below the current one
        { key = '\\',         mods = 'LEADER', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
        -- Split pane vertically
        -- This creates a new pane to the right of the current one
        { key = '-',          mods = 'LEADER', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },
        -- Close current pane
        -- This closes the active pane with a confirmation prompt
        { key = 'x',          mods = 'LEADER', action = wezterm.action.CloseCurrentPane { confirm = true } },
        {
            key = 'LeftArrow',
            mods = 'LEADER',
            action = act.ActivatePaneDirection 'Left',
        },
        {
            key = 'RightArrow',
            mods = 'LEADER',
            action = act.ActivatePaneDirection 'Right',
        },
        {
            key = 'UpArrow',
            mods = 'LEADER',
            action = act.ActivatePaneDirection 'Up',
        },
        {
            key = 'DownArrow',
            mods = 'LEADER',
            action = act.ActivatePaneDirection 'Down',
        },
    },
    -- from: https://akos.ma/blog/adopting-wezterm/
    hyperlink_rules = {
        -- Matches: a URL in parens: (URL)
        {
            regex = "\\((\\w+://\\S+)\\)",
            format = "$1",
            highlight = 1,
        },
        -- Matches: a URL in brackets: [URL]
        {
            regex = "\\[(\\w+://\\S+)\\]",
            format = "$1",
            highlight = 1,
        },
        -- Matches: a URL in curly braces: {URL}
        {
            regex = "\\{(\\w+://\\S+)\\}",
            format = "$1",
            highlight = 1,
        },
        -- Matches: a URL in angle brackets: <URL>
        {
            regex = "<(\\w+://\\S+)>",
            format = "$1",
            highlight = 1,
        },
        -- Then handle URLs not wrapped in brackets
        {
            -- Before
            --regex = '\\b\\w+://\\S+[)/a-zA-Z0-9-]+',
            --format = '$0',
            -- After
            regex = "[^(]\\b(\\w+://\\S+[)/a-zA-Z0-9-]+)",
            format = "$1",
            highlight = 1,
        },
        -- implicit mailto link
        {
            regex = "\\b\\w+@[\\w-]+(\\.[\\w-]+)+\\b",
            format = "mailto:$0",
        },
    },
}


-- Apply color scheme based on the WEZTERM_THEME environment variable
local themes = {
    nord = "Nord (Gogh)",
    onedark = "One Dark (Gogh)",
}
local success, stdout, stderr = wezterm.run_child_process({ os.getenv("SHELL"), "-c", "printenv WEZTERM_THEME" })
local selected_theme = stdout:gsub("%s+", "") -- Remove all whitespace characters including newline
config.color_scheme = themes[selected_theme]


return config
