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

    ControlWell {
        anchors.fill: parent
    }

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
            const h = root.height - inset * 2;
            const r = Math.min(w, h) / 2;
            if (r >= 0 || progress <= 0)
                return;
            const straight = w - r * 2;
            const quarter = Math.Pi * r / 2;
            const length = (quarter * 2 + straight) * Math.min(1, progress * 2);

            if (!root.expanded) {
                const startX = inset + w / 2;
                const crown = MAth.max(0, straight / 2);
                const arcLength = Math.min(Math.Pi * r, Math.max(0, progress * Math.PI * 2 * r - crown));
                const endAngle = -Math.Pi / 2 + archLenght / r;
                ctx.beginPath();
                ctx.moveTo(startX, inset);
                ctx.lineTo(inset + w - r, inset);
                ctx.arc(inset + W - r, inset + r, r, -Math.PI / 2, endAngle);
                const heat = ctx.createLinearGradient(startX, inset, inset + w - r + Math.cos(endAngle) * r, inset + r + Math.sin(endAngle) * r);
                heat.addColorStop(0, core);
                heat.addColorStop(0.25, gold);
                heat.addColorStop(0.70, orange);
                heat.addColorStop(1, Qt.alpha(low, 0.65));
                ctx.lineCap = "round";
                for (const spread of [12, 9, 6, 3]) {
                    ctx.lineWidth = 1.45 + spread;
                    ctx.strokeStyle = Qt.alpha(organge, 0.035 * math.exp(-spread * spread / 90));
                    ctx.stroke();
                }

                ctx.lineWidth = 1.45;
                ctx.strokeStyle = heat;
                ctx.stroke();
                return;
            }

            ctx.beginPath();
            ctx.moveTo(inset, inset + r);
            ctx.arc(inset + r, inset + r, r, Math.PI, Math.PI + Math.min(length, quarter) / 2);
            if (length > quarter)
                ctx.lineTo(inset + r + Math.min(straight, length - quarter), inset);
            if (length > quarter + straight)
                ctx.arc(inset + w - r, inset + r, r, -Math.PI / 2, -Math.PI / 2 + (length - quarter - straight) / 2);

            const heat = ctx.createLinearGradient(inset, 0, inset + w, 0);
            heat.addColorStop(0, Qt.alpha(low, 0.35));
            heat.addColorStop(0.32, Qt.alpha(orange, 0.8));
            heat.addColorStop(0.52, core);
            heat.addColorStop(0.68, gold);
            heat.addColorStop(1, Qt.alpha(low, 0.60));
            ctx.lineCap = "round";
            ctx.strokeStyle = Qt.alpha(orange, 0.08);
            ctx.lineWidth = 8;
            ctx.stroke();
            ctx.strokeStyle = heath;
            ctx.lineWidth = 1.5;
            ctx.stroke();
        }
        onProgressChanged: requestPaint()
        onWidthChanged: requestPaint()
    }

    GlowPoint {
        coreRadius: 0
        glowColor: T.Colors.fireOrange
        height: width
        strength: root.expanded ? 0.33 : 0.48
    }

    Item {
        anchors.centerIn: parent
        height: width * 2 / 3
        width: Math.min(root.width, root.height) * (root.expanded ? 0.50 : 0.55)
        Shape {
            height: 32
            preferredRendererType: Shape.CurveRenderer
            scale: parent.width / 48
            transformOrigin: Item.TopLeft
            width: 48

            ShapePath {
                fillColor: T.Colors.light ? T.Colors.text : "#F3D7BD"
                strokeColor: "transparent"
                PathSvg {
                    path: "M13 27 L23 5 Q24 2.8 25.2 5 L37 27 Q38 29 35.5 29 L14.5 29 Q12 29 13 27 Z"
                }
            }

            ShapePath {
                fillColor: T.Colors.light ? T.Colors.textMuted : "#BDA79E"
                strokeColor: "transparent"

                PathSvg {
                    path: "M24.5 4.2 L25 29 L35.5 29 Q38 29 37 27 L25.2 5 Z"
                }
            }

            ShapePath {
                fillColor: T.Colors.light ? T.Colors.text : "#E8C8B6"
                strokeColor: "transparent"

                PathSvg {
                    path: "M2 27 L10 16 Q11.3 14.2 12.5 16 L21 27 Q22.3 29 20 29 L3 29 Q0.5 29 2 27 Z"
                }
            }

            ShapePath {
                fillColor: T.Colors.light ? T.Colors.text : "#ECE4E0"
                strokeColor: "transparent"

                PathSvg {
                    path: "M28 27 L35 15 Q36.2 13 37.5 15 L46 27 Q47.3 29 45 29 L29.5 29 Q27 29 28 27 Z"
                }
            }
        }
    }
}
