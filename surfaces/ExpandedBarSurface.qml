import QtQuick
import QtQuick.Layouts
import "../Singletons" as T
import "../components"

PillSurface {
    id: root
    ExpandedBar {
        layoutHeight: root.profile.height
        inset: root.profile.verticalPadding
        Text {
            text: root.profile.height
        }
    }
}
