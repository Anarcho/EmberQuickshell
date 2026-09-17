import QtQuick
import "../Singletons" as T

Rectangle {
    id: root
    property bool active: false
    default property alias contentData: content.data
    readonly property alias contentItem: content
    property real preferredContentHeight: 0
    readonly property bool tallSurface: preferredContentHeight > T.Dimensions.expandedBarHeight
    property real horizontalPadding: tallSurface ? T.SurfaceMetrics.majorInset : T.SurfaceMetrics.compactInset
    property real verticalPadding: tallSurface ? T.SurfaceMetrics.majorInset : T.SurfaceMetrics.compactInset
    color: "transparent"

    radius: T.Radii.pill(height)

    data: [
        Rectangle {
            id: background
            anchors.fill: parent
            color: "white"
            width: root.width
            height: root.height
            radius: root.radius
        },
        Item {
            id: content
            anchors.fill: parent
            anchors.leftMargin: root.horizontalPadding
            anchors.rightMargin: root.horizontalPadding
            anchors.topMargin: root.verticalPadding
            anchors.bottomMargin: root.verticalPadding
        }
    ]
}
