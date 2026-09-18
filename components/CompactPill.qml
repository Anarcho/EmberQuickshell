import QtQuick
import QtQuick.Layouts
import "../Singletons" as T
import "../components"

RowLayout {
    id: root
    readonly property string dateText: T.Clock.dateLabel
    spacing: T.Spacing.sm

    Rectangle {
        Layout.fillWidth: true
        Layout.fillHeight: true
        implicitWidth: clock.implicitWidth
        implicitHeight: clock.implicitHeight
        ClockDisplay {
            id: clock
            dateText: root.dateText
        }
    }
    Rectangle {
        Layout.fillWidth: true
        Layout.fillHeight: true
        implicitWidth: clock2.implicitWidth
        implicitHeight: clock2.implicitHeight
        ClockDisplay {
            id: clock2
            dateText: root.dateText
        }
    }
}
