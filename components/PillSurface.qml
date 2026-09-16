import QtQuick
import QtQuick.Layouts
import "../Singletons" as T

Item {
    id: root
    default property alias content: column.data
    property bool open: false
    property bool reveal: false

    signal requestClose

    implicitWidth: column.implicitWidth
    implicitHeight: column.implicitHeight
    enabled: open && reveal
    opacity: opacity && reveal ? 1 : 0
    visible: opacity > 0

    data: [
        ColumnLayout {
            id: column
            anchors.centerIn: parent
            width: implicitWidth
            height: implicitHeight
            spacing: T.Spacing.md
        }
    ]
}
