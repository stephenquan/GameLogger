import QtQuick 2.7
import QtQuick.Controls 2.1

Item {
    Column {
        anchors.centerIn: parent

        spacing: 10

        Label {
            //width: parent.width

            text: qsTr("Game Logger %1")
                .arg(app.info.version)

            font.pointSize: 12
            font.bold: true
            //wrapMode: Text.WordWrap

            //horizontalAlignment: Text.AlignHCenter
        }

        Repeater {
            width: parent.width

            model: [
                "© Copyright 2017 by Stephen Quan.",
                "All Rights Reserved"
            ]

            Text {
                width: parent.width

                text: modelData
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignHCenter
            }

        }

        Item {

        }

        Rectangle {
            width: parent.width
            height: okButton.height

            Button {
                id: okButton

                anchors.centerIn: parent

                text: qsTr("Ok")

                onClicked: {
                    stackView.pop();
                }
            }
        }
    }
}

