import QtQuick
import QtQuick.Controls
import "../Singletons" as T

AbstractButton {
    id: root
    property bool active: true
    property string accessibilityName
    property bool enabledVisual: true

    property bool illuminated: active
    property bool softWell: false

    property string glyph
    property real glyphSize: T.Dimensions.iconMedium
    property color glyphColor: active ? (T.Colors.light ? T.Colors.emberTrail : T.Colors.emberHot) : T.Colors.text
    property real visualSize: T.Dimensions.iconButtonVisual

    property string toolTipDisplayText

    property real wellBorderOpacity: 0.08
    property real wellOpacity: 1

    Accessible.name: accessibilityName

    enabled: enabledVisual
    focusPolicy: Qt.StrongFocus
    hoverEnabled: true
    ToolTip.delay: 600
    ToolTip.text: toolTipDisplayText || toolTipDisplayText !== "" ? toolTipDisplayText : accessibilityName

    implicitHeight: implicitWidth
    implicitWidth: Math.max(T.Dimensions.iconButtonHit, visualSize)
    opacity: enabled ? 1 : T.Opacity.disabled

    background: Item {
        ControlWell {
            active: root.active
            anchors.centerIn: parent

            height: width
            hovered: root.hovered
            opacity: root.hovered || root.down ? 1 : root.wellOpacity
            scale: root.down ? 0.96 : 1
            soft: root.softWell
            width: root.visualSize

            border.color: Qt.alpha(T.Colors.text, root.wellBorderOpacity)
        }

        Behavior on scale {
            enabled: T.Motion.enabled
            NumberAnimation {
                duration: T.Motion.fast
                easing.type: T.Motion.easeOut
            }
        }
    }

    Rectangle {
        anchors.fill: parent
        border.color: T.Colors.controlAccent
        border.width: T.Strokes.focus
        color: "transparent"
        radius: width / 2
        visible: root.visualFocus
    }

    contentItem: Item {
        GlyphIcons {
            anchors.centerIn: parent
            name: root.glyph
            height: root.glyphSize
            color: root.glyphColor
            sunset: root.illuminated
            restrainedGlow: true
            width: root.glyphSize
        }
    }
}
