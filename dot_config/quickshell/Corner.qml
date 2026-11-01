import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import "theme.js" as Theme

PanelWindow {
    id: corner

    anchors.bottom: true
    anchors.right: true
    margins.bottom: 24 * Theme.scale
    margins.right: 24 * Theme.scale

    implicitWidth: (320 + 16) * Theme.scale
    implicitHeight: (col.implicitHeight + 36) * Theme.scale
    color: "transparent"

    WlrLayershell.layer: WlrLayer.Bottom
    WlrLayershell.namespace: "qs-corner"
    exclusionMode: ExclusionMode.Ignore

    // ---- данные ----
    property string clock: ""
    property string date:  ""
    property string host:  ""
    property string uptime: ""
    property string mem:   ""
    property string load:  ""

    // ---- источники ----
    FileView {
        id: uptimeFile
        path: "/proc/uptime"
        onTextChanged: {
            var secs = Math.floor(parseFloat(text()))
            var h = Math.floor(secs / 3600)
            var m = Math.floor((secs % 3600) / 60)
            corner.uptime = h + "h " + m + "m"
        }
    }

    FileView {
        id: memFile
        path: "/proc/meminfo"
        onTextChanged: {
            var lines = text().split("\n")
            var total = 0, avail = 0
            for (var i = 0; i < lines.length; i++) {
                if (lines[i].startsWith("MemTotal:")) total = parseInt(lines[i].split(/\s+/)[1])
                if (lines[i].startsWith("MemAvailable:")) avail = parseInt(lines[i].split(/\s+/)[1])
            }
            var used = (total - avail) / 1024 / 1024
            var tot  = total / 1024 / 1024
            corner.mem = used.toFixed(1) + "G / " + tot.toFixed(1) + "G"
        }
    }

    FileView {
        id: loadFile
        path: "/proc/loadavg"
        onTextChanged: {
            var parts = text().split(" ")
            corner.load = parts[0] + " " + parts[1] + " " + parts[2]
        }
    }

    Timer {
        interval: 1000; running: true; repeat: true
        triggeredOnStart: true
        onTriggered: {
            var d = new Date()
            corner.clock = Qt.formatTime(d, "HH:mm")
            corner.date  = Qt.formatDate(d, "yyyy-MM-dd")
            uptimeFile.reload()
            memFile.reload()
            loadFile.reload()
        }
    }

    Process {
        id: hostProc
        command: ["hostname"]
        stdout: SplitParser {
            onRead: data => corner.host = data.trim()
        }
    }
    Component.onCompleted: hostProc.running = true

    Item {
        anchors.fill: parent
        scale: Theme.scale
        transformOrigin: Item.BottomRight

        // ---- UI ----
        Column {
            id: col
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.margins: 8
            spacing: 2

            // часы + дата
            Text {
                anchors.right: parent.right
                text: "<font color='" + Theme.yellow + "'>" + corner.clock + "</font>"
                    + "<font color='" + Theme.dim + "'>  │  </font>"
                    + "<font color='" + Theme.blue + "'>" + corner.date + "</font>"
                textFormat: Text.RichText
                font.family: Theme.mono
                font.pixelSize: Theme.size + 4
                font.weight: Font.Bold
            }

            // разделитель
            Rectangle {
                width: parent.width
                height: 1
                color: Theme.line
            }

            // строки sys
            Repeater {
                model: [
                    { label: "host",   value: corner.host,   color: Theme.fg },
                    { label: "up",     value: corner.uptime, color: Theme.green },
                    { label: "mem",    value: corner.mem,    color: Theme.cyan },
                    { label: "load",   value: corner.load,   color: Theme.cyan },
                ]
                delegate: Text {
                    anchors.right: parent.right
                    text: "<font color='" + Theme.dim + "'>" + modelData.label + "</font>"
                        + "<font color='" + Theme.bg0 + "'>  </font>"
                        + "<font color='" + modelData.color + "'>" + modelData.value + "</font>"
                    textFormat: Text.RichText
                    font.family: Theme.mono
                    font.pixelSize: Theme.size
                }
            }
        }
    }
}
