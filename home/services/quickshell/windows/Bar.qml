import Quickshell
import QtQuick
import QtQuick.Layouts
import "../components/bar"

Scope {
PanelWindow {
        id:barwin

        anchors {
                left: true
		top: true
		bottom: true

        }
        	width: 70 
                	exclusiveZone: width - margins.left

	// color: "transparent"


                Rectangle {
                        id:barrect

                        anchors {
			top: parent.top
			bottom: parent.bottom
			margins: 10
		}

// top part of bar??
                ColumnLayout {

                        Layout.fillWidth: true
                }

                ColumnLayout {
                        anchors {
			left: parent.left
			right: parent.right
			bottom: parent.bottom
                		}



                                Tray { 
                                }
                }
                                

                }
}}
