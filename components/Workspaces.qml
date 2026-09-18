pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import "../Singletons" as T

RowLayout {
    id: root

    required property string screenName
    readonly property int activeId: T.Workspaces.activeId(root.screenName)
    readonly property var workspaceIds: T.Workspaces.idsFor(root.screenName)

    spacing: T.Spacing.xxs

    Repeater {
        model: root.workspaceIds
        delegate: WorkspaceButtons {
            id: slotButtons
            required property int modelData
            selected: modelData === root.activeId
            Layout.fillWidth: true
            Layout.fillHeight: true

            Text {
                id: slots
                anchors.centerIn: parent
                text: String(parent.modelData)
            }
        }
    }
}
