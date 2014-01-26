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

        //Scores
        property int score: 0
        property int negScore: 0
        property int peakScore: 0
        property int negPeakScore: 0

        interval: 100
        running: false
        repeat: true

        onRunningChanged: {
            if(running == true)
                moments[0].on = true
            //else
            //    repeat = true
        }

        onTriggered: {
            ticks++
            var currentTime = time()
            console.log("currentTime: ", currentTime)

            // Advancing through the moments
            while(momentIndex < moments.length &&
                  currentTime >= moments[momentIndex].end)
            {
                moments[momentIndex].on=false
                momentIndex++
                console.log("momentIndex is now", momentIndex)
                if(momentIndex >= moments.length)
                {
                    console.log("End of the game/stage")
                    console.log("Your final score was:", score)
                    console.log("Your final negScore was:", negScore)
                    console.log("Your final peakScore was:", peakScore)
                    console.log("Your final negPeakScore was:", negPeakScore)
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
            momentIndex = 0
            score = 0
            negScore = 0
            running = true
        }
    }


    Audio {
        id: audio
        source: "audio/senorcandyass.wav"
    }

    // TODO:
    //      Replace with a commenter class?
    Audio {
        id: airhorn
        source: "audio/airhorn.wav"
    }

    Accelerometer {
        id: accelerometer
        active: true
        dataRate: 20
        onReadingChanged: console.log("Reading changed", reading.x, reading.y, reading.z)
    }

    Instantiator {
        model: [
            // Intro
            {start: 0, end: 17858, twerkGoal: 0, twerkPolicy: 0},
            {start: 17858, end: 18058, twerkGoal: 1, twerkPolicy: 1},
            {start: 18058, end: 18661, twerkGoal: 1, twerkPolicy: 2},
            {start: 18661, end: 18861, twerkGoal: 1, twerkPolicy: 1},
            {start: 18861, end: 19410, twerkGoal: 1, twerkPolicy: 2},
            {start: 19410, end: 19610, twerkGoal: 1, twerkPolicy: 1},
            {start: 19610, end: 20197, twerkGoal: 1, twerkPolicy: 2},
            {start: 20197, end: 20397, twerkGoal: 1, twerkPolicy: 1},
            {start: 20397, end: 20925, twerkGoal: 1, twerkPolicy: 2},
            {start: 20925, end: 21125, twerkGoal: 1, twerkPolicy: 1},
            {start: 21125, end: 21566, twerkGoal: 1, twerkPolicy: 2},
            {start: 21566, end: 21766, twerkGoal: 1, twerkPolicy: 1},
            {start: 21766, end: 22009, twerkGoal: 1, twerkPolicy: 2},
            {start: 22009, end: 22209, twerkGoal: 1, twerkPolicy: 1},
            {start: 22209, end: 22353, twerkGoal: 1, twerkPolicy: 2},
            {start: 22353, end: 22553, twerkGoal: 1, twerkPolicy: 1},
            {start: 22553, end: 23861, twerkGoal: 1, twerkPolicy: 2},
            {start: 23861, end: 24061, twerkGoal: 1, twerkPolicy: 1},
            {start: 24061, end: 24623, twerkGoal: 1, twerkPolicy: 2},
            {start: 24623, end: 24823, twerkGoal: 1, twerkPolicy: 1},
            {start: 24823, end: 25289, twerkGoal: 1, twerkPolicy: 2},
            {start: 25289, end: 25489, twerkGoal: 1, twerkPolicy: 1},
            {start: 25489, end: 26079, twerkGoal: 1, twerkPolicy: 2},
            {start: 26079, end: 26279, twerkGoal: 1, twerkPolicy: 1},
            {start: 26279, end: 26835, twerkGoal: 1, twerkPolicy: 2},
            {start: 26835, end: 27035, twerkGoal: 1, twerkPolicy: 1},
            {start: 27035, end: 27581, twerkGoal: 1, twerkPolicy: 2},
            {start: 27581, end: 27781, twerkGoal: 1, twerkPolicy: 1},
            {start: 27781, end: 27886, twerkGoal: 1, twerkPolicy: 2},
            {start: 27886, end: 28086, twerkGoal: 1, twerkPolicy: 1},
            {start: 28086, end: 28345, twerkGoal: 1, twerkPolicy: 2},
            {start: 28345, end: 28545, twerkGoal: 1, twerkPolicy: 1},
            {start: 28545, end: 41701, twerkGoal: 1, twerkPolicy: 0},
            {start: 41701, end: 41901, twerkGoal: 1, twerkPolicy: 1},
            {start: 41901, end: 42411, twerkGoal: 1, twerkPolicy: 2},
            {start: 42411, end: 42611, twerkGoal: 1, twerkPolicy: 1},
            {start: 42611, end: 43124, twerkGoal: 1, twerkPolicy: 2},
            {start: 43124, end: 43324, twerkGoal: 1, twerkPolicy: 1},
            {start: 43324, end: 43464, twerkGoal: 1, twerkPolicy: 2},
            {start: 43464, end: 43797, twerkGoal: 2, twerkPolicy: 1},
            {start: 43797, end: 43871, twerkGoal: 1, twerkPolicy: 2},
            {start: 43871, end: 44071, twerkGoal: 1, twerkPolicy: 1},
            {start: 44071, end: 44550, twerkGoal: 1, twerkPolicy: 2},
            {start: 44550, end: 44750, twerkGoal: 1, twerkPolicy: 1},
            {start: 44750, end: 45025, twerkGoal: 1, twerkPolicy: 2},
            {start: 45025, end: 45225, twerkGoal: 1, twerkPolicy: 1},
            {start: 45225, end: 45328, twerkGoal: 1, twerkPolicy: 2},
            {start: 45328, end: 45691, twerkGoal: 2, twerkPolicy: 1},
            {start: 45691, end: 45730, twerkGoal: 1, twerkPolicy: 2},
            {start: 45730, end: 46267, twerkGoal: 3, twerkPolicy: 1},
            {start: 46267, end: 46375, twerkGoal: 1, twerkPolicy: 2},
            {start: 46375, end: 46575, twerkGoal: 1, twerkPolicy: 1},
            {start: 46575, end: 46816, twerkGoal: 1, twerkPolicy: 2},
            {start: 46816, end: 47016, twerkGoal: 1, twerkPolicy: 1},
            {start: 47016, end: 47553, twerkGoal: 1, twerkPolicy: 2},
            {start: 47553, end: 47753, twerkGoal: 1, twerkPolicy: 1},
            {start: 47753, end: 48234, twerkGoal: 1, twerkPolicy: 2},
            {start: 48234, end: 48434, twerkGoal: 1, twerkPolicy: 1},
            {start: 48434, end: 48981, twerkGoal: 1, twerkPolicy: 2},
            {start: 48981, end: 49181, twerkGoal: 1, twerkPolicy: 1},
            {start: 49181, end: 49437, twerkGoal: 1, twerkPolicy: 2},
            {start: 49437, end: 49935, twerkGoal: 3, twerkPolicy: 1},
            {start: 49935, end: 50511, twerkGoal: 1, twerkPolicy: 2},
            {start: 50511, end: 50711, twerkGoal: 1, twerkPolicy: 1},
            {start: 50711, end: 50949, twerkGoal: 1, twerkPolicy: 2},
            {start: 50949, end: 51149, twerkGoal: 1, twerkPolicy: 1},
            {start: 51149, end: 51277, twerkGoal: 1, twerkPolicy: 2},
            {start: 51277, end: 51634, twerkGoal: 2, twerkPolicy: 1},
            {start: 51634, end: 51670, twerkGoal: 1, twerkPolicy: 2},
            {start: 51670, end: 52200, twerkGoal: 3, twerkPolicy: 1},
            {start: 52200, end: 52397, twerkGoal: 1, twerkPolicy: 2},
            {start: 52397, end: 52597, twerkGoal: 1, twerkPolicy: 1},
            {start: 52597, end: 52764, twerkGoal: 1, twerkPolicy: 2},
            {start: 52764, end: 52964, twerkGoal: 1, twerkPolicy: 1},
            {start: 52964, end: 65689, twerkGoal: 1, twerkPolicy: 0},
            {start: 65689, end: 66064, twerkGoal: 2, twerkPolicy: 1},
            {start: 66064, end: 66157, twerkGoal: 1, twerkPolicy: 2},
            {start: 66157, end: 66894, twerkGoal: 4, twerkPolicy: 1},
            {start: 66894, end: 67152, twerkGoal: 1, twerkPolicy: 2},
            {start: 67152, end: 67352, twerkGoal: 1, twerkPolicy: 1},
            {start: 67352, end: 67452, twerkGoal: 1, twerkPolicy: 2},
            {start: 67452, end: 68287, twerkGoal: 5, twerkPolicy: 1},
            {start: 68287, end: 68358, twerkGoal: 1, twerkPolicy: 2},
            {start: 68358, end: 68558, twerkGoal: 1, twerkPolicy: 1},
            {start: 68558, end: 69162, twerkGoal: 1, twerkPolicy: 2},
            {start: 69162, end: 69362, twerkGoal: 1, twerkPolicy: 1},
            {start: 69362, end: 69812, twerkGoal: 1, twerkPolicy: 2},
            {start: 69812, end: 70012, twerkGoal: 1, twerkPolicy: 1},
            {start: 70012, end: 70564, twerkGoal: 1, twerkPolicy: 2},
            {start: 70564, end: 70764, twerkGoal: 1, twerkPolicy: 1},
            {start: 70764, end: 71614, twerkGoal: 1, twerkPolicy: 2},
            {start: 71614, end: 72156, twerkGoal: 3, twerkPolicy: 1},
            {start: 72156, end: 72224, twerkGoal: 1, twerkPolicy: 2},
            {start: 72224, end: 72738, twerkGoal: 3, twerkPolicy: 1},
            {start: 72738, end: 73225, twerkGoal: 1, twerkPolicy: 2},
            {start: 73225, end: 74390, twerkGoal: 7, twerkPolicy: 1},
            {start: 74390, end: 74973, twerkGoal: 1, twerkPolicy: 2},
            {start: 74973, end: 75173, twerkGoal: 1, twerkPolicy: 1},
            {start: 75173, end: 75670, twerkGoal: 1, twerkPolicy: 2},
            {start: 75670, end: 75870, twerkGoal: 1, twerkPolicy: 1},
            {start: 75870, end: 76370, twerkGoal: 1, twerkPolicy: 2},
            {start: 76370, end: 76570, twerkGoal: 1, twerkPolicy: 1},
            {start: 76570, end: 89119, twerkGoal: 1, twerkPolicy: 0},
            {start: 89119, end: 89468, twerkGoal: 2, twerkPolicy: 1},
            {start: 89468, end: 89721, twerkGoal: 1, twerkPolicy: 2},
            {start: 89721, end: 89921, twerkGoal: 1, twerkPolicy: 1},
            {start: 89921, end: 89984, twerkGoal: 1, twerkPolicy: 2},
            {start: 89984, end: 90184, twerkGoal: 1, twerkPolicy: 1},
            {start: 90184, end: 90575, twerkGoal: 1, twerkPolicy: 2},
            {start: 90575, end: 90944, twerkGoal: 2, twerkPolicy: 1},
            {start: 90944, end: 91204, twerkGoal: 1, twerkPolicy: 2},
            {start: 91204, end: 91572, twerkGoal: 2, twerkPolicy: 1},
            {start: 91572, end: 92081, twerkGoal: 1, twerkPolicy: 2},
            {start: 92081, end: 92281, twerkGoal: 1, twerkPolicy: 1},
            {start: 92281, end: 92282, twerkGoal: 1, twerkPolicy: 2},
            {start: 92282, end: 92482, twerkGoal: 1, twerkPolicy: 1},
            {start: 92482, end: 92762, twerkGoal: 1, twerkPolicy: 2},
            {start: 92762, end: 93264, twerkGoal: 3, twerkPolicy: 1},
            {start: 93264, end: 93322, twerkGoal: 1, twerkPolicy: 2},
            {start: 93322, end: 94008, twerkGoal: 4, twerkPolicy: 1},
            {start: 94008, end: 94282, twerkGoal: 1, twerkPolicy: 2},
            {start: 94282, end: 94482, twerkGoal: 1, twerkPolicy: 1},
            {start: 94482, end: 94596, twerkGoal: 1, twerkPolicy: 2},
            {start: 94596, end: 94796, twerkGoal: 1, twerkPolicy: 1},
            {start: 94796, end: 94917, twerkGoal: 1, twerkPolicy: 2},
            {start: 94917, end: 95117, twerkGoal: 1, twerkPolicy: 1},
            {start: 95117, end: 95265, twerkGoal: 1, twerkPolicy: 2},
            {start: 95265, end: 95465, twerkGoal: 1, twerkPolicy: 1},
            {start: 95465, end: 95727, twerkGoal: 1, twerkPolicy: 2},
            {start: 95727, end: 96053, twerkGoal: 2, twerkPolicy: 1},
            {start: 96053, end: 96416, twerkGoal: 1, twerkPolicy: 2},
            {start: 96416, end: 96788, twerkGoal: 2, twerkPolicy: 1},
            {start: 96788, end: 97228, twerkGoal: 1, twerkPolicy: 2},
            {start: 97228, end: 97613, twerkGoal: 2, twerkPolicy: 1},
            {start: 97613, end: 97934, twerkGoal: 1, twerkPolicy: 2},
            {start: 97934, end: 98308, twerkGoal: 2, twerkPolicy: 1},
            {start: 98308, end: 98619, twerkGoal: 1, twerkPolicy: 2},
            {start: 98619, end: 98959, twerkGoal: 2, twerkPolicy: 1},
            {start: 98959, end: 99064, twerkGoal: 1, twerkPolicy: 2},
            {start: 99064, end: 99724, twerkGoal: 4, twerkPolicy: 1},
            {start: 99724, end: 99782, twerkGoal: 1, twerkPolicy: 2},
            {start: 99782, end: 100342, twerkGoal: 3, twerkPolicy: 1},
            {start: 100342, end: 100449, twerkGoal: 1, twerkPolicy: 2},
            {start: 100449, end: 101000, twerkGoal: 2, twerkPolicy: 0},
        ]
        delegate: QtObject {
            id: moment

            //Arguments
            property int start: modelData.start
            property int end: modelData.end
            property int twerkGoal: modelData.twerkGoal
            property int twerkPolicy: modelData.twerkPolicy
            // Policies:
            // 0 - Ignore twerking (allow free movement at some points)
            // 1 - Reward twerking (sync with synth)
            // 2 - Punish twerking (sync with non-twerking bits at the player's turn to repeat the pattern)

            // Accumulated twerk data
            property int peakTwerkCount
            property int twerkCount
            property real twerkForce
            property int samples

            // State data
            property bool on: false
            property real amplitude
            property vector3d previousValue: Qt.vector3d(0, 0, 0)
            property vector3d value

            property bool onPeak: false

            onValueChanged: {
                var valueLength = value.length()
                var previousValueLength = previousValue.length()

                //Dot twerk
                if (value.dotProduct(previousValue) < 0) {
                    twerkForce += amplitude; //Somehow multiply this by the sampling interval?
                    twerkCount += 1;
                    console.log("Classic Twerk")
                }

                //Cross twerk
                var cross = value.crossProduct(previousValue)
                if(cross > 0.25)
                    console.log("Cross Twerk")

                //Amplitude twerk
                if(valueLength > previousValueLength)
                    if(value.length() > 12)
                        if(onPeak == false)
                            onPeak = true
                if(valueLength < previousValueLength)
                    if(valueLength < 12)
                        if(onPeak == true)
                        {
                            console.log("Peak Twerk")
                            onPeak = false
                            peakTwerkCount+=1
                        }
                previousValue = value;
                amplitude += valueLength;
                ++samples;
            }

            onOnChanged: {
                console.log("Moment(", start, end, ") set to on =", on, "policy is ", twerkPolicy)
                if(on == false)
                {
                    console.log("Moment ended: Twerk Count(", twerkCount,"), Accumulated Twerk Force(", twerkForce,")")

                    // Case 0:
                    // We don't care about your twerking
                    if(twerkPolicy == 0)
                        return

                    // Case 1:
                    // We want to see you shake your ass
                    if(twerkPolicy == 1)
                    {
                        console.log("++++++++twerkCount++++++++", twerkCount)
                        manager.score += twerkCount
                        manager.peakScore += peakTwerkCount
                        return
                    }

                    // Case 2:
                    // Hold your ass still
                    // Play boos
                    manager.negScore += twerkCount
                    manager.negPeakScore += peakTwerkCount
                    console.log("=( =( =( =( twerkcount =( =( =( =( ", twerkCount)
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
        manager.restart()
    }
}

