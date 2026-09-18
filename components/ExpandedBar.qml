import QtQuick
import QtQuick.Layouts
import "../Singletons" as T
import "../components"

RowLayout {
    id: root
    readonly property string dateText: T.Clock.dateLabel
    spacing: T.Spacing.xxs

    Rectangle {
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.margins: 10
        implicitHeight: expandedLayout.implicitHeight
        implicitWidth: expandedLayout.implicitWidth
        radius: root.height / 2

        color: "#F19A5b"

        ColumnLayout {
            id: expandedLayout
            anchors.centerIn: parent
        }
    }
}
