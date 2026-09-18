pragma Singleton

import QtQuick
import Quickshell

Singleton {
    readonly property int announcementMs: 1400
    property int unloadMs: 30000
    property bool debugMode: true
    property var workspaceSlots: ({
            "HDMI-A-1": [1, 2, 3, 4]
        })
}
