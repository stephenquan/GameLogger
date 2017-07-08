import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.1
import QtQuick.Controls.Material 2.1
import ArcGIS.AppFramework 1.0

Item {
    id: item

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10

        spacing: 10

        EventsEditorToolBar {
            id: eventsEditorToolBar

            Layout.fillWidth: true

            onMenuClicked: openEventsEditorMenu()
        }

        ListView {
            id: listView

            signal selectByIndex(var destIndex)

            Layout.fillWidth: true
            Layout.fillHeight: true

            model: myDatabase.eventsModel
            spacing: 10
            clip: true

            delegate: RowLayout {
                width: listView.width

                spacing: 10

                Text {
                    text: getTimeString(eventTime >= 0 ? eventTime : currentEventTime)
                    font.bold: textField.focus
                    color: eventTime >= 0 || eventTimer.running ? Material.foreground : Material.color(Material.Grey, Material.Shade500)
                }

                TextField {
                    id: textField

                    Layout.fillWidth: true

                    text: eventText
                    font.bold: focus
                    placeholderText: qsTr("Enter Event Text")

                    onTextChanged: {
                        if (text === "" && eventId > 0 && index === myDatabase.eventsModel.count - 2) {
                            myDatabase.deleteLastEvent(eventId, index);
                        }  if (eventId > 0 && text !== "") {
                            myDatabase.updateEventText(eventId, text, index)
                        } else if (index >= 0 && text !== "") {
                            myDatabase.insertEvent( {
                                                       gameId: currentGameId,
                                                       eventText: text,
                                                       eventDate: (new Date()).getTime(),
                                                       eventTime: currentEventTime
                                                   }, index );

                            listView.positionViewAtEnd();
                        }
                    }

                    onAccepted: {
                        //if (index < myDatabase.eventsModel.count - 1) {
                        if (index === myDatabase.eventsModel.count - 2) {
                            listView.selectByIndex(index + 1);
                        }
                    }

                    Keys.onPressed: {
                        if (event.key === Qt.Key_Backspace && text === "") {
                            //if (index > 0) {
                            if (index > 0 && index === myDatabase.eventsModel.count - 1) {
                                listView.selectByIndex(index - 1);
                            }
                        }
                    }
                }

                Connections {
                    target: listView

                    onSelectByIndex: {
                        if (destIndex === index) {
                            textField.forceActiveFocus();
                        }
                    }
                }
            }
        }

        EventsEditorStopWatch {
            Layout.fillWidth: true
        }
    }

    EventsEditorMenu {
        id: eventsEditorMenu

        onDeleteGameClicked: {
            item.forceActiveFocus();
            stackView.push(deleteGamePage);
        }

    }

    function closeGame() {
        if (myDatabase.eventsModel.count === 1) {
            myDatabase.deleteGame(currentGameId);
        }

        stackView.pop();
    }

    function openEventsEditorMenu() {
        eventsEditorMenu.x = app.width - eventsEditorMenu.width - 10;
        eventsEditorMenu.y = eventsEditorToolBar.height + 10;
        eventsEditorMenu.open();
    }
}
