import QtQuick 2.1
import QtQuick.Window 2.1
import QtMultimedia 5.0

Window {
    id: window
    visible: true

    Audio {
        id: introMusic
        source: "audio/track1.wav"
        Component.onCompleted: play()
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

        Loader {
            id: twerker
            asynchronous: true
            onStatusChanged: {
                if (status == Loader.Ready)
                    item.start()
            }
        }

        Candy {
            id: candy
            scale: 0.75
            x: 600
            y: 100
            state: "armscrossed"
            opacity: 0
        }

        // Candy's intro animation
        SequentialAnimation {
            running: true
            PauseAnimation { duration: 3000 }
            NumberAnimation { target: candy; property: "opacity"; to: 1; duration: 2000 }
            PauseAnimation { duration: 1000 }
            PropertyAction { target: candy; property: "state"; value: "" }
            NumberAnimation { target: candy; property: "x"; to: 250 }
            PropertyAction { target: candy; property: "transitionDuration"; value: 500 }
            PropertyAction { target: chillTimer; property: "running"; value: true }
            PropertyAction { target: startButton; property: "state"; value: "ready" }
        }

        // Candy's chill animation
        Timer {
            id: chillTimer
            repeat: true
            interval: 500
            onTriggered: {
                candy.state = candy.state == "chill" ? "" : "chill"
            }
        }

        // Transition to game mode
        SequentialAnimation {
            id: gameModeTransition
            NumberAnimation { target: candy; property: "x"; to: 300 }
            // "Disco Lights"
            SequentialAnimation {
                loops: Animation.Infinite
                ColorAnimation { target: window; property: "color"; to: "red"; duration: 1000 }
                ColorAnimation { target: window; property: "color"; to: "orange"; duration: 1000 }
                ColorAnimation { target: window; property: "color"; to: "yellow"; duration: 1000 }
                ColorAnimation { target: window; property: "color"; to: "green"; duration: 1000 }
                ColorAnimation { target: window; property: "color"; to: "blue"; duration: 1000 }
                ColorAnimation { target: window; property: "color"; to: "purple"; duration: 1000 }
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
            states: [
                State {
                    name: "ready"
                    PropertyChanges { target: startButton; opacity: 1 }
                },
                State {
                    name: "done"
                    PropertyChanges { target: startButton; visible: false }
                }
            ]
            transitions: [
                Transition {
                    NumberAnimation { }
                },
                Transition {
                    to: "done";
                    NumberAnimation { target: startButton; property: "scale"; to: 0.01; easing.type: Easing.InOutQuad }
                }
            ]
            NumberAnimation on scale {
                running: !startButton.pressed; from: 1; to: 1.1; loops: Animation.Infinite
                easing.type: Easing.CosineCurve; duration: 2000
            }
            onClicked:  {
                introMusic.stop()
                twerker.source = "TwerkEngine.qml"
                startButton.state = "done"
                gameModeTransition.start()
            }
        }
    }
}
