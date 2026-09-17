import QtQuick
import "../Singletons" as T

Rectangle {
    id: root
    property bool active: false
    property string surfaceName: "compactPill"
    readonly property var profile: T.SurfaceProfiles.forSurace(surfaceName)
    default property alias contentData: content.data
    readonly property alias contentItem: content
    property real preferredContentHeight: 0
    property real horizontalPadding: profile.horizontalPadding
    property real verticalPadding: profile.verticalPadding
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
