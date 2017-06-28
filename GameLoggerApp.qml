import QtQuick 2.7
import QtQuick.Controls 2.1
import ArcGIS.AppFramework 1.0
import ArcGIS.AppFramework.Sql 1.0

App {
    id: app
    width: 320
    height: 480

    property int currentGameId: -1
    property int currentGameIndex: -1
    property string currentGameName: ""
    property real currentGameDate: -1
    property int currentEventId: -1
    property int currentEventTime: 0
    property int exitBackKey: 0

    StackView {
        id: stackView

        anchors.fill: parent

        initialItem: GamePickerPage {
        }
    }

    BackKey {
        id: backKey

        anchors.fill: parent
    }

    Component {
        id: eventsEditorPage

        EventsEditorPage {
        }
    }

    Component {
        id: resetDatabasePage

        ResetDatabasePage {
        }
    }

    Component {
        id: sampleDatabasePage

        SampleDatabasePage {
        }
    }

    Component {
        id: aboutPage

        AboutPage {
        }
    }

    Component {
        id: deleteGamePage

        DeleteGamePage {
        }
    }

    MyDatabase {
        id: myDatabase
    }

    Timer {
        id: eventTimer

        running: false
        interval: 1000
        repeat: true

        onTriggered: currentEventTime += 1
    }

    function toCSVString(str) {
        return '"' + str + '"';
    }

    function toCSVDate(date) {
        return Qt.formatDateTime(new Date(date), "dd/MM/yyyy hh:mm:ss");
    }

    function pad(e) {
        return e < 10 ? "0" + e : "" + e;
    }

    function getTimeString(time) {
        var s = time % 60;
        var str = pad(s);
        var m = Math.floor(time / 60) % 60;
        str = pad(m) + ":" + str;
        if (time >= 60 * 60) {
            var h = Math.floor(time / 60 / 60) % 24;
            str = pad(h) + ":" + str;
        }
        if (time >= 24 * 60 * 60) {
            var d = Math.floor(time / 24 / 60 / 60);
            str = d + ":" + str;
        }
        return str;
    }

    focus: true

    Keys.onReleased: backKey.keyPressed(event)

}
