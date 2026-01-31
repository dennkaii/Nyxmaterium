//background
import Quickshell
import QtQuick
import Quickshell.Wayland

Scope {
    id: background
    Variants {
        model: Quickshell.screens
        PanelWindow {
            id: wallpaperWindow
            required property var modelData
            screen: modelData

            WlrLayershell.layer: WlrLayer.Background
            WlrLayershell.exclusionMode: ExclusionMode.Ignore
            anchors {
                right: true
                left: true
                bottom: true
                top: true
            }
            aboveWindows: false
            Item {
                Image {
                    source: "./bg.png"
                    width: screen.width
                    height: screen.height
                }
            }
        }
    }
}
