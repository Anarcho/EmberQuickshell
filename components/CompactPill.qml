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

    Layout.preferredHeight: root.compactPillPreferredHeight
    Layout.preferredWidth: root.compactPillPreferredWidth

    spacing: T.Spacing.sm

    EmberAbstractButton {
        id: emblemButton
        profileName: "compactPill"
        borderColor: root.visualFocus ? T.Colors.accent : "transparent"
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
        Layout.leftMargin: 6
        accessibilityName: "Wi-Fi"
        active: root.wifiGlyph
        glyph: root.wifiGlyph
        glyphSize: 21.5
        visualSize: 40.5
    }
}
