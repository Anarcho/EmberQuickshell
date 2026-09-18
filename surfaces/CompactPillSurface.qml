import QtQuick
import QtQuick.Layouts
import "../Singletons" as T
import "../components"

PillSurface {
    id: root
    profileName: "compactPill"
    content: compactContent

    CompactPill {
        id: compactContent
        Layout.fillWidth: true
        Layout.fillHeight: true
    }
}
