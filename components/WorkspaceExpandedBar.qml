pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import "../Singletons" as T

RowLayout {
    id: root

    required property string screenName
    required property var profile
    readonly property int activeId: T.Workspaces.activeId(root.screenName)
    readonly property var workspaceIds: T.Workspaces.idsFor(root.screenName)

    spacing: T.Spacing.xxs

    Repeater {
        model: root.workspaceIds

        delegate: Item {
            id: workspaceDots

            required property var modelData
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }
}
