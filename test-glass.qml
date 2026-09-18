import QtQuick
import QtQuick.Effects
import Quickshell
import "Singletons" as T

FloatingWindow {
    id: root
    implicitWidth: 500
    implicitHeight: 350
    visible: true
    color: "#202630"
    property real radius: height / 2

    Rectangle {
        id: backdrop
        anchors.fill: parent
        color: "#202630"
        Text {
            anchors.centerIn: parent
            text: "BACKGROUND"
            font.pixelSize: 48
            color: "#e0e8ff"
        }
    }

    ShaderEffectSource {
        id: capture
        anchors.fill: glass
        sourceItem: backdrop
        sourceRect: Qt.rect(glass.x, glass.y, glass.width, glass.height)
        visible: false
    }

    MultiEffect {
        id: blurred
        anchors.fill: glass
        layer.enabled: true
        source: capture

        blurEnabled: true
        blur: 0.6
        blurMax: 32
        autoPaddingEnabled: false
        visible: false
    }
    ShaderEffect {
        anchors.fill: glass
        property var source: blurred
        property real cornerRadius: root.radius
        property real edgeDepth: 6
        property real refractionStrength: 2

        property size surfaceSize: Qt.size(width, height)
        fragmentShader: Qt.resolvedUrl('effects/glass.frag.qsb')
    }

    Canvas {
        id: glass
        visible: false
        width: 300
        height: 100
        anchors.centerIn: parent

        property real cornerRadius: 25
        property color glassColor: "#667e9c"

        onPaint: {
            const ctx = getContext("2d");
            ctx.reset();

            const w = width;
            const h = height;
            const r = cornerRadius;

            ctx.beginPath();
            ctx.roundedRect(0, 0, w, h, r, r);
            ctx.closePath();

            ctx.fillStyle = glassColor;
            ctx.globalAlpha = 0.45;
            ctx.fill();

            ctx.globalAlpha = 1.0;
            ctx.strokeStyle = "#a6c5df";
            ctx.lineWidth = 1;
            ctx.stroke();
        }

        onGlassColorChanged: requestPaint()
        onCornerRadiusChanged: requestPaint()
    }
}
