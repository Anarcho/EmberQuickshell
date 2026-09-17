import QtQuick
import QtQuick.Layouts
import "../Singletons" as T
import "../components"

PillSurface {
    id: root
    RowLayout {
        spacing: T.Spacing.sm

        Rectangle {
            id: testBox
            color: "#e76f51"
            Layout.fillWidth: true
            Layout.preferredHeight: T.Dimensions.compactPillHeight - T.SurfaceMetrics.compactInset * 2
            Layout.preferredWidth: T.Dimensions.compactPillPreferredWidth - T.SurfaceMetrics.compactInset * 2
        }
    }
}
