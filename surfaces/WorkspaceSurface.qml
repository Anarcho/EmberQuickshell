import QtQuick
import QtQuick.Layouts
import "../Singletons" as T
import "../components"

PillSurface {
    id: root
    required property string screenName
    profileName: "compactPill"
    content: workspaceContent

    Component.onCompleted: {
        if (T.Flags.debugMode)
            console.log("Workspace surface view created");
    }

    Component.onDestruction: {
        if (T.Flags.debugMode)
            console.log("Workspace surface view destroyed");
    }

    Workspaces {
        id: workspaceContent
        screenName: root.screenName
        Layout.fillWidth: true
        Layout.fillHeight: true
    }
}
