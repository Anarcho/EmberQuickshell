import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../Singletons" as T

AbstractButton {
    id: root
    property string accessibilityName
    property string profileName: "compactPill"
    property var profile: T.SurfaceProfiles.forSurface(profileName)

    Layout.preferredHeight: profile.emblemHeight
    Layout.preferredWidth: profile.emblemWidth
    focusPolicy: Qt.StrongFocus
    Accessible.name: accessibilityName

    background: Rectangle {
        border.color: root.visualFocus ? T.Colors.accent : "transparent"
        border.width: T.Strokes.focus
        color: "transparent"
        radius: Math.min(width, height) / 2
    }
}
