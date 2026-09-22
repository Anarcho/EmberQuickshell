import QtQuick
import QtQuick.Controls
import "../Singletons" as T

AbstractButton {
    id: root
    property string accessibilityName
    property color borderColor: root.visualFocus ? T.Colors.accent : "transparent"
    property real borderStrokeWidth: T.Strokes.focus
    property color backgroundColor: "transparent"
    property real backgroundRadius: Math.min(width, height) / 2

    focusPolicy: Qt.StrongFocus
    Accessible.name: accessibilityName

    background: Rectangle {
        border.color: root.borderColor
        border.width: root.borderStrokeWidth
        color: root.backgroundColor
        radius: root.backgroundRadius
    }
}
