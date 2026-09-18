import QtQuick
import QtQuick.Layouts
import "../Singletons" as T

Item {
    id: root
    property string profileName: "compactPill"
    readonly property var profile: T.SurfaceProfiles.forSurface(profileName)
    property Item contentItem
    default property alias content: column.data
    property bool open: false
    property bool reveal: false

    signal requestClose

    implicitWidth: Math.max(profile.minimumWidth, profile.preferredWidth, column.implicitWidth + profile.horizontalPadding * 2)
    implicitHeight: profile.height
    enabled: open && reveal
    //opacity: open && reveal ? 1 : 0
    //visible: opacity > 0

    data: [
        ColumnLayout {
            id: column
            anchors.fill: parent
            spacing: T.Spacing.md
        }
    ]

    Behavior on opacity {
        enabled: T.Motion.enabled
        NumberAnimation {
            duration: T.Motion.normal
            easing.type: T.Motion.easeOut
        }
    }
}
