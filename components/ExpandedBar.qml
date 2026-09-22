import QtQuick
import QtQuick.Layouts
import "../Singletons" as T

RowLayout {
    id: root
    required property var profile
    readonly property string dateText: T.Clock.dateLabel

    spacing: T.Spacing.xxs

    Layout.preferredHeight: root.profile.contentHeight
    Layout.preferredWidth: root.profile.preferredWidth

    Rectangle {
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.margins: 10

        radius: root.height / 2

        color: "#F19A5b"

        ColumnLayout {
            id: expandedLayout
            anchors.centerIn: parent
        }
    }
}
