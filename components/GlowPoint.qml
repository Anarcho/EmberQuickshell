import QtQuick
import "../Singletons" as T

Canvas {
    id: root
    property color glowColor: T.Colors.emberGlow
    property color coreColor: T.Colors.emberCore

    property real haloHeightRatio: 1
    property real haloDarkness: 1
    property real haloStrength: 1

    property real strength: 1
    property real coreRadius: 2.5

    implicitWidth: 36
    implicitHeight: width

    onGlowColorChanged: requestPaint()
    onCoreColorChanged: requestPaint()

    onHaloHeightRatioChanged: requestPaint()
    onHaloDarknessChanged: requestPaint()
    onHaloStrengthChanged: requestPaint()

    onCoreRadiusChanged: requestPaint()

    onWidthChanged: requestPaint()
    onHeightChanged: requestPaint()

    onPaint: {
        const ctx = getContext("2d");

        ctx.reset();

        const r = Math.min(width, height) / 2;
        if (r <= 0)
            return;

        const haloColor = Qt.darker(glowColor, Math.max(1, haloDarkness));

        ctx.save();
        ctx.translate(width / 2, height / 2);
        ctx.scale(1, Math.max(0.1, haloHeightRatio));
        ctx.translate(-width / 2, -height / 2);

        const halo = ctx.createRadialGradient(width / 2, height / 2, 0, width / 2, height / 2, r);

        halo.addColorStop(0, Qt.alpha(haloColor, 0.8));
        halo.addColorStop(0.22, Qt.alpha(haloColor, 0.45));
        halo.addColorStop(0.50, Qt.alpha(Qt.darker(haloColor, 1.55), 0.18));
        halo.addColorStop(1, Qt.alpha(Qt.darker(haloColor, 1.8), 0));
        ctx.globalAlpha = Math.max(0, Math.min(1, strength * haloStrength));
        ctx.fillStyle = halo;
        ctx.fillRect(0, 0, width, height);
        ctx.restore();
        ctx.globalAlpha = Math.max(0, Math.min(1, strength));

        const core = Math.min(r, coreRadius);

        if (core > 0) {
            const light = ctx.createRadialGradient(width / 2, height / 2, 0, width / 2, height / 2, core);
            light.addColorStop(0, coreColor);
            light.addColorStop(0.45, Qt.tint(coreColor, Qt.alpha(glowColor, 0.12)));
            light.addColorStop(0.8, Qt.tint(coreColor, Qt.alpha(glowColor, 0.30)));
            light.addColorStop(1, Qt.alpha(glowColor, 0.55));
            ctx.fillStyle = light;
            ctx.beginPath();
            ctx.arc(width / 2, height / 2, core, 0, Math.PI * 2);
            ctx.fill();
        }
    }
}
