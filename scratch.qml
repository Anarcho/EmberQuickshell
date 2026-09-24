import QtQuick
import QtQuick.Layouts
import Quickshell
import "Singletons" as T
import "components" as C

PanelWindow {
    id: shell

    property string profileName: "compactPill"
    property var profile: T.SurfaceProfiles.forSurface(profileName)

    anchors {
        top: true
        left: true
        right: true
    }

    implicitHeight: content.implicitHeight + (T.Spacing.sm * 2)

    // Surface Frame
    Rectangle {
        id: surface
        anchors.centerIn: parent

        implicitWidth: content.implicitWidth
        implicitHeight: content.implicitHeight
        color: "transparent"

        // PillSurface
        Item {
            id: content
            anchors.fill: parent
            anchors.margins: 10
            implicitWidth: Math.max(shell.profile.minimumWidth, shell.profile.preferredWidth, content.implicitWidth + shell.profile.horizontalPadding * 2)
            implicitHeight: shell.profile.height

            ColumnLayout {
                id: column
                anchors.fill: parent
                spacing: T.Spacing.md
            }
        }
    }
}
