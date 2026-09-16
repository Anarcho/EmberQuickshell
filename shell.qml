pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Wayland
import "Singletons" as T

ShellRoot {
    Variants {
        model: Quickshell.screens
        Scope {
            id: monitorShell

            required property var modelData

            PanelWindow {
                color: "transparent"
                exclusionMode: ExclusionMode.Normal
                exclusiveZone: implicitHeight
                implicitHeight: 44
                screen: monitorShell.modelData
                mask: Region {}

                anchors {
                    left: true
                    right: true
                    top: true
                }

                PanelWindow {
                    id: overlay
                    WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive
                    WlrLayershell.layer: WlrLayer.Overlay
                    WlrLayershell.namespace: "ember"
                    color: "transparent"
                    exclusionMode: ExclusionMode.Ignore
                    mask: pill
                    screen: monitorShell.modelData
                    anchors {
                        bottom: true
                        left: true
                        right: true
                        top: true
                    }

                    Region {
                        id: fullRegion
                        height: overlay.height
                        width: overlay.width
                    }

                    Region {
                        id: pillRegion
                        height: Math.ceil(pill.height)
                        width: Math.ceil(pill.width)
                        x: Math.floor(pill.x)
                        y: Math.floor(pill.y)
                    }

                    Pill {
                        id: pill
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                        anchors.topMargin: T.Spacing.sm
                    }
                }
            }
        }
    }
}
