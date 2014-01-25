import QtQuick 2.1

MouseArea {
    property alias text: text.text
    implicitHeight: text.font.pixelSize * 2
    Text {
        id: text
        font.pixelSize: 64
        anchors.fill: parent
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
}
