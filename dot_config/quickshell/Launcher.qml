import QtQuick
import Quickshell
import Quickshell.Wayland
import "theme.js" as Theme
import Quickshell.Io

PanelWindow {
    id: launcher

    visible: false

    anchors.top: true
    anchors.left: true
    anchors.right: true
    anchors.bottom: true
    color: "#000308cc"

    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.namespace: "qs-launcher"
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand
    exclusionMode: ExclusionMode.Ignore

    property string query: ""
    property var allApps: DesktopEntries.applications.values
    property var filtered: allApps.filter(a => !a.noDisplay && fuzzy(query, a.name || ""))
    property int selected: 0

    onFilteredChanged: selected = Math.min(selected, filtered.length - 1)

    Component.onCompleted: console.log("[Launcher] apps loaded:", allApps.length)

    function fuzzy(q, text) {
        q = q.toLowerCase()
        text = text.toLowerCase()
        if (q.length === 0) return true
        var qi = 0
        for (var ti = 0; ti < text.length && qi < q.length; ti++)
            if (text[ti] === q[qi]) qi++
        return qi === q.length
    }

    function launch(entry) {
        if (entry) entry.execute()
        launcher.visible = false
    }

    onVisibleChanged: {
        if (visible) {
            query = ""
            selected = 0
            searchInput.text = ""
            searchInput.forceActiveFocus()
        }
    }

    IpcHandler {
        target: "launcher"
        function toggle(): void { launcher.visible = !launcher.visible }
        function open(): void { launcher.visible = true }
        function close(): void { launcher.visible = false }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: launcher.visible = false
    }

    Rectangle {
        anchors.centerIn: parent
        width: Math.min(600, parent.width - 80)
        height: Math.min(440, parent.height - 160)
        color: Theme.bg1
        border.color: Theme.line
        border.width: 1

        MouseArea { anchors.fill: parent }

        Column {
            anchors.fill: parent
            anchors.margins: 1
            spacing: 0

            Rectangle {
                width: parent.width
                height: 40
                color: Theme.bg0

                TextInput {
                    id: searchInput
                    anchors.fill: parent
                    anchors.leftMargin: 12
                    anchors.rightMargin: 12
                    verticalAlignment: TextInput.AlignVCenter
                    color: Theme.yellow
                    selectionColor: Theme.sel
                    selectedTextColor: Theme.fg
                    font.family: Theme.mono
                    font.pixelSize: Theme.size + 2
                    clip: true
                    focus: true

                    onTextChanged: launcher.query = text

                    Keys.onDownPressed: if (launcher.selected < launcher.filtered.length - 1) launcher.selected++
                    Keys.onUpPressed:   if (launcher.selected > 0) launcher.selected--
                    Keys.onReturnPressed: launcher.launch(launcher.filtered[launcher.selected])
                    Keys.onEnterPressed:  launcher.launch(launcher.filtered[launcher.selected])
                    Keys.onEscapePressed: launcher.visible = false

                    Text {
                        anchors.fill: parent
                        verticalAlignment: Text.AlignVCenter
                        visible: searchInput.text.length === 0
                        color: Theme.dim
                        font: searchInput.font
                        text: "> "
                    }
                }
            }

            Rectangle { width: parent.width; height: 1; color: Theme.line }

            ListView {
                id: list
                width: parent.width
                height: parent.height - 41
                model: launcher.filtered
                currentIndex: launcher.selected
                clip: true

                delegate: Rectangle {
                    width: list.width
                    height: 32
                    color: index === launcher.selected ? Theme.sel : "transparent"

                    Text {
                        anchors.left: parent.left
                        anchors.leftMargin: 12
                        anchors.verticalCenter: parent.verticalCenter
                        color: index === launcher.selected ? Theme.yellow : Theme.fg
                        font.family: Theme.mono
                        font.pixelSize: Theme.size + 1
                        text: modelData.name
                    }

                    Text {
                        anchors.right: parent.right
                        anchors.rightMargin: 12
                        anchors.verticalCenter: parent.verticalCenter
                        color: Theme.dim
                        font.family: Theme.mono
                        font.pixelSize: Theme.size - 1
                        text: modelData.genericName || ""
                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: launcher.selected = index
                        onClicked: launcher.launch(modelData)
                    }
                }
            }
        }
    }
}
