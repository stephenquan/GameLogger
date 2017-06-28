import QtQuick 2.7
import QtQuick.Controls 2.1

Item {
    Column {
        anchors.centerIn: parent

        spacing: 40

        Rectangle {
            width: parent.width
            height: icon.height

            Image {
                id: icon

                anchors.centerIn: parent

                source: "images/exclamation.png"
            }
        }

        Text {
            width: parent.width

            text: qsTr("Are you sure you want to delete the game %1 on %2?\n\nThis game containing %3 events will be deleted!!!")
                .arg(currentGameName)
                .arg((new Date(currentGameDate).toLocaleString()))
                .arg(myDatabase.countGameEvents(currentGameId))

            wrapMode: Text.WordWrap

            horizontalAlignment: Text.AlignHCenter
        }

        Row {
            spacing: 5

            Button {
                text: qsTr("Yes, delete this game!")

                onClicked: {
                    myDatabase.deleteGame(currentGameId);
                    stackView.pop();
                    stackView.pop();
                }
            }

            Item {
                width: 20
            }

            Button {
                text: qsTr("No")

                onClicked: {
                    stackView.pop();
                }
            }
        }
    }
}

