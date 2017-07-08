import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.1
import ArcGIS.AppFramework 1.0

Item {
    id: item

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10

        spacing: 10

        GamePickerToolbar {
            id: gamePickerToolBar

            Layout.fillWidth: true

            onMenuClicked: openGamePickerMenu()
        }

        GamePickerListView {
            id: gamesListView

            Layout.fillWidth: true
            Layout.fillHeight: true
        }

        GamePickerFooter {
            Layout.fillWidth: true

            onNewGameClicked: newGame()
        }
    }

    GamePickerMenu {
        id: gamePickerMenu

        onResetDatabaseClicked: {
            item.forceActiveFocus();
            stackView.push(resetDatabasePage);
        }

        onSampleDatabaseClicked: {
            item.forceActiveFocus();
            stackView.push(sampleDatabasePage);
        }

        onAboutClicked: {
            item.forceActiveFocus();
            stackView.push(aboutPage);
        }
    }

    function newGame() {
        var gameRecord = {
            gameName: "",
            gameDate: (new Date()).getTime()
        }

        currentGameName = gameRecord.gameName;
        currentGameDate = gameRecord.gameDate;
        currentGameId = myDatabase.insertGame( gameRecord );

        showEventsEditorPage();
    }

    function showEventsEditorPage() {
        myDatabase.eventsModel.refresh();

        currentEventId = -1;

        if (myDatabase.eventsModel.count > 0) {
            currentEventId = myDatabase.eventsModel.get(myDatabase.eventsModel.count - 1).eventId;
        }

        stackView.push(eventsEditorPage);
    }

    function openGamePickerMenu() {
        gamePickerMenu.x = app.width - gamePickerMenu.width - 10;
        gamePickerMenu.y = gamePickerToolBar.height + 10;
        gamePickerMenu.open();
    }
}
