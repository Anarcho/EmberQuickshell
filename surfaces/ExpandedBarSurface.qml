import QtQuick
import QtQuick.Layouts
import "../Singletons" as T
import "../components"

PillSurface {
    id: root
    required property string screenName
    profileName: "expandedBar"
    content: expandedBarContent

    Component.onCompleted: {
        if (T.Flags.debugMode)
            console.log("Expanded Bar surface view created");
    }

    Component.onDestruction: {
        if (T.Flags.debugMode)
            console.log("Expanded Bar surface view destroyed");
    }
    ExpandedBar {
        id: expandedBarContent
        screenName: root.screenName
        profile: root.profile
        Layout.fillWidth: true
        Layout.fillHeight: true
    }
}
