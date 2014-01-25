/****************************************************************************
**
** Copyright (c) 2013 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of Qt Creator
**
**
** GNU Free Documentation License
**
** Alternatively, this file may be used under the terms of the GNU Free
** Documentation License version 1.3 as published by the Free Software
** Foundation and appearing in the file included in the packaging of this
** file.
**
**
****************************************************************************/

// **********************************************************************
// NOTE: the sections are not ordered by their logical order to avoid
// reshuffling the file each time the index order changes (i.e., often).
// Run the fixnavi.pl script to adjust the links to the index order.
// **********************************************************************

import QtQuick 2.1
import QtQuick.Controls 1.0
import QtMultimedia 5.0
import QtSensors 5.0

ApplicationWindow {
    title: qsTr("Accelerate Bubble")
    id: mainWindow
    visible: true
    property var accelData: []
    property var rects: []
    property var divisor: 5

    Accelerometer {
        id: accel
        dataRate: 50
        active:true

        /*
        onReadingChanged: {
            var newX = (bubble.x + calcRoll(accel.reading.x, accel.reading.y, accel.reading.z) * 0.1)
            var newY = (bubble.y - calcPitch(accel.reading.x, accel.reading.y, accel.reading.z) * 0.1)

            if (newX < 0)
                newX = 0

            if (newX > mainWindow.width - bubble.width)
                newX = mainWindow.width - bubble.width

            if (newY < 18)
                newY = 18

            if (newY > mainWindow.height - bubble.height)
                newY = mainWindow.height - bubble.height

                bubble.x = newX
                bubble.y = newY

            var newVector = Qt.vector3d(accel.reading.x, accel.reading.y, accel.reading.z)
            if(newVector.length() > 15)
                airhorn.play()
            accelData = accelData.concat(newVector)
            //output.text = "x: " + accel.reading.x + "\ny: " + accel.reading.y + "\nz: " + accel.reading.z + "\nwidth: " + mainWindow.width + "height: " + mainWindow.height + "\nSamples: " + accelData.length + "\nLength:" + newVector.length()

            if(accelData.length > mainWindow.height/divisor)
                accelData = accelData.slice(1)
            //console.log(accelData)
            var y = 0
            for(var sample in accelData)
            {
                rectlist.itemAt(y).width = accelData[sample].length()*20
                y++
            }
            console.log(synth.position())
        }
        */
    }


    Text {
        id: output
        text: "debug output"
        y: 30
        anchors.horizontalCenter: mainWindow.horizontalCenter
        font.pointSize: 24;
        font.bold: true
    }

    function calcPitch(x, y, z) {
        return -(Math.atan(y / Math.sqrt(x * x + z * z)) * 57.2957795);
    }
    function calcRoll(x, y, z) {
        return -(Math.atan(x / Math.sqrt(y * y + z * z)) * 57.2957795);
    }

    Component.onCompleted: {
        synth.play()
        bass.play()
        drums.play()
    }

    Audio {
        id: airhorn
        source: "single_airhorn.wav"
    }

    Audio {
        id: synth
        source: "twerk_synths.wav"
    }

    Audio {
        id: bass
        source: "twerk_bass.wav"
    }

    Audio {
        id: drums
        source: "twerk_drums.wav"
    }

    Timer {
        id:momentManager
        interval:100
        running: true
        repeat: true
        property int currentIndex: 0
        property var moments: []
        onTriggered: {
            console.log("synth.position =" + synth.position)
            console.log("Current index: " + currentIndex)
            console.log("count: " + momentList.count)
            var pos = synth.position
            while(
                moments.length > currentIndex &&
                pos > moments[currentIndex].end
            )
            {
                currentIndex++
                console.log("currentIndex++ (now " + currentIndex + ")")
            }
            if(currentIndex > moments.length)
            {
                console.log("We moved past the next index")
                repeat = false
                return
            }
            if(pos > moments[currentIndex].start)
            {
                console.log("Calling handleSample")
                var sample = Qt.vector3d(accel.reading.x, accel.reading.y, accel.reading.z)
                moments[currentIndex].handleSample(sample)
            }
        }
    }

    Instantiator {
        id: momentList
        model: [
            //start, end, threshold, twerks
            {start: 1000,  end: 5000,  twerks: 1.8, threshold: 0.5},
            {start: 10000, end: 50000, twerks: 1.8, threshold: 0.5},
            {start: 10000, end: 50000, twerks: 1.8, threshold: 0.5},
        ]
        Moment {
            start: modelData.start
            end: modelData.end
            twerks: modelData.twerks
            threshold: modelData.threshold
        }
        onObjectAdded:
        {
            momentManager.moments = momentManager.moments.concat(object)
            console.log("Generated a new object: " + object)
        }
    }


    Item {
        //Give the repeater a name

        id: rectlistitem
        anchors.fill: parent
        Repeater {
            id: rectlist
            model: (rectlistitem.height)/divisor
            Rectangle {
                x: 0
                y: index*divisor
                width: 10
                height: divisor
                color: "#000000"
            }
        }
    }

    Image {
        id: bubble
        source: "drawing.svg"
        smooth: true
        property real centerX: mainWindow.width / 2
        property real centerY: mainWindow.height / 2
        property real bubbleCenter: bubble.width / 2
        x: centerX - bubbleCenter
        y: centerY - bubbleCenter

        Behavior on y {
            SmoothedAnimation {
                easing.type: Easing.Linear
                duration: 100
                }
            }
        Behavior on x {
            SmoothedAnimation {
                easing.type: Easing.Linear
                duration: 100
                }
            }

    MenuBar {
        Menu {
            title: qsTr("File")
            MenuItem {
                text: qsTr("Exit")
                onTriggered: Qt.quit();
                }
            }
        }
    }
}
