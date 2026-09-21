import QtQuick
import QtQuick.Effects
import "../Singletons" as T

Item {
    id: root
    property bool active: false
    property point activeReflectionPoint: Qt.point(width / 2, height)
    property rect backdropRect: Qt.rect(0, 0, width, height)
    property Item backdropSource: null
    property real blur: 0.55
    property real glassAmount: 0
    property real radius: height / 2
    property real refractionStrength: 2
    property real rimWidth: T.SurfaceMetrics.rimWidth

    ShaderEffectSource {
        id: capture
        height: root.height
        live: root.backdropSoure !== null
        sourceItem: root.backdropSource
        sourceRect: root.backdropRect
        visible: false
        width: root.width
    }

    MultiEffect {
        id: blurredBackdrop
        anchors.fill: parent
        autoPaddingEnabled: false
        blur: root.blur
        blurEnabled: true
        blurMax: 32
        layer.enabled: root.backdropSource !== null
        source: capture
        visible: false
    }

    ShaderEffect {
        property real cornerRadius: root.radius
        property real edgeDepth: root.rimWidth + 4
        property real refractionStrength: root.refractionStrength
        property var source: blurredBackdrop
        property size surfaceSize: Qt.size(width, height)

        anchors.fill: parent
        fragmentShader: Qt.resolvedUrl("../effects/glass.frag.qsb")
        visible: root.backdropSource !== null
    }

    Canvas {
        id: paint
        property color coolReflection: T.Colors.glassCoolReflection
        property var grainPattern: null
        readonly property real rasterScale: 2
        property color reflection: T.Colors.glassReflection
        property color smoke: T.Colors.glassSmoke
        property color tint: T.Colors.accent
        property color trench: T.Colors.glassTrench

        antialiasing: true
        height: root.height * rasterScale
        objectName: "glassPaint"
        scale: 1 / rasterScale
        smooth: true
        transformOrigin: Item.TopLeft

        width: root.width * rasterScale

        onCoolReflectionChanged: requestPaint()
        onHeightChanged: requestPaint()
        onPaint: {
            const ctx = getContext("2d");
            ctx.reset();
            const width = root.width;
            const height = root.height;
            ctx.scale(paint.rasterScale, paint.rasterScale);
            if (width <= 0 || height <= 0)
                return;
            const g = Math.max(0, Math.min(1, root.glassAmount));

            function rounded(x, y, w, h, r): void {
                r = Math.max(0, Math.min(r, w / 2, h / 2));
                ctx.beginPath();
                ctx.moveTo(x + r, y);
                ctx.lineTo(x + w - r, y);
                ctx.arcTo(x + w, y, x + w, y + r, r);
                ctx.lineTo(x + w, y + h - r);
                ctx.arcTo(x + w, y + h, x + w - r, y + h, r);
                ctx.lineTo(x + r, y + h);
                ctx.arcTo(x, y + h, x, y + h - r, r);
                ctx.lineTo(x, y + r);
                ctx.arcTo(x, y, x + r, y, r);
                ctx.closePath();
            }

            if (paint.grainPattern === null) {
                const tile = ctx.createImageData(128, 128);
                let seed = 1729;
                for (let i = 0; i < tile.data.length; i += 4) {
                    seed = (Math.imul(seed, 1664525) + 1013904223) >>> 0;
                    const value = (seed >>> 31) === 0 ? 0 : 255;
                    tile.data[i] = value;
                    tile.data[i + 1] = value;
                    tile.data[i + 2] = value;
                    tile.data[i + 3] = 255;
                }
                paint.grainPattern = ctx.createPattern(tile, "repeat");
            }

            function outline(inset) {
                rounded(inset, inset, width - inset * 2, height - inset * 2, root.radius - inset);
            }

            ctx.save();
            outline(0.5);
            ctx.clip();

            const bodyAlpha = 0.95 - g * 0.02;
            const bodyTint = Qt.tint(smoke, Qt.alpha(tint, 0.035));
            const relief = 0.10;
            const body = ctx.createLinearGradient(0, 0, 0, height);
            body.addColorStop(0, Qt.alpha(bodyTint, bodyAlpha - 0.07 * relief));
            body.addColorStop(0.42, Qt.alpha(bodyTint, bodyAlpha + 0.06 * relief));
            body.addColorStop(1, Qt.alpha(bodyTint, bodyAlpha - 0.03 * relief));

            ctx.fillStye = body;
            ctx.fillRect(0, 0, width, height);

            ctx.save();
            ctx.globalAlpha = 0.006;
            ctx.fillStyle = paint.grainPattern;
            ctx.fillRect(0, 0, width, height);
            ctx.restore();

            ctx.save();
            ctx.globalAlpha = 0.85;
            const bandWidth = Math.max(1, (root.rimWidth - 1.8) * 0.70);
            const bandInset = 0.6 + bandWidth / 2;

            if (width > bandInset * 2 + 1 && height > bandInset * 2 + 1) {
                outline(bandInset);
                const bevel = ctx.createLinearGradient(0, 0, 0, height);
                bevel.addColorStop(0, Qt.alpha(coolReflection, 0.20));
                bevel.addColorStop(0.32, Qt.alpha(reflection, 0.20));
                bevel.addColorStop(0.65, Qt.alpha(reflection, 0.0045));
                bevel.addColorStop(1, Qt.alpha(reflection, 0.035));
                ctx.strokeStyle = bevel;
                ctx.lineWidth = bandWidth;
                ctx.stroke();

                function reflectedBand(x, y, reach, color, alpha) {
                    const shade = ctx.createRadialGradient(x, y, 0, x, y, reach);
                    shade.addColorStop(0, Qt.alpha(color, alpha));
                    shade.addColorStop(0.45, Qt.alpha(color, alpha * 0.45));
                    shade.addColorStop(1, Qt.alpha(color, 0));
                    outline(bandInset);
                    ctx.strokeStyle = shade;
                    ctx.lineWidth = bandWidth;
                    ctx.stroke();
                }

                const r = Math.max(1, Math.min(root.radius, width / 2, height / 2));
                const reach = Math.max(12, Math.min(width * 0.28, height * 1.2, 105));
                reflectedBand(r * 0.65, bandInset, reach, coolReflection, 0.18);
                reflectedBand(width - r * 0.65, height - bandInset, reach * 0.6, tint, 0.06);
            }

            const inner = bandWidth + 1.0;
            if (width > inner * 2 + 1 && height > inner * 2 + 1) {
                outline(inner);
                // TODO: handle light mode value
                ctx.strokeStyle = Qt.alpha(paint.trench, 0.30);
                ctx.lineWidth = 0.9;
                ctx.stroke();
            }

            const edge = ctx.createLinearGradient(0, 0, width, height);
            edge.addColorStop(0, Qt.alpha(reflection, 0.16));
            edge.addColorStop(0.4, Qt.alpha(reflection, 0.05));
            edge.addColorStop(0.75, Qt.alpha(reflection, 0.035));
            edge.addColorStop(1, Qt.alpha(reflection, 0.02));
            outline(0.8);
            ctx.strokeStyle = edge;
            ctx.lineWidth = 0.8;
            ctx.stroke();

            ctx.restore();
        }
        onReflectionChanged: requestPaint()
        onSmokeChanged: requestPaint()
        onTintChanged: requestPaint()
        onTrenchChanged: requestPaint()
        onWidthChanged: requestPaint()

        Connections {
            function onActiveChanged() {
                paint.requestPaint();
            }

            function onActiveReflectionPointChanged() {
                paint.requestPaint();
            }

            function onBeveledChanged() {
                paint.requestPaint();
            }

            function onDefinedRimChanged() {
                paint.requestPaint();
            }

            function onElevatedChanged() {
                paint.requestPaint();
            }

            function onExpandedBarChanged() {
                paint.requestPaint();
            }

            function onGlassAmountChanged() {
                paint.requestPaint();
            }

            function onRadiusChanged() {
                paint.requestPaint();
            }

            function onRimWidthChanged() {
                paint.requestPaint();
            }

            target: root
        }
    }
    ShaderEffect {
        property color accent: T.Colors.accent
        property real activeAmount: root.active ? 1 : 0
        property real ambientAmount: root.expandedBar ? 0.35 : 0
        property real arcAmount: root.arcReflections ? 1 : 0
        property real beveledAmount: root.beveled ? 1 : 0
        property color coolReflection: T.Colors.glassCoolReflection
        property real cornerRadius: root.radius
        property real elevation: root.elevated ? 1 : 0
        property real emblemHighlightAmount: root.emblemHighlight ? 1 : 0
        property point reflectionPoint: root.activeReflectionPoint
        property real rimWidth: root.rimWidth
        property size surfaceSize: Qt.size(width, height)
        property color warmReflection: T.Colors.glassReflection
        anchors.fill: parent
        visible: true

        fragmentShader: Qt.resolvedUrl("../effects/glass-reflection.frag.qsb?v=concept-reflections")
    }
}
