set +e
dms run &
wl-paste --type text --watch cliphist store &
wl-paste --type image --watch cliphist store &
# keep clipboard content
wl-clip-persist --clipboard regular --reconnect-tries 0 &
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=wlroot &
/usr/lib/xdg-desktop-portal-wlr &
xwayland-satellite &
fcitx5 &
