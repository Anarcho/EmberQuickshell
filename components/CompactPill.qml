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
        EmberMark {
            id: mark
        }
    }
}
