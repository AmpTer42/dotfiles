# Шрифт
c.fonts.default_family = "Terminess Nerd Font Mono"
c.fonts.default_size = "11pt"
c.fonts.hints = "bold 10pt Terminess Nerd Font Mono"
c.fonts.completion.entry = "11pt Terminess Nerd Font Mono"
c.fonts.completion.category = "bold 10pt Terminess Nerd Font Mono"
c.fonts.statusbar = "10pt Terminess Nerd Font Mono"
c.fonts.prompts = "10pt Terminess Nerd Font Mono"
c.fonts.keyhint = "10pt Terminess Nerd Font Mono"
c.fonts.downloads = "10pt Terminess Nerd Font Mono"

c.fonts.web.family.standard = "Terminess Nerd Font Mono"
c.fonts.web.family.fixed = "Terminess Nerd Font Mono"
c.fonts.web.family.serif = "Terminess Nerd Font Mono"
c.fonts.web.family.sans_serif = "Terminess Nerd Font Mono"
c.fonts.web.family.cursive = "Terminess Nerd Font Mono"
c.fonts.web.family.fantasy = "Terminess Nerd Font Mono"
c.content.user_stylesheets = ["~/.config/qutebrowser/defcon.css"]

# Тёмная тема для контента
c.colors.webpage.darkmode.enabled = True
c.colors.webpage.darkmode.policy.images = "never"       # не инвертировать картинки
c.colors.webpage.darkmode.policy.page = "smart"          # только тёмные страницы трогать
c.colors.webpage.preferred_color_scheme = "dark"
c.colors.webpage.bg = "#000308"

# UI Colors
c.colors.completion.fg = "#c8d4e0"
c.colors.completion.odd.bg = "#000308"
c.colors.completion.even.bg = "#03080f"
c.colors.completion.category.fg = "#ffc625"
c.colors.completion.category.bg = "#1e5a8a"
c.colors.completion.category.border.top = "#1e5a8a"
c.colors.completion.category.border.bottom = "#1e5a8a"
c.colors.completion.item.selected.fg = "#000308"
c.colors.completion.item.selected.bg = "#1e5a8a"
c.colors.completion.item.selected.border.top = "#22d3ee"
c.colors.completion.item.selected.border.bottom = "#22d3ee"
c.colors.completion.match.fg = "#22d3ee"
c.colors.completion.scrollbar.fg = "#1e5a8a"
c.colors.completion.scrollbar.bg = "#000308"

c.colors.statusbar.normal.bg = "#000308"
c.colors.statusbar.normal.fg = "#c8d4e0"
c.colors.statusbar.insert.bg = "#3dff8f"
c.colors.statusbar.insert.fg = "#000308"
c.colors.statusbar.command.bg = "#03080f"
c.colors.statusbar.command.fg = "#ffc625"
c.colors.statusbar.url.fg = "#2a4a6b"
c.colors.statusbar.url.success.https.fg = "#3dff8f"
c.colors.statusbar.url.warn.fg = "#ffc625"
c.colors.statusbar.url.error.fg = "#ff2e3f"
c.colors.statusbar.progress.bg = "#ffc625"

c.colors.hints.fg = "#000308"
c.colors.hints.bg = "#ffc625"
c.colors.hints.match.fg = "#ff2e3f"
c.colors.keyhint.fg = "#c8d4e0"
c.colors.keyhint.suffix.fg = "#ffc625"
c.colors.keyhint.bg = "#000308"
c.colors.messages.info.bg = "#1e5a8a"
c.colors.messages.info.fg = "#c8d4e0"
c.colors.messages.error.bg = "#ff2e3f"
c.colors.messages.error.fg = "#000308"
c.colors.messages.warning.bg = "#ffc625"
c.colors.messages.warning.fg = "#000308"

c.colors.tabs.bar.bg = "#000308"
c.colors.tabs.indicator.start = "#22d3ee"
c.colors.tabs.indicator.stop = "#3dff8f"
c.colors.tabs.indicator.error = "#ff2e3f"
c.colors.tabs.odd.bg = "#000308"
c.colors.tabs.odd.fg = "#2a4a6b"
c.colors.tabs.even.bg = "#03080f"
c.colors.tabs.even.fg = "#2a4a6b"
c.colors.tabs.selected.odd.bg = "#1e5a8a"
c.colors.tabs.selected.odd.fg = "#c8d4e0"
c.colors.tabs.selected.even.bg = "#1e5a8a"
c.colors.tabs.selected.even.fg = "#c8d4e0"

# Минимализм UI
c.tabs.position = "top"
c.tabs.show = "multiple"        # только когда >1 вкладки
c.tabs.show_switching_delay = 2000
c.statusbar.show = "in-mode"    # статус-бар только в command/insert режимах
c.statusbar.widgets = ["url", "scroll", "progress"]
c.tabs.title.format = "{audio}{current_title}"
c.tabs.title.format_pinned = "{index}"
c.window.hide_decoration = True
c.scrolling.smooth = True
c.url.start_pages = ["about:blank"]
c.url.default_page = "about:blank"
c.confirm_quit = ["downloads"]

# Бинды под Niri
config.load_autoconfig()
config.bind('o', 'cmd-set-text -s :open -s ')
config.bind('O', 'cmd-set-text -s :open -st ')
