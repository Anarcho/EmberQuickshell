import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../Singletons" as T

AbstractButton {
    id: root
    property string accessibilityName
    property string profileName: "compactPill"
    property var profile: T.SurfaceProfiles.forSurface(profileName)
    property color borderColor: root.visualFocus ? T.Colors.accent : "transparent"
    property real borderStrokeWidth: T.Strokes.focus
    property color backgroundColor: "transparent"
    property real backgroundRadius: Math.min(width, height) / 2

    Layout.preferredHeight: profile.emblemHeight
    Layout.preferredWidth: profile.emblemWidth
    focusPolicy: Qt.StrongFocus
    Accessible.name: accessibilityName

    background: Rectangle {
        border.color: root.borderColor
        border.width: root.borderStrokeWidth
        color: root.backgroundColor
        radius: root.backgroundRadius
    }
}
