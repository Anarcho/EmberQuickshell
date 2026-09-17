pragma Singleton
import QtQuick

QtObject {
    function forSurface(name) {
        switch (name) {
        case "expandedBar":
            return {
                horizontalPadding: SurfaceMetrics.expandedInsetHorizontal,
                verticalPadding: SurfaceMetrics.expandedInsetVertical,
                height: Dimensions.expandedBarHeight
            };
        default:
            return {
                horizontalPadding: SurfaceMetrics.compactInset,
                verticalPadding: SurfaceMetrics.compactInset,
                height: Dimensions.compactPillHeight
            };
        }
    }
}
