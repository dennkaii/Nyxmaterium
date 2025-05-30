import fabric
from fabric import Application
from fabric.widgets.box import Box
from fabric.widgets.container import Container
from fabric.widgets.label import Label
from fabric.widgets.button import Button
from fabric.widgets.datetime import DateTime
from fabric.widgets.wayland import WaylandWindow as Window
from fabric.widgets.centerbox import CenterBox
from fabric.utils import monitor_file, get_relative_path
from services.mpris import MprisPlayerManager, MprisPlayer


class musicwidget(Box):
    def __init__(self, **kwargs):
        super().__init__()


class StatusBar(Window):
    def __init__(self, **kwargs):
        super().__init__(
            layer="top",  # Ensure it stays above other apps
            anchor="left top bottom",  # Anchors the bar at the top, stretching from left to right
            exclusivity="auto",  # Reserves space for the bar so it behaves like a normal window
            **kwargs
        )
        self.date_time = DateTime()
        self.children = CenterBox(
            orientation="v",
            start_children=self.date_time,
            center_children=self.first,
        )


def apply_stylesheet(*_):
    return app.set_stylesheet_from_file(get_relative_path("./style.css"))


if __name__ == "__main__":
    bar = StatusBar()
    app = Application("bar", bar)

    style_monitor = monitor_file(get_relative_path("."))
    style_monitor.connect("changed", apply_stylesheet)
    apply_stylesheet()
    app.run()
