import QtQuick
import "../Singletons" as T

Rectangle {
    id: root
    property bool active: false
    property bool soft: false
    color: "transparent"

    border.color: Qt.alpha(T.Colors.text, 0.08)
    border.width: T.Strokes.hairline

    implicitHeight: implicitWidth
    implicitWidth: T.Dimensions.iconButtonVisual
    radius: Math.min(width, height) / 2

    gradient: Gradient {
        GradientStop {
            color: Qt.alpha(T.Colors.wellTop, root.soft ? 0.65 : 0.55)
            position: 0
        }

        GradientStop {
            color: Qt.alpha(T.Colors.wellBottom, root.soft ? 0.65 : 0.40)
            position: 1
        }
    }

    Rectangle {
        anchors.fill: parent
        anchors.margins: 1
        radius: root.radius - 1
        visible: root.soft
        gradient: Gradient {
            GradientStop {
                color: Qt.alpha(T.Colors.glassCoolReflection, 0.045)
                position: 0
            }
            GradientStop {
                color: Qt.alpha(T.Colors.glassCoolReflection, 0.012)
                position: 0.28
            }
            GradientStop {
                color: "transparent"
                position: 0.7
            }
            GradientStop {
                color: Qt.alpha(T.Colors.glassTrench, 0.10)
                position: 1
            }
        }
    }
    Rectangle {
        anchors.fill: parent
        color: root.pressed ? T.Colors.surfacePressed : T.Colors.surfaceHover
        opacity: root.hovered || root.pressed ? 1 : 0
        radius: root.radius

        Behavior on opacity {
            enabled: T.Motion.enabled
            NumberAnimation {
                duration: T.Motion.fast
            }
        }
    }
}
