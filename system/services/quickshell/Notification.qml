import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Notifications

Scope {
    id: root

    // --- LOGIC ---
    property var currentNotification: null
    property bool showNotification: false

    Timer {
        id: notificationTimer
        interval: 5000
        onTriggered: root.showNotification = false
    }

    // CORRECT WAY: Listen to the global singleton
    Connections {
        target: NotificationServer

        // Note: signal name might be 'onNotificationAdded' or just 'onNotification'
        // Try 'onNotificationAdded' first as it is most common in Quickshell
        function onNotificationAdded(notification) {
            root.currentNotification = notification;
            root.showNotification = true;
            notificationTimer.restart();
        }
    }

    // --- VISUAL ---
    LazyLoader {
        active: root.showNotification

        PanelWindow {
            anchors {
                top: true
                right: true
            }
            margins.top: 20
            margins.right: 20
            implicitWidth: 300
            implicitHeight: 80
            color: "transparent"

            Rectangle {
                anchors.fill: parent
                color: "#1e1e2e"
                radius: 10
                border.color: "#313244"
                border.width: 1

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 10
                    spacing: 10

                    IconImage {
                        Layout.preferredWidth: 48
                        Layout.preferredHeight: 48
                        source: root.currentNotification?.icon || Quickshell.iconPath("dialog-information-symbolic")
                    }

                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 2

                        Text {
                            Layout.fillWidth: true
                            text: root.currentNotification?.summary ?? "Notification"
                            color: "white"
                            font.bold: true
                            font.pixelSize: 14
                            elide: Text.ElideRight
                        }

                        Text {
                            Layout.fillWidth: true
                            text: root.currentNotification?.body ?? ""
                            color: "#cdd6f4"
                            font.pixelSize: 12
                            wrapMode: Text.Wrap
                            maximumLineCount: 2
                            elide: Text.ElideRight
                        }
                    }
                }
            }
        }
    }
}
