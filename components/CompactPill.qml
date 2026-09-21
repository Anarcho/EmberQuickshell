import QtQuick
import QtQuick.Layouts
import "../Singletons" as T

RowLayout {
    id: root
    property string dateText: T.Clock.dateLabel
    property string timeText: T.Clock.timeLabel

    Layout.preferredHeight: T.Dimensions.compactPillHeight - T.SurfaceMetrics.compactInset * 2
    Layout.preferredWidth: T.Dimensions.compactPillPreferredWidth - T.SurfaceMetrics.compactInset * 2

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
        Layout.preferredHeight: root.preferredHeight
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
}
