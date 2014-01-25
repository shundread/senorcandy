import QtQuick 2.1
import QtQuick.Window 2.1

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
            }
            Button {
                anchors { left: parent.left; right: parent.right }
                text: qsTr("Credits")
            }
        }

        TwerkEngine {

        }

    }
}
