import QtQuick
import QtQuick.Shapes
import "../Singletons" as T

Item {
    id: root
    property string name: ""

    property color color: T.Colors.textMuted
    property real stroke: T.Strokes.icon

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
            }
        })

    // unknown names render nothing
    readonly property var glyph: glyphs[name] !== undefined ? glyphs[name] : ({
            d: "",
            fill: false
        })

    Shape {
        id: vector
        width: 24
        height: 24

        scale: root.unit
        transformOrigin: Item.TopLeft

        x: vector.boundingRect.width > 0 ? root.width / 2 - (vector.boundingRect.x + vector.boundingRect.width / 2) * root.unit : (root.height * root.unit) / 2
        y: vector.boundingRect.height > 0 ? root.height / 2 - (vector.boundingRect.y + vector.boundingRect.height / 2) * root.unit : (root.height - 24 * root.unit) / 2

        layer.enabled: root.glyph.d !== ""
        antialiasing: true
        preferredRendererType: Shape.CurveRenderer

        ShapePath {
            strokeColor: "transparent"
            strokeWidth: root.stroke
            capStyle: ShapePath.RoundCap
            joinStyle: ShapePath.RoundJoin

            PathSvg {
                path: root.glyph.d
            }
        }
    }
}
