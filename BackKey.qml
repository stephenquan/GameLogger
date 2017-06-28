import QtQuick 2.7
import QtQuick.Controls 2.1
import ArcGIS.AppFramework 1.0

Item {
    property int exitBackKey: 0

    Rectangle {
        anchors.fill: exitText
        anchors.margins: -5

        radius: 5
        visible: exitText.visible
        opacity: exitText.opacity
        color: "grey"
    }

    Text {
        id: exitText

        anchors.centerIn: parent

        text: qsTr("Press BACK %1 more times to exit").arg(3 - exitBackKey)
        visible: opacity > 0
        opacity: 0
        color: "white"
    }

    OpacityAnimator {
        id: hideExitText

        target: exitText
        from: 1
        to: 0
        duration: 3000
    }

    function keyPressed(event) {
        hideExitText.stop();
        exitText.opacity = 0;

        if (event.key === Qt.Key_Back || event.key === Qt.Key_Escape) {
            if (stackView.depth > 1) {
                event.accepted = true;
                exitBackKey = 0;
                stackView.pop();
            } else {
                if (event.key === Qt.Key_Back) {
                    if (exitBackKey < 2) {
                        event.accepted = true;
                        exitBackKey++;
                        exitText.opacity = 1;
                        hideExitText.start();
                    } else {
                        exitBackKey = 0;
                        //Qt.quit();
                    }
                }
            }
            return;
        }

        exitBackKey = 0;
    }
}
