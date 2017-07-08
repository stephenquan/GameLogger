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

            text: qsTr("Are you sure you want to reset the database?\n\n%1 games containing %2 events will be deleted!!!")
                .arg(myDatabase.countAllGames())
                .arg(myDatabase.countAllEvents())
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WordWrap

        }

        Row {
            spacing: 5

            Button {
                text: qsTr("Yes, delete everything!")

                onClicked: {
                    myDatabase.resetDatabase();
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

