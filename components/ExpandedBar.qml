import QtQuick
import QtQuick.Layouts
import "../Singletons" as T
import "../components"

RowLayout {
    id: root
    readonly property string dateText: T.Clock.dateLabel
    property real layoutHeight: 0
    property real layoutPreferredWidth: 0
    property real inset: 0

    spacing: T.Spacing.md
    anchors.margins: 5
    Layout.preferredHeight: root.layoutHeight - root.inset * 2
    Layout.preferredWidth: root.layoutPreferredWidth - root.inset * 2

    Rectangle {
        Layout.fillWidth: true
        Layout.fillHeight: true

        color: "#F19A5b"

        ColumnLayout {
            id: expandedLayout
            anchors.centerIn: parent
        }
    }
}
