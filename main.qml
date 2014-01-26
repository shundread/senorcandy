import QtQuick 2.1
import QtQuick.Window 2.1
import QtMultimedia 5.0

Window {
    id: window
    visible: true

    Audio {
        id: introMusic
        source: "audio/track1.wav"
    }

    SequentialAnimation {
        running: true
        ColorAnimation { target: window; property: "color"; from: "black"; to: "red"; duration: 1000 }
        PauseAnimation { duration: 5000 }
        ColorAnimation { target: window; property: "color"; to: "skyblue"; duration: 1000 }
    }

    Item {
        id: root
        width: window.height
        height: window.width
        anchors.centerIn: parent
        rotation: 270

        Image {
            id: title
            width: parent.width
            height: parent.height
            source: "images/title.png"
            x: -parent.width
            SequentialAnimation {
                running: true
                PauseAnimation { duration: 1000 }
                NumberAnimation { target: title; property: "x"; to: 0; duration: 1000 }
                PauseAnimation { duration: 3000 }
                NumberAnimation { target: title; property: "x"; to: root.width; duration: 1000 }
            }
        }

        TwerkEngine {
            id: twerker
        }

        Candy {
            id: candy
            scale: 0.75
            x: 600
            y: 100
            state: "armscrossed"
            opacity: 0
            SequentialAnimation {
                running: true
                PauseAnimation { duration: 500 }
                PropertyAction { target: introMusic; property: "running"; value: true }
                PauseAnimation { duration: 2500 }
                //PropertyAction { target: candy; property: "state"; value: "stand" }
                NumberAnimation { target: candy; property: "opacity"; to: 1; duration: 2000 }
                //PauseAnimation { duration: 500 }
                //PropertyAction { target: candy; property: "state"; value: "armscrossed" }
                //NumberAnimation { target: candy; property: "x"; duration: 1000; to: 600 }
                PauseAnimation { duration: 1000 }
                PropertyAction { target: candy; property: "state"; value: "" }
                NumberAnimation { target: candy; property: "x"; to: 300 }
                PropertyAction { target: candy; property: "transitionDuration"; value: 500 }
                PropertyAction { target: chillTimer; property: "running"; value: true }
                PropertyAction { target: startButton; property: "state"; value: "ready" }
            }

            Timer {
                id: chillTimer
                repeat: true
                interval: 500
                onTriggered: {
                    candy.state = candy.state == "chill" ? "" : "chill"
                }
            }
        }

        MouseArea {
            id: startButton
            opacity: 0
            anchors { left: parent.horizontalCenter; right: parent.right; top: parent.top; bottom: parent.bottom }
            Image {
                anchors.centerIn: parent
                source: "images/start.png"
                scale: parent.pressed ? 0.8 : 1
            }
            states: State {
                name: "ready"
                PropertyChanges { target: startButton; opacity: 1 }
            }
            transitions: Transition {
                NumberAnimation { }
            }
            NumberAnimation on scale {
                running: !startButton.pressed; from: 1; to: 1.1; loops: Animation.Infinite
                easing.type: Easing.CosineCurve; duration: 2000
            }
            onClicked:  {
                introMusic.stop()
                twerker.start()
            }
        }
    }
}
