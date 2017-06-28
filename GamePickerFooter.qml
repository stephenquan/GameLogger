import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.1

ToolBar {
    signal newGameClicked()

    RowLayout {
        width: parent.width

        spacing: 10

        ToolButton {
            text: qsTr("New Game")

            onClicked: newGameClicked()
        }
    }
}
