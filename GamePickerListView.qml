import QtQuick 2.7
import QtQuick.Layouts 1.1

ListView {
    model: myDatabase.gamesModel

    spacing: 10

    delegate: RowLayout {
        width: gamesListView.width

        spacing: 10

        Text {
            text: Qt.formatDate(new Date(gameDate), "dd MMM")

            MouseArea {
                anchors.fill: parent

                onClicked: selectGame()
            }
        }

        Text {
            Layout.fillWidth: true

            text: gameName
            wrapMode: Text.WordWrap

            MouseArea {
                anchors.fill: parent

                onClicked: selectGame()
            }
        }

        function selectGame() {
            currentGameName = gameName;
            currentGameDate = gameDate;
            currentGameId = gameId;
            currentGameIndex = index;
            showEventsEditorPage();
        }
    }
}
