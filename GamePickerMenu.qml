import QtQuick 2.7
import QtQuick.Controls 2.1

Menu {
    MenuItem {
        text: qsTr("Reset Database")

        onClicked: stackView.push(resetDatabasePage);
    }

    MenuItem {
        text: qsTr("Sample Database")

        onClicked: stackView.push(sampleDatabasePage);
    }

    MenuSeparator {
    }

    MenuItem {
        text: qsTr("About")

        onClicked: stackView.push(aboutPage);
    }
}
