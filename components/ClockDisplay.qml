import QtQuick
import "../Singletons" as T

Item {
    id: root

    property string dateText: ""
    property bool expanded: false
    property string greetingText: ""
    readonly property real spacing: root.expanded ? 3 : T.Spacing.xxs
    property string timeText: ""

    implicitHeight: primaryLine.implicitHeight + spacing + secondaryLine.implicitHeight
    implicitWidth: Math.max(primaryLine.implicitWidth, secondaryLine.implicitWidth)

    Text {
        id: primaryLine

        color: root.expanded ? Qt.alpha(T.Colors.text, 0.90) : Qt.alpha(T.Colors.textMuted, 0.94)
        elide: Text.ElideRight
        font.family: T.Typography.familyUi
        font.pixelSize: root.expanded ? 14 : 11.5
        horizontalAlignment: root.expanded ? Text.AlignLeft : Text.AlignHCenter
        text: root.expanded ? root.greetingText : root.dateText
        width: parent.width
    }

    Text {
        id: secondaryLine

        color: root.expanded ? Qt.alpha(T.Colors.textMuted, 0.86) : Qt.alpha(T.Colors.text, 0.96)
        elide: Text.ElideRight
        font.family: T.Typography.familyUi
        font.pixelSize: root.expanded ? 10 : 21
        horizontalAlignment: root.expanded ? Text.AlignLeft : Text.AlignHCenter
        text: root.expanded ? root.dateText + "  " + root.timeText : root.timeText
        width: parent.width
        y: primaryLine.height + root.spacing
    }
}
