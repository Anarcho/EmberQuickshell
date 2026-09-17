pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import "Singletons" as T

PanelWindow {
    implicitHeight: T.Spacing.sm + T.Dimensions.compactPillHeight + T.Spacing.sm
    color: "transparent"
    anchors {
        top: true
        left: true
        right: true
    }

    Pill {
        id: pill
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: T.Spacing.sm
    }
}
