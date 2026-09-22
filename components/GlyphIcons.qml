import QtQuick
import QtQuick.Shapes
import "../Singletons" as T

Item {
    id: root
    property string name: ""

    property color color: T.Colors.textMuted
    property real stroke: T.Strokes.icon
    property bool sunset: true
    property bool restrainedGlow: false

    readonly property real unit: Math.min(width, height) / 24

    implicitWidth: T.Dimensions.iconMedium
    implicitHeight: implicitWidth

    readonly property var glyphs: ({
            "volume": {
                d: "M4 10v4h4l4.5 4V6L8 10z M16 9.2a4 4 0 0 1 0 5.6 M18.5 6.7a7.5 7.5 0 0 1 0 10.6",
                fill: false
            },
            "wifi": {
                d: "M3.5 8.5a12.6 12.6 0 0 1 17 0 M6.5 12a8.2 8.2 0 0 1 11 0 M9.5 15.5a3.9 3.9 0 0 1 5 0 M12 19.3h.01",
                fill: false
            },
            "battery-charging": {
                d: "M5 7h13a2 2 0 0 1 2 2v6a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V9a2 2 0 0 1 2-2z M20 10h2v4h-2 M12 8.8l-3 4h3l-1 3.2 4-4.8h-3z",
                fill: false
            }
        })

    // unknown names render nothing
    readonly property var glyph: glyphs[name] !== undefined ? glyphs[name] : ({
            d: "",
            fill: false
        })

    EmberHalo {
        anchors.centerIn: parent
        active: root.sunset && root.glyph.d !== ""
        width: root.restrainedGlow ? 28 : 40
        strength: active ? (root.restrainedGlow ? 0.18 : 0.85) : 0
    }

    readonly property color ink: root.sunset ? (T.Colors.light ? T.Colors.emberTrail : T.Colors.fireCore) : root.color

    Component {
        id: fullLight
        EmberLight {}
    }

    Component {
        id: buttonInk
        ShaderEffect {
            property var source
            property color highlight: T.Colors.light ? T.Colors.emberTrail : T.Colors.text
            property color warmth: T.Colors.light ? T.Colors.emberTrail : T.Colors.emberGlow
            fragmentShader: Qt.resolvedUrl("../effects/glyph-ink.frag.qsb")
            layer.enabled: true
            layer.effect: EmberLight {
                shadowBlur: 0.4
                shadowOpacity: 0.55
            }
        }
    }

    Shape {
        id: vector
        width: 24
        height: 24
        scale: root.unit

        transformOrigin: Item.TopLeft

        x: vector.boundingRect.width > 0 ? root.width / 2 - (vector.boundingRect.x + vector.boundingRect.width / 2) * root.unit : (root.height * root.unit) / 2
        y: vector.boundingRect.height > 0 ? root.height / 2 - (vector.boundingRect.y + vector.boundingRect.height / 2) * root.unit : (root.height - 24 * root.unit) / 2

        layer.enabled: root.sunset && root.glyph.d !== ""
        layer.effect: root.restrainedGlow ? buttonInk : fullLight
        antialiasing: true
        preferredRendererType: Shape.CurveRenderer

        ShapePath {
            strokeColor: root.glyph.fill ? "transparent" : root.ink
            fillColor: root.glyph.fill ? root.ink : "transparent"
            strokeWidth: root.stroke
            capStyle: ShapePath.RoundCap
            joinStyle: ShapePath.RoundJoin

            PathSvg {
                path: root.glyph.d
            }
        }
    }
}
