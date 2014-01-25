import QtQuick 2.1
import QtQuick.Window 2.1
import QtMultimedia 5.0
import QtSensors 5.0

Window {
    visible: true

    Item {
        id: root
        anchors.fill: parent

        Column {
            anchors.fill: parent
            Button {
                anchors { left: parent.left; right: parent.right }
                text: qsTr("Start Twerkin'")
                onClicked: {
                    console.log("pressed")
                    twerker.start()
                    audio.play()
                    console.log(audio.errorString)
                    console.log(audio.mediaObject)
                    console.log(audio.error.toString())
                    console.log(audio.error)
                }
            }
            Button {
                anchors { left: parent.left; right: parent.right }
                text: qsTr("Credits")
            }
        }

        TwerkEngine {
            id: twerker
        }
    }

}
