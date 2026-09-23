pragma Singleton
import QtQuick

QtObject {
    readonly property int xs: 0
    readonly property int sm: 12
    readonly property int md: 18
    readonly property int lg: 24
    readonly property int xl: 28

    function pill(height) {
        return height / 2;
    }
}
