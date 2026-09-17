import QtQuick
import "Singletons" as T
import "surfaces"
import "components"

Item {
    id: pill
    property bool expanded: false
    readonly property real targetHeight: currentFace.implicitHeight + frame.verticalPadding * 2
    readonly property real targetWidth: currentFace.implicitWidth + frame.horizontalPadding * 2
    readonly property bool compactPillActive: true
    readonly property var currentFace: compactPillActive ? compactPill : expandedBar

    implicitHeight: targetHeight
    implicitWidth: targetWidth
    height: implicitHeight
    width: implicitWidth

    SurfaceFrame {
        id: frame
        anchors.fill: parent

        CompactPill {
            id: compactPill
            anchors.fill: parent
        }

        ExpandedBar {
            id: expandedBar
            anchors.fill: parent
        }
    }
}
