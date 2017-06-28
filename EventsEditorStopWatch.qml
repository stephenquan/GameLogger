import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.1
import QtQuick.Controls.Material 2.1
import ArcGIS.AppFramework 1.0

ToolBar {
    RowLayout {
        width: parent.width

        spacing: 10

        ToolButton {
            text: eventTimer.running ? qsTr("Stop") : qsTr("Start")
            onClicked: eventTimer.running = !eventTimer.running
        }

        Text {
            text: getTimeString(currentEventTime)
            font {
                bold: true
                pointSize: 20
            }
            color: eventTimer.running ? Material.foreground : Material.color(Material.Grey, Material.Shade500)
        }

        ToolButton {
            text: qsTr("Reset")
            onClicked: currentEventTime = 0
        }

        Item {
            Layout.fillWidth: true
        }
    }
}
