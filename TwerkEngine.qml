import QtQuick 2.1
import QtSensors 5.0
import QtMultimedia 5.0
import Moments 1.0

Item {
    id: engine
    property alias score: momentManager.score
    property alias negativeScore: momentManager.negativeScore
    property bool twerking: false
    property bool atEnd: manager.momentIndex >= momentManager.moments.length
    onAtEndChanged: {
        if (atEnd)
            audio.stop();
    }

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
                engine.twerking = momentManager.moments[momentIndex].twerkPolicy == 1
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
            Moment {start: 0; end: 17870; twerkGoal: 0; twerkPolicy: 0},
            Moment {start: 17870; end: 18261; twerkGoal: 2; twerkPolicy: 1},
            Moment {start: 18261; end: 18612; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 18612; end: 18962; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 18962; end: 19401; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 19401; end: 19751; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 19751; end: 20193; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 20193; end: 20543; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 20543; end: 20826; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 20826; end: 21176; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 21176; end: 21611; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 21611; end: 21961; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 21961; end: 21978; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 21978; end: 22328; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 22328; end: 22347; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 22347; end: 24133; twerkGoal: 14; twerkPolicy: 1},
            Moment {start: 24133; end: 24550; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 24550; end: 24900; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 24900; end: 25333; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 25333; end: 25683; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 25683; end: 26072; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 26072; end: 26422; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 26422; end: 26808; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 26808; end: 27158; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 27158; end: 27478; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 27478; end: 27828; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 27828; end: 27839; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 27839; end: 28189; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 28189; end: 28302; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 28302; end: 30028; twerkGoal: 14; twerkPolicy: 1},
            Moment {start: 30028; end: 41628; twerkGoal: 1; twerkPolicy: 0},
            Moment {start: 41628; end: 41978; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 41978; end: 42344; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 42344; end: 42694; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 42694; end: 43079; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 43079; end: 43429; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 43429; end: 43507; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 43507; end: 44164; twerkGoal: 4; twerkPolicy: 1},
            Moment {start: 44164; end: 44540; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 44540; end: 44890; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 44890; end: 44938; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 44938; end: 45288; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 45288; end: 45368; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 45368; end: 46404; twerkGoal: 5; twerkPolicy: 1},
            Moment {start: 46404; end: 46464; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 46464; end: 46814; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 46814; end: 46855; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 46855; end: 47205; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 47205; end: 47531; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 47531; end: 47881; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 47881; end: 48244; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 48244; end: 48594; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 48594; end: 48982; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 48982; end: 49332; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 49332; end: 49422; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 49422; end: 50097; twerkGoal: 4; twerkPolicy: 1},
            Moment {start: 50097; end: 50473; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 50473; end: 50823; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 50823; end: 50825; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 50825; end: 51175; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 51175; end: 51232; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 51232; end: 52302; twerkGoal: 6; twerkPolicy: 1},
            Moment {start: 52302; end: 52355; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 52355; end: 52705; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 52705; end: 52732; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 52732; end: 53082; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 53082; end: 65680; twerkGoal: 1; twerkPolicy: 0},
            Moment {start: 65680; end: 66892; twerkGoal: 6; twerkPolicy: 1},
            Moment {start: 66892; end: 67132; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 67132; end: 68631; twerkGoal: 7; twerkPolicy: 1},
            Moment {start: 68631; end: 69012; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 69012; end: 69362; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 69362; end: 69680; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 69680; end: 70030; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 70030; end: 70414; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 70414; end: 70764; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 70764; end: 71645; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 71645; end: 72908; twerkGoal: 6; twerkPolicy: 1},
            Moment {start: 72908; end: 73121; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 73121; end: 74600; twerkGoal: 8; twerkPolicy: 1},
            Moment {start: 74600; end: 74981; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 74981; end: 75331; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 75331; end: 75638; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 75638; end: 75988; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 75988; end: 76457; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 76457; end: 76807; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 76807; end: 89032; twerkGoal: 1; twerkPolicy: 0},
            Moment {start: 89032; end: 89575; twerkGoal: 2; twerkPolicy: 1},
            Moment {start: 89575; end: 89778; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 89778; end: 90317; twerkGoal: 2; twerkPolicy: 1},
            Moment {start: 90317; end: 90617; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 90617; end: 91149; twerkGoal: 2; twerkPolicy: 1},
            Moment {start: 91149; end: 91260; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 91260; end: 91843; twerkGoal: 2; twerkPolicy: 1},
            Moment {start: 91843; end: 91990; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 91990; end: 92566; twerkGoal: 2; twerkPolicy: 1},
            Moment {start: 92566; end: 92731; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 92731; end: 94547; twerkGoal: 9; twerkPolicy: 1},
            Moment {start: 94547; end: 94550; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 94550; end: 94900; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 94900; end: 94949; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 94949; end: 95502; twerkGoal: 2; twerkPolicy: 1},
            Moment {start: 95502; end: 95644; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 95644; end: 96143; twerkGoal: 2; twerkPolicy: 1},
            Moment {start: 96143; end: 96499; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 96499; end: 96985; twerkGoal: 2; twerkPolicy: 1},
            Moment {start: 96985; end: 97157; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 97157; end: 97648; twerkGoal: 2; twerkPolicy: 1},
            Moment {start: 97648; end: 97864; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 97864; end: 98464; twerkGoal: 2; twerkPolicy: 1},
            Moment {start: 98464; end: 98619; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 98619; end: 100811; twerkGoal: 10; twerkPolicy: 1}
        ]
    }

    function start() {
        audio.play()
        manager.restart()
    }
}

