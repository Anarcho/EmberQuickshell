import QtQuick
import QtQuick.Layouts
import "../Singletons" as T
import "../components"

PillSurface {
    id: root
    profileName: "compactPill"
    content: compactContent

    Component.onCompleted: {
        if (T.Flags.debugMode)
            console.log("CompactPill surface view created");
    }

    Component.onDestruction: {
        if (T.Flags.debugMode)
            console.log("CompactPill surface view destroyed");
    }

    CompactPill {
        id: compactContent
        profile: root.profile
        Layout.fillWidth: true
        Layout.fillHeight: true
    }
}
