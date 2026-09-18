pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import "Singletons" as T

ShellRoot {
    Variants {
        model: Quickshell.screens

        Scope {
            id: monitorShell
            required property var modelData

            PanelWindow {
                implicitHeight: T.Spacing.sm + pill.implicitHeight + T.Spacing.sm
                color: "transparent"
                screen: monitorShell.modelData
                anchors {
                    top: true
                    left: true
                    right: true
                }

                Pill {
                    id: pill
                    screenName: monitorShell.modelData.name
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: T.Spacing.sm
                }
            }
        }
    }
}
