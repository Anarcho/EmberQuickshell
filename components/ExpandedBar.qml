import QtQuick
import QtQuick.Layouts
import "../Singletons" as T

RowLayout {
    id: root
    required property var profile
    required property string screenName
    readonly property string dateText: T.Clock.dateLabel

    spacing: T.Spacing.xxs

    Layout.preferredHeight: root.profile.contentHeight
    Layout.preferredWidth: root.profile.preferredWidth

    WorkspaceExpandedBar {
        id: workspaces
        profile: profile
        screenName: root.screenName
    }
}
