import QtQuick
import QtQuick.Layouts
import "../Singletons" as T
import "../components"

PillSurface {
    id: root

    CompactPill {
        id: compactPill
        layoutHeight: root.profile.height
        inset: root.profile.verticalPadding
    }
}
