import QtQuick
import "Singletons" as T
import "surfaces"
import "components"

Item {
    id: pill
    property bool expanded: false
    required property string screenName

    readonly property real targetHeight: currentFace.implicitHeight
    readonly property real targetWidth: currentFace.implicitWidth

    property var currentFace: !expanded ? compactPill : expandedBar

    readonly property int activeWorkspace: T.Workspaces.activeId(screenName)
    property int previousWorkspace: 0

    implicitHeight: targetHeight
    implicitWidth: targetWidth
    height: implicitHeight
    width: implicitWidth

    function clearAnnouncement(): void {
        announcementTimer.stop();
    }

    function toggle(): void {
        pill.clearAnnouncement();
        pill.expanded = !pill.expanded;
    }

    function flashWorkspaces(): void {
        if (T.Workspaces.idsFor(pill.screenName).length === 0)
            return;
        pill.currentFace = workspaceSurface;
        announcementTimer.restart();
    }

    function reset(): void {
        pill.currentFace = compactPill;
    }

    Timer {
        id: announcementTimer
        interval: T.Flags.announcementMs
        onTriggered: pill.reset()
    }

    Timer {
        id: evictionTimer
        interval: Math.max(T.Flags.unloadMs, T.Motion.enabled ? T.Motion.normal + T.Motion.morph : 0)
        // onTriggered:
    }

    Behavior on height {
        enabled: T.Motion.enabled

        NumberAnimation {
            duration: T.Motion.morph
            easing.type: T.Motion.easeOut
        }
    }

    Behavior on width {
        enabled: T.Motion.enabled
        NumberAnimation {
            duration: T.Motion.morph
            easing.type: T.Motion.easeOut
        }
    }

    Component.onCompleted: pill.previousWorkspace = pill.activeWorkspace
    onActiveWorkspaceChanged: {
        const next = pill.activeWorkspace;
        if (pill.previousWorkspace > 0 && next > 0 && next !== pill.previousWorkspace)
            T.Surfaces.send("workspace", "*");
        pill.previousWorkspace = next;
    }

    Connections {
        function onCommand(monitorName: string, action: string): void {
            if (monitorName !== "*" && monitorName !== pill.screenName)
                return;
            switch (action) {
            case "workspace":
                pill.flashWorkspaces();
                break;
            case "toggle":
                pill.toggle();
                break;
            }
        }
        target: T.Surfaces
    }

    SurfaceFrame {
        id: frame
        profile: pill.currentFace.profile
        screenName: pill.screenName
        anchors.fill: parent

        CompactPillSurface {
            id: compactPill
            anchors.fill: parent
            visible: pill.currentFace === compactPill
        }

        ExpandedBarSurface {
            id: expandedBar
            screenName: frame.screenName
            anchors.fill: parent
            visible: pill.currentFace === expandedBar
        }

        WorkspaceSurface {
            id: workspaceSurface
            screenName: frame.screenName
            anchors.fill: parent
            visible: pill.currentFace === workspaceSurface
        }
    }
}
