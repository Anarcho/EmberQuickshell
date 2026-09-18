import QtQuick
import QtQuick.Layouts
import "../Singletons" as T
import "../components"

PillSurface {
    id: root
    required property string screenName
    profileName: "compactPill"
    content: workspaceContent

    Workspaces {
        id: workspaceContent
        screenName: root.screenName
        Layout.fillWidth: true
        Layout.fillHeight: true
    }
}
