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

    spacing: T.Spacing.sm
    Layout.preferredHeight: root.layoutHeight - root.inset * 2
    Layout.preferredWidth: root.layoutPreferredWidth - root.inset * 2

    Rectangle {
        implicitWidth: 214
        implicitHeight: 76
        ClockDisplay {
            id: clock
            dateText: root.dateText
        }
    }
}
