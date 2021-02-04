import os
import subprocess
import json
from typing import List  # noqa: F401

from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal


home = os.path.expanduser('~')
config_folder = f"{home}/.config/qtile"

mod = "mod4"
terminal = guess_terminal()

keys = [
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "space", lazy.spawn("launcher"), desc="Start lancher"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.restart(), desc="Restart qtile"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown qtile"),

    Key([mod], "h", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "l", lazy.layout.left(), desc="Move focus to left"),

    Key([mod, "control"], "h", lazy.layout.grow_right(), desc="Grow to right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow up"),
    Key([mod, "control"], "l", lazy.layout.grow_left(), desc="Grow to left"),

    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move to left"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move up"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move to right"),

    Key([mod, "shift"], "Return", lazy.layout.toggle_split(), desc="Toggle between split and unsplit sides of stack"),

    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "f", lazy.window.toggle_floating(), desc="Toggle floating mode"),

    Key([mod], "backslash", lazy.spawn("lock"), desc="Lock screen"),
    Key([mod], "a", lazy.spawn("skippy-xd"), desc="Show apps like Mission Control"),

    Key([], "XF86AudioRaiseVolume", lazy.spawn("volume up")),
    Key([], "XF86AudioLowerVolume", lazy.spawn("volume down")),
    Key([], "XF86AudioMute", lazy.spawn("volume toggle")),
    Key([], "XF86MonBrightnessUp", lazy.spawn("brightness up")),
    Key([], "XF86MonBrightnessDown", lazy.spawn("brightness down")),
]

groups = [Group(i) for i in "1234567890"]

for g in groups:
    keys.extend([
        Key([mod], g.name, lazy.group[g.name].toscreen(), desc="Switch to group {}".format(g.name)),
        Key([mod, "shift"], g.name, lazy.window.togroup(g.name, switch_group=True),
            desc="Switch to & move focused window to group {}".format(g.name)),
    ])

layout_configs = dict(
    border_normal = "#2e3440",
    border_focus = "#5e81ac",
    border_width = 2,
    margin = 5,
    single_margin = 0,
    single_border_width = 0,
)

layouts = [
    layout.MonadTall(**layout_configs),
    layout.Columns(**layout_configs),
    layout.Max(
        border_width=0,
    ),
]

widget_defaults = dict(
    font='Material Icon, JetBrains Mono, sans',
    fontsize=12,
    margin=3,
    padding=3,
)
extension_defaults = widget_defaults.copy()

colors = [
    ["#2e3440", "#2e3440"],  # background
    ["#d8dee9", "#d8dee9"],  # foreground
    ["#3b4252", "#3b4252"],  # background lighter
    ["#bf616a", "#bf616a"],  # red
    ["#a3be8c", "#a3be8c"],  # green
    ["#ebcb8b", "#ebcb8b"],  # yellow
    ["#81a1c1", "#81a1c1"],  # blue
    ["#b48ead", "#b48ead"],  # magenta
    ["#88c0d0", "#88c0d0"],  # cyan
    ["#e5e9f0", "#e5e9f0"],  # white
    ["#4c566a", "#4c566a"],  # grey
    ["#d08770", "#d08770"],  # orange
    ["#8fbcbb", "#8fbcbb"],  # super cyan
    ["#5e81ac", "#5e81ac"],  # super blue
    ["#242831", "#242831"],  # super dark background
]

group_box_settings = {
    "padding": 5,
    "borderwidth": 4,
    "active": colors[9],
    "inactive": colors[10],
    "disable_drag": True,
    "rounded": True,
    "highlight_color": colors[2],
    "block_highlight_text_color": colors[6],
    "highlight_method": "block",
    "this_current_screen_border": colors[14],
    "this_screen_border": colors[7],
    "other_current_screen_border": colors[14],
    "other_screen_border": colors[14],
    "foreground": colors[1],
    "background": colors[14],
    "urgent_border": colors[3],
    "hide_unused": True,
}

screen = Screen(
    wallpaper=f"{home}/Pictures/Wallpapers/tokyo-nightscape-1920x1200.jpg",
    wallpaper_mode="fill",
    bottom=bar.Bar(
        [
            widget.CurrentLayoutIcon(),
            widget.GroupBox(**group_box_settings),
            widget.WindowName(
                padding=10,
            ),
            widget.Chord(
                chords_colors={
                    'launch': ("#ff0000", "#ffffff"),
                },
                name_transform=lambda name: name.upper(),
            ),
            widget.Battery(
                padding=5,
            ),
            widget.Clock(
                format='%Y-%m-%d %a %I:%M %p',
                background='#222222',
                padding=5,
                rounded=True,
            ),
        ],
        32,
        background=colors[0]
    ),
)

screens = [
    screen, screen
]

mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None  # WARNING: this is deprecated and will be removed soon
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    {'wmclass': 'confirm'},
    {'wmclass': 'dialog'},
    {'wmclass': 'download'},
    {'wmclass': 'error'},
    {'wmclass': 'file_progress'},
    {'wmclass': 'notification'},
    {'wmclass': 'splash'},
    {'wmclass': 'toolbar'},
    {'wmclass': 'confirmreset'},  # gitk
    {'wmclass': 'makebranch'},  # gitk
    {'wmclass': 'maketag'},  # gitk
    {'wname': 'branchdialog'},  # gitk
    {'wname': 'pinentry'},  # GPG key password entry
    {'wmclass': 'ssh-askpass'},  # ssh-askpass
])
auto_fullscreen = True
focus_on_window_activation = "smart"

@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/autostart.sh'])

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
