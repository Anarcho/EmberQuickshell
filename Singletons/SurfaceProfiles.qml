pragma Singleton
import QtQuick

QtObject {
    readonly property QtObject compactPill: QtObject {
        readonly property real height: Dimensions.compactPillHeight
        readonly property real minimumWidth: Dimensions.compactPillMinWidth
        readonly property real preferredWidth: Dimensions.compactPillPreferredWidth

        readonly property real horizontalPadding: SurfaceMetrics.compactInset
        readonly property real verticalPadding: SurfaceMetrics.compactInset

        readonly property real surfaceRadius: Radii.pill(height)

        readonly property real contentHeight: Math.max(0, height - verticalPadding * 2)
        readonly property real minimumContentWidth: Math.max(0, minimumWidth - horizontalPadding * 2)
        readonly property real preferredContentWidth: Math.max(0, preferredWidth - horizontalPadding * 2)

        readonly property real emblemHeightRatio: 1
        readonly property real emblemAspectRatio: 76 / 60
        readonly property real emblemHeight: contentHeight * emblemHeightRatio
        readonly property real emblemWidth: emblemHeight * emblemAspectRatio

        readonly property real iconHitRatio: 42 / 60
        readonly property real iconVisualRatio: 40.5 / 60
        readonly property real glyphRatio: 21.5 / 40.5
        readonly property real iconHitSize: contentHeight * iconHitRatio
        readonly property real iconVisualSize: contentHeight * iconVisualRatio
        readonly property real glyphSize: iconVisualSize * glyphRatio

        readonly property real clockWidthRatio: 92 / 60
        readonly property real clockWidth: contentHeight * clockWidthRatio
        readonly property real dividerHeightRatio: 38 / 60
        readonly property real dividerHeight: contentHeight * dividerHeightRatio
    }
    readonly property QtObject expandedBar: QtObject {
        readonly property real height: Dimensions.expandedBarHeight
        readonly property real minimumWidth: Dimensions.expandedBarMinWidth
        readonly property real preferredWidth: Dimensions.expandedBarPreferredWidth

        readonly property real horizontalPadding: SurfaceMetrics.expandedInsetHorizontal
        readonly property real verticalPadding: SurfaceMetrics.expandedInsetVertical

        readonly property real surfaceRadius: Radii.md

        readonly property real contentHeight: Math.max(0, height - verticalPadding * 2)
        readonly property real minimumContentWidth: Math.max(0, minimumWidth - horizontalPadding * 2)
        readonly property real preferredContentWidth: Math.max(0, preferredWidth - horizontalPadding * 2)

        readonly property real emblemHeightRatio: 52 / 96
        readonly property real emblemAspectRatio: 68 / 52
        readonly property real emblemHeight: contentHeight * emblemHeightRatio
        readonly property real emblemWidth: emblemHeight * emblemAspectRatio

        readonly property real iconHitRatio: 42 / 96
        readonly property real iconVisualRatio: 38 / 96
        readonly property real glyphRatio: 20 / 38
        readonly property real iconHitSize: contentHeight * iconHitRatio
        readonly property real iconVisualSize: contentHeight * iconVisualRatio
        readonly property real glyphSize: iconVisualSize * glyphRatio
    }

    function forSurface(name): QtObject {
        switch (name) {
        case "expandedBar":
            return expandedBar;
        default:
            return compactPill;
        }
    }
}
