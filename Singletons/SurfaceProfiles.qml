pragma Singleton
import QtQuick

QtObject {
    function forSurace(name) {
        switch (name) {
        case "expandedBar":
            return {
                horizontalPadding: SurfaceMetrics.expandedInsetHorizontal,
                expandedInsetVertical: SurfaceMetrics.expandedInsetVertical,
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
