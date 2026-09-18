import QtQuick
import "Singletons" as T
import "surfaces"
import "components"

Item {
    id: pill
    property bool expanded: false
    readonly property real targetHeight: currentFace.implicitHeight
    readonly property real targetWidth: currentFace.implicitWidth
    readonly property bool compactPillActive: false
    readonly property var currentFace: compactPill

    implicitHeight: targetHeight
    implicitWidth: targetWidth
    height: implicitHeight
    width: implicitWidth

    Behavior on height {
        enabled: T.Motion.enabled

        NumberAnimation {
            duration: T.Motion.morph
            easing.type: T.Motion.easeOut
        }
    }

    Behavior on width {
        enabled: T.Motion.enabled
        NumberAnimation {
            duration: T.Motion.morph
            easing.type: T.Motion.easeOut
        }
    }

    SurfaceFrame {
        id: frame
        profile: pill.currentFace.profile
        anchors.fill: parent

        CompactPillSurface {
            id: compactPill
            anchors.fill: parent
            visible: true
        }

        ExpandedBarSurface {
            id: expandedBar
            anchors.fill: parent
            visible: false
        }
    }
}
