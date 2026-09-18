pragma Singleton
import QtQuick

QtObject {
    property string familyUi: "sans-serif"
    property string familyDisplay: "serif"

    readonly property int caption: 10
    readonly property int label: 11
    readonly property int body: 13
    readonly property int bodyLarge: 15
    readonly property int valueSmall: 18
    readonly property int value: 24
    readonly property int valueLarge: 30
    readonly property int title: 20
    readonly property int titleLarge: 26

    readonly property int regular: Font.Normal
    readonly property int medium: Font.Medium
    readonly property int semibold: Font.DemiBold
    readonly property int bold: Font.Bold
}
