import QtQuick
import "../Singletons" as T

Rectangle {
    id: root
    property bool active: false
    property var profile
    required property string screenName
    default property alias contentData: content.data
    readonly property alias contentItem: content
    property real preferredContentHeight: 0
    property real horizontalPadding: profile.horizontalPadding
    property real verticalPadding: profile.verticalPadding
    color: "transparent"

    // TODO: add to profiles
    property point activeReflectionPoint: Qt.point(width / 2, height)
    property rect backdropRect: Qt.rect(0, 0, width, height)
    property Item backdropSource: null
    property real glassAmount: 0.70
    property real rimWidth: T.SurfaceMetrics.rimWidth

    radius: T.Radii.pill(root.height)

    data: [
        GlassMaterial {
            active: root.active
            anchors.fill: parent
            activeReflectionPoint: root.activeReflectionPoint
            backdropRect: root.backdropRect
            backdropSource: root.backdropSource
            glassAmount: root.glassAmount
            radius: root.radius
            rimWidth: root.rimWidth
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
