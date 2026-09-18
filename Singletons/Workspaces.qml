pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Hyprland

Singleton {
    id: root
    readonly property var monitors: Hyprland.monitors.values
    readonly property var workspaces: Hyprland.workspaces.values
    readonly property string focusedName: Hyprland.focusedMonitor ? Hyprland.focusedMonitor.name : ""

    function monitor(name: string): var {
        return root.monitors.find(m => m.name === name) || null;
    }

    function activeId(name: string): int {
        const mon = root.monitor(name);
        return mon && mon.activeWorkspace ? mon.activeWorkspace.id : 0;
    }

    function idsFor(name: string): var {
        const configured = Flags.workspaceSlots[name] || [];
        const ids = configured.filter(id => Number.isInteger(id) && id > 0);

        for (const ws of root.workspaces) {
            if (ws.id > 0 && ws.monitor && ws.monitor.name === name && !ids.includes(ws.id))
                ids.push(ws.id);
        }

        const active = root.activeId(name);
        if (active > 0 && !ids.includes(active))
            ids.push(active);
        return [...new Set(ids)].sort((a, b) => a - b);
    }

    function refresh(): void {
        Hyprland.refreshMonitors();
        Hyprland.refreshWorkspaces();
    }

    Component.onCompleted: root.refresh()
}
