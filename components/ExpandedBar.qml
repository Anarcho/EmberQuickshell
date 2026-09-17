import QtQuick
import QtQuick.Layouts
import "../Singletons" as T
import "../components"

RowLayout {
    id: root
    spacing: T.Spacing.md
    anchors.margins: 5

    Rectangle {
        Layout.preferredHeight: 76
        Layout.preferredWidth: 214

        Layout.fillWidth: true
        Layout.fillHeight: true

        color: "#F19A5b"

        ColumnLayout {
            id: expandedLayout
            anchors.centerIn: parent
        }
    }
}
