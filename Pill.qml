pragma ComponentBehavior: Bound
import QtQuick
import "surfaces"
import "components"

Item {
    id: pill
    property bool expanded: false
    readonly property var currentFace: compactPill
    height: implicitHeight

    readonly property real targetHeight: (currentFace ? currentFace.implicitHeight : compactPill.implicitHeight)

    SurfaceFrame {
        id: frame
        CompactPill {
            id: compactPill
        }
    }
}
