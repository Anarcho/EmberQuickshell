pragma Singleton
import QtQuick

QtObject {
    property bool enabled: true
    readonly property int instant: 0
    readonly property int fast: 100
    readonly property int normal: 180
    readonly property int slow: 280
    readonly property int morph: 260

    readonly property int contentDelay: 45

    readonly property int easeOut: Easing.OutCubic
    readonly property int easeIn: Easing.InCubic
    readonly property int easeInOut: Easing.InOutCubic
}
