import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.1
import QtQuick.Controls.Material 2.1
import ArcGIS.AppFramework 1.0

ToolBar {
    signal menuClicked()

    RowLayout {
        width: parent.width

        spacing: 10

        ToolButton {
            text: "<"

            onClicked: closeGame()
        }

        TextField {
            id: gameNameTextField

            anchors.margins: 10

            Layout.fillWidth: true

            text: currentGameName
            wrapMode: TextField.WordWrap
            placeholderText: qsTr("Enter Game Name")

            onTextChanged: { currentGameName = text; myDatabase.updateGameName(currentGameId, currentGameName); }
        }

        ToolButton {
            text: "="

            onClicked: menuClicked()
        }

    }
}
