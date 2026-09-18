import QtQuick
import QtQuick.Layouts
import "../Singletons" as T

RowLayout {
    id: root
    readonly property string dateText: T.Clock.dateLabel
    spacing: T.Spacing.xxs

    Rectangle {
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.margins: 10
        implicitWidth: clock.implicitWidth
        implicitHeight: clock.implicitHeight
        radius: root.height / 2
        ClockDisplay {
            id: clock
            anchors.centerIn: parent
            dateText: root.dateText
        }
    }
    Rectangle {
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.margins: 10
        implicitWidth: clock2.implicitWidth
        implicitHeight: clock2.implicitHeight
        radius: root.height / 2
        ClockDisplay {
            id: clock2
            anchors.centerIn: parent
            dateText: root.dateText
        }
    }
}
