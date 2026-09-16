pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Wayland
import "Singletons" as T

ShellRoot {
    Scope {
        id: monitorShell

        PanelWindow {
            color: "transparent"
            exclusionMode: ExclusionMode.Normal
            exclusiveZone: implicitHeight
            implicitHeight: 44
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
                mask: pillRegion
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
