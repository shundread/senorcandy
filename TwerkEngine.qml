import QtQuick 2.1
import QtSensors 5.0
import QtMultimedia 5.0
import Moments 1.0

Item {
    id: engine
    property alias score: momentManager.score
    property alias negativeScore: momentManager.negativeScore

    signal moved()

    Timer {
        id: manager
        property int ticks: 0

        // Moments
        property int momentIndex: 0

        interval: 100
        running: false
        repeat: true

        onRunningChanged: {
            if(running == true)
                momentManager.moments[0].on = true
            //else
            //    repeat = true
        }

        onTriggered: {
            ticks++
            var currentTime = time()
            //console.log("currentTime: ", currentTime)

            // Advancing through the moments
            while(momentIndex < momentManager.moments.length &&
                  currentTime >= momentManager.moments[momentIndex].end)
            {
                momentManager.moments[momentIndex].on=false
                momentIndex++
                console.log("momentIndex is now", momentIndex)
                if(momentIndex >= momentManager.moments.length)
                {
                    console.log("End of the game/stage")
                    console.log("Your final score was:", score)
                    console.log("Your final negScore was:", negScore)
                    console.log("Your final peakScore was:", peakScore)
                    console.log("Your final negPeakScore was:", negPeakScore)
                    repeat = false
                    return
                }
                momentManager.moments[momentIndex].on=true
            }
        }

        function time() {
            //return music.position
            return ticks * interval
        }

        function restart() {
            ticks = 0;
            momentIndex = 0;
            momentManager.resetScore();
            running = true;
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
        //onReadingChanged: console.log("Reading changed", reading.x, reading.y, reading.z)
    }

    MomentManager {
        id: momentManager
        onMoved: if (manager.running) engine.moved()
        sensor: accelerometer
        moments: [
            // Intro
            Moment {start: 0; end: 17988; twerkGoal: 0; twerkPolicy: 0},
            Moment {start: 17988; end: 18288; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 18288; end: 18827; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 18827; end: 19127; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 19127; end: 19511; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 19511; end: 19811; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 19811; end: 20278; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 20278; end: 20578; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 20578; end: 20901; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 20901; end: 21201; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 21201; end: 21659; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 21659; end: 21959; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 21959; end: 22088; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 22088; end: 22388; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 22388; end: 22532; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 22532; end: 22832; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 22832; end: 23934; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 23934; end: 24234; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 24234; end: 24650; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 24650; end: 24950; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 24950; end: 25400; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 25400; end: 25700; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 25700; end: 26195; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 26195; end: 26495; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 26495; end: 26833; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 26833; end: 27133; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 27133; end: 27626; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 27626; end: 27926; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 27926; end: 27963; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 27963; end: 28263; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 28263; end: 28467; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 28467; end: 28767; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 28767; end: 41658; twerkGoal: 1; twerkPolicy: 0},
            Moment {start: 41658; end: 41958; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 41958; end: 42389; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 42389; end: 42689; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 42689; end: 43226; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 43226; end: 43526; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 43526; end: 43615; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 43615; end: 44264; twerkGoal: 3; twerkPolicy: 1},
            Moment {start: 44264; end: 44651; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 44651; end: 44951; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 44951; end: 45022; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 45022; end: 45322; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 45322; end: 45417; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 45417; end: 46495; twerkGoal: 5; twerkPolicy: 1},
            Moment {start: 46495; end: 46576; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 46576; end: 46876; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 46876; end: 46942; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 46942; end: 47242; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 47242; end: 47607; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 47607; end: 47907; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 47907; end: 48323; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 48323; end: 48623; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 48623; end: 49107; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 49107; end: 49407; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 49407; end: 49527; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 49527; end: 50147; twerkGoal: 3; twerkPolicy: 1},
            Moment {start: 50147; end: 50591; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 50591; end: 50891; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 50891; end: 50969; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 50969; end: 51269; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 51269; end: 51330; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 51330; end: 52380; twerkGoal: 5; twerkPolicy: 1},
            Moment {start: 52380; end: 52453; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 52453; end: 52753; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 52753; end: 52824; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 52824; end: 53124; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 53124; end: 65810; twerkGoal: 1; twerkPolicy: 0},
            Moment {start: 65810; end: 67042; twerkGoal: 6; twerkPolicy: 1},
            Moment {start: 67042; end: 67305; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 67305; end: 68692; twerkGoal: 7; twerkPolicy: 1},
            Moment {start: 68692; end: 69145; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 69145; end: 69445; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 69445; end: 69833; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 69833; end: 70133; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 70133; end: 70561; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 70561; end: 70861; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 70861; end: 71723; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 71723; end: 72899; twerkGoal: 6; twerkPolicy: 1},
            Moment {start: 72899; end: 73241; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 73241; end: 74635; twerkGoal: 7; twerkPolicy: 1},
            Moment {start: 74635; end: 75046; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 75046; end: 75346; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 75346; end: 75764; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 75764; end: 76064; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 76064; end: 76456; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 76456; end: 76756; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 76756; end: 89114; twerkGoal: 1; twerkPolicy: 0},
            Moment {start: 89114; end: 89624; twerkGoal: 2; twerkPolicy: 1},
            Moment {start: 89624; end: 89878; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 89878; end: 90404; twerkGoal: 2; twerkPolicy: 1},
            Moment {start: 90404; end: 90610; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 90610; end: 91036; twerkGoal: 2; twerkPolicy: 1},
            Moment {start: 91036; end: 91384; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 91384; end: 91809; twerkGoal: 2; twerkPolicy: 1},
            Moment {start: 91809; end: 92080; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 92080; end: 92557; twerkGoal: 2; twerkPolicy: 1},
            Moment {start: 92557; end: 92802; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 92802; end: 94384; twerkGoal: 8; twerkPolicy: 1},
            Moment {start: 94384; end: 94404; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 94404; end: 94704; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 94704; end: 94744; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 94744; end: 95525; twerkGoal: 3; twerkPolicy: 1},
            Moment {start: 95525; end: 95743; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 95743; end: 96304; twerkGoal: 2; twerkPolicy: 1},
            Moment {start: 96304; end: 96452; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 96452; end: 96988; twerkGoal: 2; twerkPolicy: 1},
            Moment {start: 96988; end: 97280; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 97280; end: 97757; twerkGoal: 2; twerkPolicy: 1},
            Moment {start: 97757; end: 98007; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 98007; end: 98516; twerkGoal: 2; twerkPolicy: 1},
            Moment {start: 98516; end: 98695; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 98695; end: 100569; twerkGoal: 9; twerkPolicy: 1},
            Moment {start: 100569; end: 100622; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 100622; end: 101000; twerkGoal: 1; twerkPolicy: 0}
        ]
    }

    function start() {
        audio.play()
        manager.restart()
    }
}

