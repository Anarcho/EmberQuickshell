pragma Singleton
import QtQuick
import Quickshell

Singleton {

    readonly property string dateLabel: Qt.formatDateTime(ticker.date, "ddd d MMM")
    readonly property string timeLabel: Qt.formatDateTime(ticker.date, "HH:mm")

    SystemClock {
        id: ticker
        precision: SystemClock.Minutes
    }
}
