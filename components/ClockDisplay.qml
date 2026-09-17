import QtQuick
import "../Singletons" as T

Item {
    id: root
    property string dateText: ""
    property string timeText: ""
    readonly property real spacing: T.Spacing.md

    implicitHeight: primaryLine.implicitHeight + spacing
    implicitWidth: primaryLine.implicitWidth

    Text {
        id: primaryLine
        width: parent.width
        color: "black"
        elide: Text.ElideRight
        font.pixelSize: 14
        horizontalAlignment: Text.AlignHCenter
        text: root.dateText
    }
}
