import QtQuick 2.1
import QtSensors 5.0
import QtMultimedia 5.0

Item {
    Timer {
        id: manager
        property int ticks: 0

        // Moments
        property var moments: []
        property int momentIndex: 0

        interval: 100
        running: true
        repeat: true
        //Component.onCompleted: start()
        onTriggered: {
            ticks++
            var currentTime = time()

            // Advancing through the moments
            while(momentIndex < moments.length &&
                  currentTime > moments[momentIndex].end)
            {
                moments[momentIndex].on=false
                momentIndex++
                console.log("momentIndex is now", momentIndex)
                if(momentIndex > moments.length)
                {
                    console.log("End of the game/stage")
                    repeat = false
                    return
                }
                moments[momentIndex].on=true
            }
        }
        function time() {
            //return music.position
            return ticks * interval
        }

        function restart() {
            ticks = 0
        }
    }

    Audio {
        id: audio
        source: "audio/track1.wav"
    }

    Accelerometer {
        id: accelerometer
        active: true
        dataRate: 10
        onReadingChanged: {
            //console.log("Reading changed: "+ reading.x + " " + reading.y + " " + reading.z)
        }
    }

    Instantiator {
        model: [
            {start: 0,    end: 3000,  twerks: 2.0,  tolerance:0.5, policy:0},
            {start: 3000, end: 6000,  twerks: 2.0,  tolerance:0.5, policy:1},
            {start: 6000, end: 9000,  twerks: 2.0,  tolerance:0.5, policy:2},
            {start: 9000, end: 12000, twerks: 2.0,  tolerance:0.5, policy:1},
        ]
        delegate: QtObject {
            id: moment

            //Arguments
            property int start: modelData.start
            property int end: modelData.end
            property real twerks: modelData.twerks
            property real tolerance: modelData.tolerance
            property int policy: modelData.policy
            // Policies:
            // 0 - Ignore twerking (allow free movement at some points)
            // 1 - Reward twerking (sync with synth)
            // 2 - Punish twerking (sync with silence)

            // Accumulated twerk data
            property int twerkCount
            property real twerkForce
            property int samples

            // State data
            property bool on: false
            property real amplitude
            property vector3d previousValue
            property vector3d value

            onValueChanged: {
                if (value.dotProduct(previousValue) < 0) {
                    console.log('change in direction, average accel:', amplitude/samples)
                    twerkForce += amplitude; //Somehow multiply this by the sampling interval?
                    twerkCount += 1;
                }
                previousValue = value;
                amplitude += value.length();
                ++samples;
            }

            onOnChanged: {
                console.log("Moment(", start, end, ") set to on =", on)
                if(on == false)
                {
                    console.log("Moment ended: Twerk Count(", twerkCount,"), Accumulated Twerk Force(", twerkForce,")")
                }
            }

            property Binding binding: Binding {
                id: binding
                when: moment.on
                target: moment
                property: "value"
                value: Qt.vector3d(accelerometer.reading.x, accelerometer.reading.y, accelerometer.reading.z)
            }
        }
        onObjectAdded:
        {
            console.log("New object:", object)
            manager.moments = manager.moments.concat(object)
        }
    }

    function start() {
        audio.play()
        manager.start()
    }
}

