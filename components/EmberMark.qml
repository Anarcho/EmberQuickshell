import QtQuick
import QtQuick.Shapes
import "../Singletons" as T

Item {
    id: root

    property bool expanded: false
    // TODO: currently only covers expanded bar or compact pill. need better handling
    // TODO: need more handling of values through config singletons
    property real arcValue: expanded ? 0.50 : 0.34

    implicitHeight: T.Dimensions.emblemSize
    implicitWidth: T.Dimensions.emblemWidth

    Canvas {
        id: outlineArc
        property bool expanded: root.expanded
        property color core: T.Colors.fireCore
        property color gold: T.Colors.fireGold
        property color low: T.Colors.fireLow
        property color orange: Qt.tint(T.Colors.fireOrange, Qt.alpha(T.Colors.glassReflection, 0.22))
        property real progress: root.arcValue
        readonly property real rasterScale: 2

        antialiasing: true
        height: root.height * rasterScale
        opacity: 0.78
        scale: 1 / rasterScale
        transformOrigin: Item.TopLeft
        visible: true
        width: root.width * rasterScale

        Behavior on progress {
            enabled: T.Motion.enabled && outlineArc.visible
            NumberAnimation {
                duration: T.Motion.normal
                easing.type: T.Motion.easeOut
            }
        }

        onPaint: {
            const ctx = getContext("2d");
            ctx.reset();
            ctx.scale(rasterScale, rasterScale);

            const inset = 2;

            const w = root.width - inset * 2;
        }
    }
}
