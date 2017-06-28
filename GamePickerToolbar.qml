import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.1

ToolBar {
    signal menuClicked()

    RowLayout {
        width: parent.width

        spacing: 10

        Item {
            Layout.preferredWidth: 1
        }

        Label {
            Layout.fillWidth: true

            text: qsTr("Game Logger")
        }

        ToolButton {
            text: "="

            onClicked: menuClicked()
        }
    }
}
