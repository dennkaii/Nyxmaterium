import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Widgets
import Quickshell.Io

Scope {
    id: root
    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink, Pipewire.defaultAudioSource]
    }

    // ==========================================================
    //                 SPEAKER
    // ==========================================================
    property bool showSpeakerOsd: false

    Connections {
        target: Pipewire.defaultAudioSink?.audio
        function onVolumeChanged() {
            root.triggerSpeaker();
        }
        function onMutedChanged() {
            root.triggerSpeaker();
        }
    }

    function triggerSpeaker() {
        if (root.startupComplete) {
            root.showSpeakerOsd = true;
            speakerTimer.restart();
        }
    }

    Timer {
        id: speakerTimer
        interval: 1500
        onTriggered: root.showSpeakerOsd = false
    }

    LazyLoader {
        active: root.showSpeakerOsd
        PanelWindow {
            anchors.bottom: true
            margins.bottom: screen.height / 5
            exclusiveZone: 0
            implicitWidth: 400
            implicitHeight: 50
            color: "transparent"
            mask: Region {}

            Rectangle {
                anchors.fill: parent
                radius: height / 2
                color: "#80000000"

                RowLayout {
                    anchors {
                        fill: parent
                        leftMargin: 20
                        rightMargin: 20
                    }
                    spacing: 15

                    // Speaker Icon
                    IconImage {
                        Layout.preferredHeight: 24
                        Layout.preferredWidth: 24
                        source: Quickshell.iconPath((Pipewire.defaultAudioSink?.audio.muted ?? false) ? "audio-volume-muted-symbolic" : "audio-volume-high-symbolic")
                    }

                    // Speaker Bar (Keep this!)
                    Rectangle {
                        Layout.fillWidth: true
                        implicitHeight: 6
                        radius: 3
                        color: "#50ffffff"
                        // FIX 1: Add clip to cut off any overflow visually
                        clip: true

                        Rectangle {
                            height: parent.height
                            radius: parent.radius
                            color: "white"

                            // FIX 2: Math.min ensures width never goes past 100% size
                            width: {
                                var vol = Pipewire.defaultAudioSink?.audio.volume ?? 0;
                                var isMuted = Pipewire.defaultAudioSink?.audio.muted ?? false;

                                if (isMuted)
                                    return 0;

                                // Cap the width at parent.width (1.0)
                                return Math.min(parent.width, parent.width * vol);
                            }

                            Behavior on width {
                                NumberAnimation {
                                    duration: 80
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    // ==========================================================
    //                          MICROPHONE
    // ==========================================================
    property bool showMicOsd: false

    Connections {
        target: Pipewire.defaultAudioSource?.audio
        function onVolumeChanged() {
            root.triggerMic();
        }
        function onMutedChanged() {
            root.triggerMic();
        }
    }

    function triggerMic() {
        if (root.startupComplete) {
            root.showMicOsd = true;
            micTimer.restart();
        }
    }

    Timer {
        id: micTimer
        interval: 1500
        onTriggered: root.showMicOsd = false
    }

    LazyLoader {
        active: root.showMicOsd
        PanelWindow {
            anchors.bottom: true
            // Position it slightly higher than speaker OSD to distinguish it
            margins.bottom: (screen.height / 5) + 60
            exclusiveZone: 0

            // Smaller window since it's just an icon
            implicitWidth: 60
            implicitHeight: 60

            color: "transparent"
            mask: Region {}

            Rectangle {
                anchors.fill: parent
                radius: 30 // Circular
                color: "#80000000"

                // Just the Icon, centered. NO BAR.
                IconImage {
                    anchors.centerIn: parent
                    width: 32
                    height: 32

                    source: Quickshell.iconPath((Pipewire.defaultAudioSource?.audio.muted ?? false) ? "audio-input-microphone-muted-symbolic" : "audio-input-microphone-high-symbolic")
                }
            }
        }
    }
    // ==========================================================
    //                         Brightness
    // ==========================================================

    property double brightnessVal: 0
    property double maxBrightnessVal: 1
    property bool showBrightOsd: false

    // Brightness logic probably
    property string backlightDir: "/sys/class/backlight/amdgpu_bl1"

    FileView {
        id: maxBrightFile
        path: root.backlightDir + "/max_brightness"
    }
    FileView {
        id: currentBrightFile
        path: root.backlightDir + "/brightness"
        watchChanges: true

        // Triggers when the system updates the file
        onFileChanged: {
            this.reload(); // Refresh the data property

            if (root.startupComplete) {
                root.showBrightOsd = true;
                brightTimer.restart();
            }
        }
    }
    // Calculate Percentage
    property double brightPercent: {
        // Force string conversion and trim whitespace (newlines)
        let currStr = String(currentBrightFile.data()).trim();
        let maxStr = String(maxBrightFile.data()).trim();

        let curr = parseFloat(currStr);
        let max = parseFloat(maxStr);

        // Debug output to your terminal
        console.log(`[OSD] Brightness Update - Current: '${currStr}' (${curr}), Max: '${maxStr}' (${max})`);

        if (isNaN(curr) || isNaN(max) || max === 0) {
            return 0;
        }

        return curr / max;
    }
    Timer {
        id: brightTimer
        interval: 1500
        onTriggered: root.showBrightOsd = false
    }

    // Startup Safety (prevents OSD on login)
    property bool startupComplete: false
    Timer {
        interval: 500
        running: true
        onTriggered: root.startupComplete = true
    }

    // brightness window
    LazyLoader {
        active: root.showBrightOsd
        PanelWindow {
            anchors.bottom: true
            margins.bottom: screen.height / 5
            exclusiveZone: 0
            implicitWidth: 400
            implicitHeight: 50
            color: "transparent"
            mask: Region {}

            Rectangle {
                anchors.fill: parent
                radius: height / 2
                color: "#80000000"

                RowLayout {
                    anchors {
                        fill: parent
                        leftMargin: 20
                        rightMargin: 20
                    }
                    spacing: 15

                    IconImage {
                        Layout.preferredHeight: 24
                        Layout.preferredWidth: 24
                        source: Quickshell.iconPath("display-brightness-symbolic")
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        implicitHeight: 6
                        radius: 3
                        color: "#50ffffff"

                        Rectangle {
                            height: parent.height
                            radius: parent.radius
                            color: "white"

                            // Using the calculated percentage
                            width: parent.width * root.brightPercent

                            Behavior on width {
                                NumberAnimation {
                                    duration: 80
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    // ==========================================================
    //                 Keyboard Light
    // ==========================================================
    property bool showKeyboardOsd: false
    property string keyboardDir: "/sys/class/leds/asus::kbd_backlight"
    // 1. Get Keyboard Max (Static, usually 3)
    FileView {
        id: kbdMaxFile
        path: root.keyboardDir + "/max_brightness"
        Component.onCompleted: this.reload()
    }

    // 2. Watch Keyboard Current
    FileView {
        id: kbdCurrentFile
        path: root.keyboardDir + "/brightness"
        watchChanges: true
        onFileChanged: {
            this.reload();
            if (root.startupComplete) {
                root.showKeyboardOsd = true;
                kbdTimer.restart();
            }
        }
    }

    // Store the raw level (0, 1, 2, 3)
    property int kbdLevel: {
        // We use String() and trim() to clean the file output
        let val = parseInt(String(kbdCurrentFile.data()).trim());
        return isNaN(val) ? 0 : val;
    }

    Timer {
        id: kbdTimer
        interval: 1500
        onTriggered: root.showKeyboardOsd = false
    }

    // 3. KEYBOARD WINDOW (Vertical Layout with 3 Blocks)
    LazyLoader {
        active: root.showKeyboardOsd

        PanelWindow {
            anchors.bottom: true
            margins.bottom: screen.height / 5
            exclusiveZone: 0

            implicitWidth: 200
            implicitHeight: 80

            color: "transparent"
            mask: Region {}

            Rectangle {
                anchors.fill: parent
                radius: 15
                color: "#80000000"

                ColumnLayout {
                    anchors.centerIn: parent
                    spacing: 8

                    // Icon on Top
                    IconImage {
                        Layout.alignment: Qt.AlignHCenter
                        Layout.preferredHeight: 50
                        Layout.preferredWidth: 50
                        source: Quickshell.iconPath("input-keyboard-symbolic")
                    }

                    // Row of 3 discrete blocks
                    RowLayout {
                        Layout.alignment: Qt.AlignHCenter
                        spacing: 6

                        // Block 1 (Low) - Active if Level >= 1
                        Rectangle {
                            implicitWidth: 30
                            implicitHeight: 10
                            radius: 4
                            color: root.kbdLevel >= 1 ? "white" : "#50ffffff"
                        }

                        // Block 2 (Medium) - Active if Level >= 2
                        Rectangle {
                            implicitWidth: 30
                            implicitHeight: 10
                            radius: 4
                            color: root.kbdLevel >= 2 ? "white" : "#50ffffff"
                        }

                        // Block 3 (High) - Active if Level >= 3
                        Rectangle {
                            implicitWidth: 30
                            implicitHeight: 10
                            radius: 4
                            color: root.kbdLevel >= 3 ? "white" : "#50ffffff"
                        }
                    }
                }
            }
        }
    }
}
