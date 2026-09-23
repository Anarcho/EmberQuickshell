import QtQuick
import QtQuick.Layouts
import "../Singletons" as T

RowLayout {
    id: root
    required property var profile

    property string dateText: T.Clock.dateLabel
    property string timeText: T.Clock.timeLabel

    property string wifiGlyph: "wifi"
    property bool wifiActive: false

    property bool audioActive: false
    property string audioGlyph: "volume"

    property bool powerActive: false
    property string batteryGlyph: "battery-charging"

    Layout.preferredHeight: root.profile.contentHeight
    Layout.preferredWidth: root.profile.preferredContentWidth

    spacing: T.Spacing.sm

    EmberAbstractButton {
        id: emblemButton
        Layout.preferredHeight: root.profile.emblemHeight
        Layout.preferredWidth: root.profile.emblemWidth

        borderColor: emblemButton.visualFocus ? T.Colors.accent : "transparent"
        borderStrokeWidth: T.Strokes.focus
        backgroundColor: "transparent"
        backgroundRadius: Math.min(width, height) / 2

        contentItem: EmberMark {
            expanded: false
        }
    }

    EmberAbstractButton {
        id: clockButton
        Layout.preferredHeight: root.profile.contentHeight
        Layout.preferredWidth: root.profile.clockWidth
        focusPolicy: Qt.StrongFocus

        contentItem: Item {
            ClockDisplay {
                anchors.centerIn: parent
                dateText: root.dateText
                timeText: root.timeText
            }
        }
    }

    Divider {
        Layout.preferredHeight: root.profile.dividerHeight
        Layout.preferredWidth: T.Strokes.hairline
    }

    GlyphButton {
        accessibilityName: "Wi-Fi"
        active: root.wifiActive
        glyph: root.wifiGlyph
        glyphColor: Qt.alpha(T.Colors.text, 0.88)
        glyphSize: root.profile.glyphSize
        visualSize: root.profile.iconVisualSize
        illuminated: false
        softWell: true
        wellBorderOpacity: 0.04
    }

    GlyphButton {
        Layout.leftMargin: 6
        accessibilityName: "Audio"
        active: root.audioActive
        glyph: root.audioGlyph
        glyphColor: Qt.alpha(T.Colors.text, 0.88)
        glyphSize: root.profile.glyphSize
        visualSize: root.profile.iconVisualSize
        illuminated: false
        softWell: true
        wellBorderOpacity: 0.04
    }

    GlyphButton {
        Layout.leftMargin: 6
        Layout.rightMargin: 20
        accessibilityName: "Power"
        active: root.powerActive
        glyph: root.batteryGlyph
        glyphColor: Qt.alpha(T.Colors.text, 0.88)
        glyphSize: root.profile.glyphSize
        visualSize: root.profile.iconVisualSize
        illuminated: false
        softWell: true
        wellBorderOpacity: 0.04
    }
}
