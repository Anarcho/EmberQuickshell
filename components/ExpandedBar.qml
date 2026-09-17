import QtQuick
import QtQuick.Layouts
import "../Singletons" as T
import "../components"

RowLayout {
    id: root
    spacing: T.Spacing.md

    Rectangle {
        Layout.preferredWidth: 214
        Layout.preferredHeight: 76
        color: "#F19A5b"
    }
}
