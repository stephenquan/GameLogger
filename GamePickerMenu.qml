import QtQuick 2.7
import QtQuick.Controls 2.1

Menu {
    signal resetDatabaseClicked()
    signal sampleDatabaseClicked()
    signal aboutClicked()

    MenuItem {
        text: qsTr("Reset Database")

        onClicked: resetDatabaseClicked()
    }

    MenuItem {
        text: qsTr("Sample Database")

        onClicked: sampleDatabaseClicked()
    }

    MenuSeparator {
    }

    MenuItem {
        text: qsTr("About")

        onClicked: aboutClicked()
    }
}
