-- coger símbolos de aquí
-- http://fontawesome.bootstrapcheatsheets.com/

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")

-- Necesito letras más grandes y se crea con esto
-- Importante es que luego no se usa .show_help(), sino :show_help
-- Ver aquí (y no olvidar que hay que ponerlo en function()... end)
-- https://www.reddit.com/r/awesomewm/comments/qll62c/problems_resizing_the_hotkeys_popup/
local hotkeys_popup = require("awful.hotkeys_popup").widget.new({font = 'Monospace 12', description_font = 'Monospace 12' })

local vicious = require("vicious")

local keygrabber = require("awful.keygrabber")

-- Cargar el widget del centro desde el archivo separado
-- Es realmente una prueba...
local center_widget = require("center_widget")

-- Error handling
-- Check if awesome encountered an error during startup
-- and fell back to another config (This code will only ever execute for
-- the fallback config)
if awesome.startup_errors then
	naughty.notify({
		preset = naughty.config.presets.critical,
		title = "Oops, there were errors during startup!",
		text = awesome.startup_errors,
	})
end

-- Handle runtime errors after startup
do
	local in_error = false
	awesome.connect_signal("debug::error", function(err)
		-- Make sure we don't go into an endless error loop
		if in_error then
			return
		end
		in_error = true

		naughty.notify({
			preset = naughty.config.presets.critical,
			title = "Oops, an error happened!",
			text = tostring(err),
		})
		in_error = false
	end)
end

-- Variable definitions
-- Themes define colours, icons, font and wallpapers.
--beautiful.init(awful.util.get_themes_dir() .. "default/theme.lua")
--beautiful.init("/usr/share/awesome/themes/wabbit/theme.lua")
beautiful.init("/home/igor/.config/awesome/themes/powerarrow-darker/theme.lua")
--beautiful.init("/home/igor/giteando/awesome-copycats/themes/copland/theme.lua")
--beautiful.init("/home/igor/giteando/awesome-themes/bamboo/theme.lua")

-- This is used later as the default terminal and editor to run.
-- terminal = "urxvtc"
terminal = "wezterm" -- kitty
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
modkey = "Mod4"

-- Letra
naughty.config.defaults.font = "Monospace 11" -- or beautiful.font

-- markup = lain.util.markup
gray = "#9E9C9A"
--beautiful.wallpaper="/home/igor/latexpruebas/wallp/stratigraphy.png"
--beautiful.wallpaper="/home/igor/latexpruebas/wallp/the_swing.png"
--beautiful.wallpaper="/home/igor/latexpruebas/wallp/2880x1800.png"
--beautiful.wallpaper="/home/igor/Pictures/wallpapers/cabeza.jpg"
beautiful.wallpaper = "/home/igor/Pictures/wallpapers/i3-wallpaper-negro.png"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
	awful.layout.suit.floating,
	awful.layout.suit.tile,
	awful.layout.suit.tile.left,
	--    awful.layout.suit.tile.bottom,
	awful.layout.suit.tile.top,
  	awful.layout.suit.fair,
	-- awful.layout.suit.fair.horizontal,
	-- awful.layout.suit.spiral,
	-- awful.layout.suit.spiral.dwindle,
	awful.layout.suit.max,
	--  awful.layout.suit.max.fullscreen,
	--  awful.layout.suit.magnifier,
	 awful.layout.suit.corner.nw,
	--  awful.layout.suit.corner.ne,
	--  awful.layout.suit.corner.sw,
	--  awful.layout.suit.corner.se,
}

-- Helper functions
local function client_menu_toggle_fn()
	local instance = nil

	return function()
		if instance and instance.wibox.visible then
			instance:hide()
			instance = nil
		else
			instance = awful.menu.clients({ theme = { width = 250 } })
		end
	end
end


-- Configurar el keygrabber
local gap_keygrabber
gap_keygrabber = keygrabber({
	start_callback = function()
		naughty.notify({ text = "Modo de ajuste de gaps activado. Usa + o - para ajustar." })
	end,
	stop_callback = function()
		naughty.notify({ text = "Modo de ajuste de gaps desactivado." })
	end,
  -- You might want to avoid `export_keybindings` if you want
  -- a single point of entry. If so, they use a normal `awful.key`
  -- to start the keygrabber
	export_keybindings = false,
	keybindings = {
		-- Aumentar gaps con "+"
		{
			{},
			"+",
			function()
				awful.tag.incgap(2)
			end,
		},
		-- Reducir gaps con "-"
		{
			{},
			"-",
      function()
				awful.tag.incgap(-2)
			end,
		},
		{
			{},
			"Escape",
			function()
				gap_keygrabber:stop()
			end,
		},
	},
})

-- Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
	{
		"hotkeys",
		function()
			return false, hotkeys_popup:show_help()
		end,
	},
	{ "manual", terminal .. " -e man awesome" },
	{ "edit config", editor_cmd .. " " .. awesome.conffile },
	{ "restart", awesome.restart },
	{
		"quit",
		function()
			awesome.quit()
		end,
	},
}

mymainmenu = awful.menu({
	items = {
		{ "awesome", myawesomemenu, beautiful.awesome_icon },
		{ "open terminal", terminal },
		{ "reiniciar", "systemctl reboot" },
		{ "bloquear", "i3lock -i /home/igor/Pictures/otros/error_windows.png && sleep 1" },
		{ "apagar", "systemctl poweroff -i" },
		{ "cambiar usuario", "/usr/bin/dm-tool switch-to-greeter" },
	},
})

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon, menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock("%H:%M")

-- Create a wibox for each screen and add it
local taglist_buttons = awful.util.table.join(
	awful.button({}, 1, function(t)
		t:view_only()
	end),
	awful.button({ modkey }, 1, function(t)
		if client.focus then
			client.focus:move_to_tag(t)
		end
	end),
	awful.button({}, 3, awful.tag.viewtoggle),
	awful.button({ modkey }, 3, function(t)
		if client.focus then
			client.focus:toggle_tag(t)
		end
	end),
	awful.button({}, 4, function(t)
		awful.tag.viewnext(t.screen)
	end),
	awful.button({}, 5, function(t)
		awful.tag.viewprev(t.screen)
	end)
)

local tasklist_buttons = awful.util.table.join(
	awful.button({}, 1, function(c)
		if c == client.focus then
			c.minimized = true
		else
			-- Without this, the following
			-- :isvisible() makes no sense
			c.minimized = false
			if not c:isvisible() and c.first_tag then
				c.first_tag:view_only()
			end
			-- This will also un-minimize
			-- the client, if needed
			client.focus = c
			c:raise()
		end
	end),
	awful.button({}, 3, client_menu_toggle_fn())
	-- awful.button({ }, 4, function ()
	--                          awful.client.focus.byidx(1)
	--                      end),
	-- awful.button({ }, 5, function ()
	--                          awful.client.focus.byidx(-1)
	-- end)
)

local function set_wallpaper(s)
	-- Wallpaper
	if beautiful.wallpaper then
		local wallpaper = beautiful.wallpaper
		-- If wallpaper is a function, call it with the screen
		if type(wallpaper) == "function" then
			wallpaper = wallpaper(s)
		end
		gears.wallpaper.maximized(wallpaper, s, true)
	end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

--- Creamos los tags para cada screen con sus características
awful.screen.connect_for_each_screen(function(s)
	-- Wallpaper
	set_wallpaper(s)

	awful.tag.add("1", {
		--icon               = "/path/to/icon1.png",
		layout = awful.layout.suit.max,
		screen = s,
		gap = 3,
		gap_single_client = false,
		selected = true,
	})

	awful.tag.add("2", {
		--icon = "/path/to/icon2.png",
		layout = awful.layout.suit.max,
		screen = s,
	})

	awful.tag.add("3", {
		--icon               = "/path/to/icon1.png",
		layout = awful.layout.suit.max,
		screen = s,
	})

	awful.tag.add("4", {
		--icon               = "/path/to/icon1.png",
		layout = awful.layout.suit.tile.top,
		master_fill_policy = "master_width_factor",
		gap_single_client = true,
		gap = 3,
		screen = s,
	})

	awful.tag.add("5", {
		layout = awful.layout.suit.tile.max,
		screen = s,
		gap = 1,
	})

	awful.tag.add("6", {
		layout = awful.layout.suit.tile.max,
		screen = s,
		gap = 1,
	})

	awful.tag.add("7", {
		--icon               = "/path/to/icon1.png",
		layout = awful.layout.suit.tile,
		--master_fill_policy = "master_width_factor",
		gap_single_client = true,
		gap = 2,
		screen = s,
	})

	awful.tag.add("8", {
		layout = awful.layout.suit.floating,
		screen = s,
	})

	awful.tag.add("9", {
		layout = awful.layout.suit.floating,
		screen = s,
	})

	-- esto es de lain y eso como usar quake
	-- s.quake = lain.util.quake({app=terminal, height=0.5, width=0.5,
	--     		       vert="center", horiz="center"})

	-- Create a promptbox for each screen
	s.mypromptbox = awful.widget.prompt()
	-- Create an imagebox widget which will contains an icon indicating which layout we're using.
	-- We need one layoutbox per screen.
	s.mylayoutbox = awful.widget.layoutbox(s)
	-- s.mylayoutbox:buttons(awful.util.table.join(
	--                        awful.button({ }, 1, function () awful.layout.inc( 1) end),
	--                        awful.button({ }, 3, function () awful.layout.inc(-1) end),
	--                        awful.button({ }, 4, function () awful.layout.inc( 1) end),
	--                        awful.button({ }, 5, function () awful.layout.inc(-1) end)))
	-- Create a taglist widget
	s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, taglist_buttons)

	-- Create a tasklist widget: este era el original q es muy simple
	-- s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, tasklist_buttons)
	--
	-- esto más elaborado lo tengo de aquí:
	-- https://awesomewm.org/doc/api/classes/awful.widget.tasklist.html
	s.mytasklist = awful.widget.tasklist({
		screen = s,
		filter = awful.widget.tasklist.filter.currenttags,
		buttons = tasklist_buttons,
		style = {
			shape_border_width = 1,
			shape_border_color = "#777777",
			shape = gears.shape.rounded_bar,
		},
		layout = {
			spacing = 10,
			spacing_widget = {
				{
					forced_width = 7,
					shape = gears.shape.circle,
					widget = wibox.widget.separator,
				},
				valign = "center",
				halign = "center",
				widget = wibox.container.place,
			},
			layout = wibox.layout.flex.horizontal,
		},
		-- Notice that there is *NO* wibox.wibox prefix, it is a template,
		-- not a widget instance.
		widget_template = {
			{
				{
					{
						{
							id = "icon_role",
							widget = wibox.widget.imagebox,
						},
						margins = 2,
						widget = wibox.container.margin,
					},
					{
						id = "text_role",
						widget = wibox.widget.textbox,
					},
					layout = wibox.layout.fixed.horizontal,
				},
				left = 10,
				right = 10,
				widget = wibox.container.margin,
			},
			id = "background_role",
			widget = wibox.container.background,
		},
	})

	-- maildir
	s.personalwidget = wibox.widget({
		align = "center",
		--valign = 'bottom',
		widget = wibox.widget.textbox,
	})
	vicious.register(s.personalwidget, vicious.widgets.mdir, function(widget, args)
		local label = "<span color='#A40000'> </span>" .. args[1] .. markup("#333333", "|")
		return label
	end, 120, { "/home/igor/Mail/inbox" })

	-- UVA
	s.uva = wibox.widget({
		align = "center",
		--valign = 'bottom',
		widget = wibox.widget.textbox,
	})
	vicious.register(s.uva, vicious.widgets.mdir, function(widget, args)
		local label = args[1] .. markup("#333333", "|")
		return label
	end, 300, { "/home/igor/Mail/uva/INBOX" })

	-- Georeligion
	s.georeligion = wibox.widget({
		align = "center",
		--valign = 'bottom',
		widget = wibox.widget.textbox,
	})
	vicious.register(s.georeligion, vicious.widgets.mdir, function(widget, args)
		local label = args[1]
		return label
	end, 6000, { "/home/igor/Mail/geo/INBOX" })

	-- paquetes de arch
	s.paqueteswidget = wibox.widget({
		align = "center",
		--valign = 'bottom',
		widget = wibox.widget.textbox,
	})
	vicious.register(s.paqueteswidget, vicious.widgets.pkg, '<span color="#A40000"></span> $1', 7200, "Arch")

	-- volumen
	-- s.volumewidget = wibox.widget.textbox(valign='bottom')
	s.volumewidget = wibox.widget({
		align = "center",
		--valign = 'bottom',
		widget = wibox.widget.textbox,
	})
	vicious.register(s.volumewidget, vicious.widgets.volume, function(widget, args)
		local label = { ["♫"] = "O", ["♩"] = "M" }
		--local valor = '<span color="#A40000">⊜⊕⦿♫</span> ' .. args[1] .. '%'
		local valor = '<span color="#A40000"></span> ' .. args[1] .. "% "
		return valor
	end, 6, "Master")
	-- añadimos botones
	s.volumewidget:buttons(awful.util.table.join(
		awful.button({}, 1, function()
			awful.util.spawn("pavucontrol")
		end),
		awful.button({}, 2, mute_volume)
	)) -- Register assigned buttons
	s.volumewidget:buttons(s.volumewidget:buttons())

	-- CPU widget
	cpuwidget = wibox.widget.graph()
	cpuwidget:set_width(50)
	cpuwidget:set_background_color("#1A1A1A")
	cpuwidget:set_color({
		type = "linear",
		from = { 0, 0 },
		to = { 50, 0 },
		stops = { { 0, "#FF5656" }, { 0.5, "#88A175" }, { 1, "#AECF96" } },
	})
	vicious.register(cpuwidget, vicious.widgets.cpu, "$1", 5)

	--Network name widget.
	wifiwidget = wibox.widget.textbox()
	vicious.register(wifiwidget, vicious.widgets.wifi, function(widget, args)
		local red
		if args["{ssid}"] == "N/A" then
			red = "-"
		else
			red = args["{ssid}"]
		end
		return string.format('<span color="#A40000"></span> %.8s', red)
	end, 25, "wlp2s0")
	-- añadimos botones
	wifiwidget:buttons(awful.util.table.join(awful.button({}, 1, function()
		awful.util.spawn("nm-connection-editor")
	end))) -- Register assigned buttons
	wifiwidget:buttons(wifiwidget:buttons())

	--
	-- local fsbar = wibox.widget {
	--    forced_height    = 0.3,
	--    forced_width     = 59,
	--    color            = beautiful.fg_normal,
	--    background_color = beautiful.bg_normal,
	--    margins          = 1,
	--    paddings         = 1,
	--    ticks            = true,
	--    ticks_size       = 6,
	--    widget           = wibox.widget.progressbar,
	-- }
	s.batwidget = wibox.widget({
		align = "center",
		--valign = 'bottom',
		widget = wibox.widget.textbox,
	})
	s.batwidget:buttons(awful.util.table.join(awful.button({}, 1, function()
		awful.util.spawn("xfce4-power-manager-settings")
	end))) -- Register assigned buttons
	s.batwidget:buttons(s.batwidget:buttons())

	--local fsbg = wibox.container.background(fsbar, "#474747", gears.shape.rectangle)
	--local fswidget = wibox.container.margin(fsbg, 2, 7, 8, 0)
	--vicious.register(fsbar, vicious.widgets.bat, "$2", 61, "BAT1")
	vicious.register(s.batwidget, vicious.widgets.bat, function(widget, args)
		return "<span color='#A40000'></span> " .. args[2] .. "% [" .. args[1] .. "]"
	end, 61, "BAT0")

	-- está Oviedo encendido?
	oviedowidget = wibox.widget({
		align = "center",
		widget = wibox.widget.textbox,
	})

	-- días para final de contrato
	contratowidget = wibox.widget({
		align = "center",
		widget = wibox.widget.textbox,
	})

	-- Create the wibox
	s.mywibox = awful.wibar({ position = "top", screen = s })

	cajonsistema = wibox.widget.systray()
	--cajonsistema:set_base_size(16)

	--local spr       = wibox.widget.textbox(' ')
	--local small_spr = wibox.widget.textbox('<span font="Tamsyn 4"> </span>')
	--local bar_spr   = wibox.widget.textbox('<span font="Tamsyn 4"> </span>' .. markup("#333333", "|") .. '<span font="Tamsyn 4"> </span>')
	local bar_spr = wibox.widget.textbox(" » ")

	-- Add widgets to the wibox
	s.mywibox:setup({
		layout = wibox.layout.align.horizontal,
		{ -- Left widgets
			layout = wibox.layout.fixed.horizontal,
			--mylauncher,
			s.mytaglist,
			bar_spr,
			cpuwidget,
			bar_spr,
		},
		s.mytasklist, -- Middle widget
		{ -- Right widgets
			layout = wibox.layout.fixed.horizontal,
			--s.nuevocheck,
			--fsbar,
			--fswidget,
			wifiwidget,
			bar_spr,
			s.batwidget,
			bar_spr,
			s.paqueteswidget,
			bar_spr,
			-- oviedowidget,
			-- bar_spr,
			-- s.personalwidget,
			-- s.erfurtwidget,
			-- s.uva,
			s.georeligion,
			bar_spr,
			contratowidget,
			-- bar_spr,
			s.volumewidget,
			cajonsistema,			--wibox.widget.systray(),
			s.mylayoutbox,
			mytextclock,
		},
	})
end)

-- Mouse bindings
root.buttons(awful.util.table.join(
	awful.button({}, 3, function()
		mymainmenu:toggle()
	end)
	-- esto es como la rueda arriba y abajo
	--awful.button({ }, 4, awful.tag.viewnext),
	--awful.button({ }, 5, awful.tag.viewprev)
))

-- Key bindings
globalkeys = awful.util.table.join(
	awful.key({ modkey }, "s", function() hotkeys_popup:show_help() end, { description = "show help", group = "awesome" }),

	awful.key({ modkey }, "j", function()
		awful.client.focus.byidx(1)
	end, { description = "focus next by index", group = "client" }),
	awful.key({ modkey }, "k", function()
		awful.client.focus.byidx(-1)
	end, { description = "focus previous by index", group = "client" }),
	awful.key({ modkey }, "w", function()
		mymainmenu:show()
	end, { description = "show main menu", group = "awesome" }),

	-- Layout manipulation
	awful.key({ modkey, "Shift" }, "j", function()
		awful.client.swap.byidx(1)
	end, { description = "swap with next client by index", group = "client" }),
	awful.key({ modkey, "Shift" }, "k", function()
		awful.client.swap.byidx(-1)
	end, { description = "swap with previous client by index", group = "client" }),
	awful.key({ modkey, "Control" }, "j", function()
		awful.screen.focus_relative(1)
	end, { description = "focus the next screen", group = "screen" }),
	awful.key({ modkey, "Control" }, "k", function()
		awful.screen.focus_relative(-1)
	end, { description = "focus the previous screen", group = "screen" }),

	-- Standard program
	awful.key({ modkey }, "Return", function()
		awful.spawn(terminal)
	end, { description = "open a terminal", group = "launcher" }),
	-- awful.key({ modkey, "Control" }, "r", awesome.restart,
	--           {description = "reload awesome", group = "awesome"}),
	-- awful.key({ modkey, "Shift"   }, "q", awesome.quit,
	--           {description = "quit awesome", group = "awesome"}),

	awful.key({ modkey, "Shift" }, "l", function()
		awful.tag.incmwfact(0.02)
	end, { description = "increase master width factor", group = "layout" }),
	awful.key({ modkey, "Shift" }, "h", function()
		awful.tag.incmwfact(-0.02)
	end, { description = "decrease master width factor", group = "layout" }),
	awful.key({ modkey, "Control" }, "+", function()
		awful.tag.incnmaster(1, nil, true)
	end, { description = "increase the number of master clients", group = "layout" }),
	awful.key({ modkey, "Control" }, "-", function()
		awful.tag.incnmaster(-1, nil, true)
	end, { description = "decrease the number of master clients", group = "layout" }),
	-- awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
	--           {description = "increase the number of columns", group = "layout"}),
	-- awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
	--           {description = "decrease the number of columns", group = "layout"}),
	awful.key({ modkey }, "space", function()
		awful.layout.inc(1)
	end, { description = "select next", group = "layout" }),
	-- awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
	--    {description = "select previous", group = "layout"}),
	awful.key(
		{ modkey },
		"BackSpace",
		awful.tag.history.restore,
		{ description = "select previous tag", group = "tag" }
	),
	awful.key({ modkey }, "m", function()
		local c = client.focus
		if c == awful.client.getmaster() then
			awful.client.focus.history.previous()
			if client.focus then
				client.focus:raise()
			end
		else
			client.focus = awful.client.getmaster()
			client.focus:raise()
		end
	end),

	-- Las mías
	awful.key({}, "XF86AudioPlay", function()
		awful.util.spawn("mpc toggle")
	end),
	awful.key({}, "XF86AudioNext", function()
		awful.util.spawn("mpc next")
	end),
	awful.key({}, "XF86AudioPrev", function()
		awful.util.spawn("mpc prev")
	end),
	awful.key({}, "XF86AudioMute", function()
		awful.util.spawn("amixer set Master toggle")
	end),
	awful.key({}, "KP_Subtract", function()
		awful.util.spawn("amixer set Master 5%-")
	end),
	-- awful.key({ }, "KP_Add", function() awful.util.spawn("amixer set Master 5%+") end),
	awful.key({}, "KP_Insert", function()
		awful.util.spawn("amixer set Master 5%+")
	end),

	awful.key({ modkey }, "d", function()
		awful.util.spawn("rofi -show drun -theme solarized -icon-theme 'Papirus' -show-icons")
	end),
	awful.key({ modkey }, "Print", function()
		awful.util.spawn("flameshot gui")
	end, { description = "Hacer un screenshot", group = "general" }),

	awful.key({ modkey }, "F1", function()
		awful.util.spawn("i3lock -i /home/igor/Pictures/wallpapers/windows-fatal-exception_1920x1080.png && sleep 1")
	end, { description = "bloquear pantalla", group = "general" }),
	awful.key({ modkey }, "F2", function()
		awful.util.spawn("/home/igor/programacion/shell/dmenfm")
	end, { description = "abrir fichero", group = "general" }),
	awful.key({ modkey }, "F3", function()
		awful.util.spawn("rofi -show window")
	end),

  awful.key({ modkey }, "ñ", function()
    center_widget.toggle()
  end, { description = "mostrar/ocultar widget en el centro", group = "custom" }),
	--awful.key({ modkey }, "F4", function () awful.layout.set(awful.layout.suit.max) end),
	-- awful.key({ modkey }, "F5", function () saltaracorreo("mutt -f ~/Mail/inbox") end,
	--    {description = "saltar a mutt-personal", group = "general"}),
	-- awful.key({ modkey }, "F6", function() saltaracorreo("mutt -f ~/Mail/erfurt/INBOX") end,
	--    {description = "saltar a mutt-erfurt", group = "general"}),
	awful.key({ modkey }, "F7", function () escogerlayout() end),
	-- awful.key({ modkey, }, ",", function () awful.screen.focused().quake:toggle() end),

	awful.key({ modkey }, "o", function()
		local focalizar = awful.screen.focused().index == 1 and 2 or 1
		awful.screen.focus(focalizar)
		-- if awful.screen.focused().index== 1 then
		--    awful.screen.focus(2)
		-- else
		--    awful.screen.focus(1)
		-- end
	end, { description = "saltar de una pantalla a otra", group = "screen" }),

	awful.key({ modkey }, "Escape", function() -- "KP_Begin"
		local c = client.focus
		if c.class == "mpv" or c.class == "smplayer" or c.class == "vlc" or c.name == "Picture-in-Picture" then
			awful.client.focus.history.previous()
			if client.focus then
				client.focus:raise()
			end
		else
			local cls = client.get()
			for _, c in ipairs(cls) do
				if c.class == "mpv" or c.class == "smplayer" or c.class == "vlc" or c.name == "Picture-in-Picture" then
					client.focus = c
					c:raise()
				end
			end
		end
	end),

	-- Vincula el keygrabber a una combinación de teclas
	awful.key({ modkey, "Shift" }, "g", function()
		-- Inicia el keygrabber
		gap_keygrabber:start()
		-- gap_keygrabber:run()
	end, { description = "ajustar gaps con keygrabber", group = "layout" })
)

clientkeys = awful.util.table.join(
	awful.key({ modkey }, "f", function(c)
		c.fullscreen = not c.fullscreen
		c:raise()
	end, { description = "toggle fullscreen", group = "client" }),
	awful.key({ modkey, "Shift" }, "c", function(c)
		c:kill()
	end, { description = "close", group = "client" }),
	awful.key(
		{ modkey, "Control" },
		"space",
		awful.client.floating.toggle,
		{ description = "toggle floating", group = "client" }
	),
	awful.key({ modkey, "Shift" }, "m", function(c)
		c:swap(awful.client.getmaster())
	end, { description = "move to master", group = "client" }),
	awful.key({ modkey, "Shift" }, "o", function(c)
		c:move_to_screen()
	end, { description = "move to screen", group = "screen" }),
	awful.key({ modkey }, "t", function(c)
		c.ontop = not c.ontop
	end, { description = "toggle keep on top", group = "client" }),
	awful.key({ modkey }, "v", function(c)
		c.sticky = not c.sticky
	end),
	awful.key({ modkey, "Control" }, "t", function(c)
		-- toggle titlebar
		awful.titlebar.toggle(c)
	end, { description = "toggle la titlebar", group = "client" }),
	--awful.key({ modkey, "Control" }, "z", lain.util.magnify_client)
	-- awful.key({ modkey,   }, "z", lain.util.magnify_client),

	awful.key({ modkey, "Control" }, "m", function(c)
		c.maximized = not c.maximized
		c:raise()
	end, { description = "maximizar", group = "client" }),

	awful.key({ modkey }, "a", function(c)
		awful.placement.top_right(c, { honor_workarea = true })
	end, { description = "Mover a la esquina derecha", group = "client" })
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
	globalkeys = awful.util.table.join(
		globalkeys,

		-- Ver la ventana
		awful.key({ modkey }, "#" .. i + 9, function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			local actual = awful.screen.focused().selected_tag
			local sel_idx = actual.index
			if tag and sel_idx == i then
				awful.tag.history.restore()
			else
				tag:view_only()
			end
		end),

    -- mover ventana a #
		awful.key({ modkey, "Shift" }, "#" .. i + 9, function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then
					client.focus:move_to_tag(tag)
				end
			end
  end))
end

clientbuttons = awful.util.table.join(
	awful.button({}, 1, function(c)
		client.focus = c
		c:raise()
	end),
	awful.button({ modkey }, 1, awful.mouse.client.move),
	awful.button({ modkey }, 3, awful.mouse.client.resize)
)

-- Set keys
root.keys(globalkeys)

-- Rules
-- Rules to apply to new clients (through the "manage" signal).

-- require("configuration.rules")

awful.rules.rules = {
	-- All clients will match this rule.
	{
		rule = {},
		properties = {
			border_width = beautiful.border_width,
			border_color = beautiful.border_normal,
			focus = awful.client.focus.filter,
			raise = true,
			keys = clientkeys,
			buttons = clientbuttons,
			titlebars_enabled = false,
			size_hints_honor = false,
			screen = awful.screen.preferred,
			placement = awful.placement.no_overlap + awful.placement.no_offscreen,
		},
	},

	-- Esto ya venía por defecto...
	{
		rule_any = {
			instance = {
				"DTA", -- Firefox addon DownThemAll.
				"copyq", -- Includes session name in class.
			},
			class = {
				"Gpick",
				"Wpa_gui",
				"xtightvncviewer",
			},

			name = {
				"Event Tester", -- xev.
			},
			role = {
				"AlarmWindow", -- Thunderbird's calendar.
				"pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
				"page-info", -- esto es lo de página de info en firefox, pero sospecho que la rule posterior lo sobreescribe...
			},
		},
		properties = { floating = true },
	},

	{
		rule_any = { type = { "dialog" } },
		properties = { floating = true, titlebars_enabled = false, placement = awful.placement.centered },
	},

	{
		rule_any = {
			class = {
				"Arandr",
				"Gimp",
				"gimp",
				"Wxcam",
				"Sxiv",
				"Ristretto",
				"Scid",
				"Toplevel",
				"Xarchiver",
				"Gsopcast",
				"Galculator",
				"Nm-connection-editor",
				"Thunar",
				"Pinentry",
				"pinentry-qt",
				"Soffice",
				"XEyes",
				"Atril",
				"Gthumb",
				"Gvim",
				"qtPredicadores",
				"qtAjedrez",
				"Mate-calc",
				"Zotero",
				"SimpleScreenRecorder",
				"Gtk-recordMyDesktop",
			},
		}, -- Toplevel es de scid
		properties = { floating = true, placement = awful.placement.centered },
	},

	-- realmente no sería necesario lo de x,y en geometry con lo de top_right,
	-- pero parece que primero hace lo del placement y luego la geometría...
	-- ATENCIÓN: esto de focusable=false está puesto para evitar que cuando es sticky
	-- me ponga el cursor en el jodido vídeo cuando cambio de tag, pero no sé
	-- si tiene efectos secundarios.
	{
		rule_any = { class = { "mpv", "smplayer", "vlc", "Freetuxtv" }, name = { "Picture-in-Picture" } },
		properties = {
			floating = true,
			ontop = true,
			sticky = true,
			focusable = false,
			--geometry={x = 764, y = 20, width = 600 , height = 300}, placement = awful.placement.top_right({honor_workarea=true}),} },
			geometry = { width = 700, height = 400 },
			placement = awful.placement.top_right,
		},
	},

	{
		rule_any = { class = { "firefox", "luakit", "qutebrowser", "Chromium" } },
		properties = { screen = 1, tag = "3" },
	},

	{ rule = { instance = "plugin-container" }, properties = { floating = true, focus = true } },

	{
		rule = { class = "Pavucontrol" },
		properties = {
			floating = true,
			ontop = true,
			geometry = { x = 764, y = 20, width = 600, height = 300 },
			placement = awful.placement.top_right,
		},
	},

	{
		rule_any = { class = { "Telegram", "telegram-desktop", "Skype", "Gnucash", "Element", "Signal" } },
		properties = { screen = 1, tag = "9", floating = true },
	},

	-- lo mismo que lo anterior pero con gretl para que le ponga barras de título
	-- porque si no es un lío, pues abre un montón de ventanas
	-- tessaract: ese programa de OCR
	{
		rule_any = { class = { "Gretl_x11", "Tessaract-gui", "Xboard" } },
		properties = { screen = 1, tag = "9", floating = true, titlebars_enabled = true },
	},

	{
		rule = { class = "qtPredicadores" },
		-- properties = { floating = true, placement = awful.placement.centered, titlebars_enabled = true }},
		properties = { floating = true, titlebars_enabled = true },
	},

	-- java-lang-Thread es realmente protegé (lo de las ontologías)
	{
		rule_any = {
			class = {
				"VirtualBox",
				"java-lang-Thread",
				"FreeMind",
				"Anki",
				"gThumb",
				"Dvdrip",
				"Evolution",
				"Postman",
				"Microsoft Teams - Preview",
			},
		},
		properties = { screen = 1, tag = "8", floating = true },
	},

	-- jetbrains-studio es android-studio, libprs500 es calibre
	-- Start.tcl es scid
	-- no entiendo por qué no funciona lo de maximizar...
	{
		rule_any = {
			class = {
				"QtCreator",
				"QGIS3",
				"org-openstreetmap-josm-gui-MainApplication",
				"Filezilla",
				"Baobab",
				"Ario",
				"gr-talent-atlas-Main",
				"Kodi",
				"MyTourbook",
				"jetbrains-studio",
				"NetBeans IDE 8.1",
				"libprs500",
				"calibre",
				"Start.tcl",
				"unnamed0 - yEd",
				"RStudio",
				"HandBrake",
				"PkgBrowser",
				"DBeaver",
				"Blender",
				"Inkscape",
				"Shotcut",
				"Audacity",
				"thunderbird",
			},
		},
		--      properties = { screen=screen:count()>1 and 2 or 1, tag = "8", maximized_vertical = true, maximized_horizontal = true} }
		--      properties = { screen=screen:count()>1 and 2 or 1, tag = "8"} }
		properties = { tag = "8" },
	},
}

-- Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
	-- Set the windows at the slave,
	-- i.e. put it at the end of others instead of setting it master.
	-- if not awesome.startup then awful.client.setslave(c) end

	if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
		-- Prevent clients from being unreachable after screen count changes.
		awful.placement.no_offscreen(c)
	end
end)

--- redondear borders
--- https://www.reddit.com/r/awesomewm/comments/61s020/round_corners_for_every_client/
client.connect_signal("manage", function(c)
	c.shape = function(cr, w, h)
		gears.shape.rounded_rect(cr, w, h, 10)
	end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
	-- buttons for the titlebar
	local buttons = awful.util.table.join(
		awful.button({}, 1, function()
			client.focus = c
			c:raise()
			awful.mouse.client.move(c)
		end),
		awful.button({}, 3, function()
			client.focus = c
			c:raise()
			awful.mouse.client.resize(c)
		end)
	)

	-- funciona con el left, pero no consigo poner bien
	-- los elementos de la barra para que se vean
	-- en principio hay que usar lo de rotate, supongo.
	--    awful.titlebar(c, { position = "left" }) : setup {
	awful.titlebar(c, { position = "top" }):setup({
		--
		{ -- Left
			awful.titlebar.widget.iconwidget(c),
			buttons = buttons,
			layout = wibox.layout.fixed.horizontal,
		},
		{ -- Middle
			{ -- Title
				align = "center",
				widget = awful.titlebar.widget.titlewidget(c),
			},
			buttons = buttons,
			layout = wibox.layout.flex.horizontal,
		},
		{ -- Right
			awful.titlebar.widget.floatingbutton(c),
			awful.titlebar.widget.maximizedbutton(c),
			awful.titlebar.widget.stickybutton(c),
			awful.titlebar.widget.ontopbutton(c),
			awful.titlebar.widget.closebutton(c),
			layout = wibox.layout.fixed.horizontal(),
		},
		layout = wibox.layout.align.horizontal,
	})
end)

-- esto lo tengo de aquí
-- https://github.com/copycat-killer/awesome-copycats/blob/master/rc.lua.powerarrow-darker
-- quita el borde cuando no eestá maximizado o solo hay uno
-- o estamos en el layout maximizado
client.connect_signal("focus", function(c)
	c.opacity = 1
	if
		(c.maximized_horizontal == true and c.maximized_vertical == true)
		or awful.layout.get(mouse.screen) == awful.layout.suit.max
	then
		c.border_width = 0
		-- no borders if only 1 client visible
	elseif #awful.client.visible(mouse.screen) > 1 then
		c.border_width = beautiful.border_width
		c.border_color = beautiful.border_focus
	end

	-- esto es para el caso de smplayer, etc. cuando
	-- están flotando... pero habría que mirar si tiene
	-- efectos secundarios
	if c.floating then
		c.border_width = beautiful.border_width
		c.border_color = beautiful.border_focus
	end
end)

client.connect_signal("unfocus", function(c)
	c.opacity = 0.85
	c.border_color = beautiful.border_normal
end)

-- esto son cosas mías

--- para que vuelva a ontop los programas después de pasar a fullscreen.
client.connect_signal("property::fullscreen", function(c)
	if c.class == "mpv" or c.class == "vlc" or c.class == "smplayer" or c.name == "Picture-in-Picture" then
		if c.fullscreen == false then
			c.ontop = true
		end
	end
end)

-- salta a la ventana con el correo que se pida
function saltaracorreo(correo)
	local c = client.focus
	if c.name == correo then
		awful.tag.history.restore()
	else
		local tag = awful.tag.gettags(1)[4]
		awful.tag.viewonly(tag)
		local cls = client.get(mouse.screen)
		for _, c in ipairs(cls) do
			if c.name == correo then
				client.focus = c
				c:raise()
			end
		end
	end
end

function escogerlayout()
	local f = assert(io.popen("echo -e 'full\nflotante\nmosaico\nfair' | rofi -dmenu", "r"))
	local disposicion = assert(f:read("*a"))
	f:close()

	if disposicion == "full\n" then
		awful.layout.set(awful.layout.suit.max)
	elseif disposicion == "flotante\n" then
		awful.layout.set(awful.layout.suit.floating)
	elseif disposicion == "mosaico\n" then
           awful.layout.set(awful.layout.suit.tile)
        elseif disposicion == "fair\n" then
           awful.layout.set(awful.layout.suit.fair)
	end
end

-- en teoría esto lo tengo yo msimo ahí arriba...
-- c.ontop = true is lost after fullscreen toggle, need to fix this
-- client.connect_signal("property::fullscreen", function(c)
--   if c.name and isClientTitleMatches(c.name) and not c.fullscreen then
--     c.ontop = true
--   end
-- end)

-- con esto se consigue que muestre barra de título
-- sólo en los clientes que están flotantes
-- function show_on_floating(c)
--     if  awful.client.floating.get(c) then -- no sé si esta sintaxis es la awesome>4.0
--         awful.titlebar.show(c)
--     else
--         awful.titlebar.hide(c)
--     end
-- end

-- client.connect_signal("property::floating", show_on_floating)

-- Mis programas

awful.util.spawn_with_shell("mpdscribble")
-- awful.util.spawn_with_shell("xfce4-power-manager")

-- o awful.spawn.with_shell???
-- awful.util.spawn_with_shell("setxkbmap -option caps:escape")
