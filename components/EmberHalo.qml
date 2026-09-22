import QtQuick
import "../Singletons" as T

GlowPoint {
    property bool active: true
    width: 40
    height: width
    coreRadius: 0
    glowColor: T.Colors.fireHalo
    strength: active ? 0.85 : 0
}
