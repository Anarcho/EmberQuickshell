pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    signal command(string monitorName, string action)

    function send(action: string, monitorName): void {
        const name = monitorName.length > 0 ? monitorName : Workspaces.focusedName;
        if (name.length > 0)
            root.command(name, action);
    }

    IpcHandler {
        function workspaces(mon: string): void {
            root.send("workspace", mon);
        }

        function toggle(mon: string): void {
            root.send("toggle", mon);
        }

        target: "ember"
    }
}
