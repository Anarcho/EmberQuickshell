import QtQuick
import "../Singletons" as T

Item {
    id: root
    property string wsNumber
    property bool selected: false

    Rectangle {
        id: wsButton
        anchors.fill: parent
        anchors.margins: 10
        implicitWidth: label.implicitWidth + 10
        implicitHeight: label.implicitHeight + 10
        color: root.selected ? "red" : "yellow"

        Text {
            id: label
            anchors.centerIn: parent
            text: root.wsNumber
        }
    }
}
