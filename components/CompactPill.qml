import QtQuick
import QtQuick.Layouts
import "../Singletons" as T

RowLayout {
    id: root
    readonly property string dateText: T.Clock.dateLabel

    Layout.preferredHeight: T.Dimensions.compactPillHeight - T.SurfaceMetrics.compactInset * 2
    Layout.preferredWidth: T.Dimensions.compactPillPreferredWidth - T.SurfaceMetrics.compactInset * 2

    spacing: T.Spacing.sm

    EmberAbstractButton {
        id: emblemButton
        profileName: "compactPill"

        contentItem: EmberMark {
            expanded: false
        }
    }
}
