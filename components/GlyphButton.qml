import QtQuick
import QtQuick.Controls
import "../Singletons" as T

AbstractButton {
    id: root
    property string accessibilityName
    property bool active: true
    property string glyph
    property real glyphSize: T.Dimensions.iconMedium
    property color glyphColor: T.Colors.text
    property string toolTipDisplayText
    property real visualSize: T.Dimensions.iconButtonVisual
    property real wellOpacity: 1

    Accessible.name: accessibilityName
    ToolTip.delay: 600
    ToolTip.text: toolTipDisplayText || toolTipDisplayText !== "" ? toolTipDisplayText : accessibilityName

    implicitHeight: implicitWidth
    implicitWidth: Math.max(T.Dimensions.iconButtonHit, visualSize)

    background: Item {
        ControlWell {
            active: root.active
            anchors.centerIn: parent
            border.color: Qt.alpha(T.Colors.text, root.wellBorderOpacity)
            height: width
        }
    }

    Rectangle {
        anchors.fill: parent
        border.color: T.Colors.controlAccent
        border.width: T.Strokes.focus
    }

    contentItem: Item {
        GlyphIcons {
            anchors.centerIn: parent
            color: root.glyphColor
            height: root.glyphSize
            name: root.glyph
            width: root.glyphSize
        }
    }
}
