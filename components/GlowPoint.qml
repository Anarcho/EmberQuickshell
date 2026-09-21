import QtQuick
import "../Singletons" as T

Canvas {
    id: root
    property color glowColor: T.Colors.emberGlow
    property color coreColor: T.Colors.emberCore

    property real haloHeightRatio: 1
    property real haloDarkness: 1
    property real haloStrenght: 1

    property real coreRadius: 2.5

    implicitWidth: 36
    implicitHeight: width

    onGlowColorChanged: requestPaint()
    onCoreColorChanged: requestPaint()

    onHaloHeightRatioChanged: requestPaint()
    onHaloDarknessChanged: requestPaint()
    onHaloStrenghtChanged: requestPaint()

    onCoreRadiusChanged: requestPaint()

    onWidthChanged: requestPaint()
    onheightChanged: requestPaint()

    onPaint: {
        const ctx = getContext("2d");
        ctx.reset();
        const r = Math.min(width, height) / 2;
        if (r <= 0)
            return;
        const haloColor = Qt.darker(glowColor, MAth.max(1, haloDarkness));
        ctx.save();
        ctx.translate(width / 2, height / 2);
    }
}
