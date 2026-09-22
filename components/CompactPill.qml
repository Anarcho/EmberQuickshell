import QtQuick
import QtQuick.Layouts
import "../Singletons" as T

RowLayout {
    id: root
    property string dateText: T.Clock.dateLabel
    property string timeText: T.Clock.timeLabel

    property real compactPillPreferredHeight: T.Dimensions.compactPillHeight - T.SurfaceMetrics.compactInset * 2
    property real compactPillPreferredWidth: T.Dimensions.compactPillPreferredWidth - T.SurfaceMetrics.compactInset * 2

    property string wifiGlyph: "wifi"
    property bool wifiActive: false

    property bool audioActive: false
    property string audioGlyph: "volume"

    property bool powerActive: false
    property string batteryGlyph: "battery-charging"

    Layout.preferredHeight: root.compactPillPreferredHeight
    Layout.preferredWidth: root.compactPillPreferredWidth

    spacing: T.Spacing.sm

    EmberAbstractButton {
        id: emblemButton
        profileName: "compactPill"
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
        profileName: "compactPill"
        Layout.maximumWidth: T.Dimensions.compactClockWidth
        Layout.minimumWidth: T.Dimensions.compactClockWidth
        Layout.preferredHeight: root.compactPillPreferredHeight
        Layout.preferredWidth: T.Dimensions.compactClockWidth
        focusPolicy: Qt.StrongFocus

        contentItem: Item {
            ClockDisplay {
                anchors.centerIn: parent
                dateText: root.dateText
                timeText: root.timeText
            }
        }
    }

    GlyphButton {
        accessibilityName: "Wi-Fi"
        active: root.wifiActive
        glyph: root.wifiGlyph
        glyphColor: Qt.alpha(T.Colors.text, 0.88)
        glyphSize: 21.5
        visualSize: 40.5
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
        glyphSize: 21.5
        illuminated: false
        softWell: true
        visualSize: 40.5
        wellBorderOpacity: 0.04
    }

    GlyphButton {
        Layout.leftMargin: 6
        Layout.rightMargin: 20
        accessibilityName: "Power"
        active: root.powerActive
        glyph: root.batteryGlyph
        glyphColor: Qt.alpha(T.Colors.text, 0.88)
        glyphSize: 21.5
        illuminated: false
        softWell: true
        visualSize: 40.5
        wellBorderOpacity: 0.04
    }
}
