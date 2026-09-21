pragma Singleton
import QtQuick

QtObject {
    function forSurface(name) {
        switch (name) {
        case "expandedBar":
            return {
                horizontalPadding: SurfaceMetrics.expandedInsetHorizontal,
                verticalPadding: SurfaceMetrics.expandedInsetVertical,
                height: Dimensions.expandedBarHeight,
                minimumWidth: Dimensions.expandedBarMinWidth,
                preferredWidth: Dimensions.expandedBarPreferredWidth,
                emblemHeight: Dimensions.emblemSize,
                emblemWidth: Dimensions.emblemWidth
            };
        default:
            return {
                horizontalPadding: SurfaceMetrics.compactInset,
                verticalPadding: SurfaceMetrics.compactInset,
                height: Dimensions.compactPillHeight,
                minimumWidth: Dimensions.compactPillMinWidth,
                preferredWidth: Dimensions.compactPillPreferredWidth,
                emblemHeight: Dimensions.compactEmblemHeight,
                emblemWidth: Dimensions.compactEmblemWidth
            };
        }
    }
}
