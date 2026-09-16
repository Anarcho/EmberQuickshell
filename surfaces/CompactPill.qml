import QtQuick
import QtQuick.Layouts
import "../Singletons" as T
import "../components"

PillSurface {
    id: root

    RowLayout {
        Layout.preferredHeight: T.Dimensions.compactPillHeight - T.SurfaceMetrics.compactInset * 2
        Layout.preferredWidth: T.Dimensions.compactPillPreferredWidth - T.SurfaceMetrics.compactInset * 2
        spacing: T.Spacing.sm

        Rectangle {
            border.color: "#F19A5B"
            border.width: 2
            color: "transparent"
            radius: Math.min(width, height / 2)
        }
    }
}
