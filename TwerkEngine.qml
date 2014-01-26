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
            Moment {start: 0;     end: 11944; twerkGoal: 0; twerkPolicy: 0},
            Moment {start: 11944; end: 12294; twerkGoal: 1; twerkPolicy: 3},
            Moment {start: 12294; end: 12781; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 12781; end: 13131; twerkGoal: 1; twerkPolicy: 3},
            Moment {start: 13131; end: 13505; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 13505; end: 13855; twerkGoal: 1; twerkPolicy: 3},
            Moment {start: 13855; end: 14196; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 14196; end: 14546; twerkGoal: 1; twerkPolicy: 3},
            Moment {start: 14546; end: 14862; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 14862; end: 15212; twerkGoal: 1; twerkPolicy: 3},
            Moment {start: 15212; end: 15610; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 15610; end: 15960; twerkGoal: 1; twerkPolicy: 3},
            Moment {start: 15960; end: 16016; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 16016; end: 16366; twerkGoal: 1; twerkPolicy: 3},
            Moment {start: 16366; end: 16419; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 16419; end: 16769; twerkGoal: 1; twerkPolicy: 3},
            Moment {start: 16769; end: 17909; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 17909; end: 18259; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 18259; end: 18621; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 18621; end: 18971; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 18971; end: 19450; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 19450; end: 19800; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 19800; end: 20182; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 20182; end: 20532; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 20532; end: 20818; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 20818; end: 21168; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 21168; end: 21594; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 21594; end: 22289; twerkGoal: 2; twerkPolicy: 1},
            Moment {start: 22289; end: 22373; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 22373; end: 22723; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 22723; end: 23819; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 23819; end: 24169; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 24169; end: 24570; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 24570; end: 24920; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 24920; end: 25323; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 25323; end: 25673; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 25673; end: 26089; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 26089; end: 26439; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 26439; end: 26697; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 26697; end: 27047; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 27047; end: 27548; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 27548; end: 27898; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 27898; end: 27991; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 27991; end: 28341; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 28341; end: 28366; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 28366; end: 28716; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 28716; end: 35619; twerkGoal: 1; twerkPolicy: 0},
            Moment {start: 35619; end: 35969; twerkGoal: 1; twerkPolicy: 3},
            Moment {start: 35969; end: 36350; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 36350; end: 36700; twerkGoal: 1; twerkPolicy: 3},
            Moment {start: 36700; end: 37150; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 37150; end: 37500; twerkGoal: 1; twerkPolicy: 3},
            Moment {start: 37500; end: 37573; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 37573; end: 38297; twerkGoal: 3; twerkPolicy: 3},
            Moment {start: 38297; end: 38633; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 38633; end: 38983; twerkGoal: 1; twerkPolicy: 3},
            Moment {start: 38983; end: 39019; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 39019; end: 39369; twerkGoal: 1; twerkPolicy: 3},
            Moment {start: 39369; end: 39413; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 39413; end: 40425; twerkGoal: 5; twerkPolicy: 3},
            Moment {start: 40425; end: 40442; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 40442; end: 40792; twerkGoal: 1; twerkPolicy: 3},
            Moment {start: 40792; end: 40831; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 40831; end: 41181; twerkGoal: 1; twerkPolicy: 3},
            Moment {start: 41181; end: 41670; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 41670; end: 42020; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 42020; end: 42304; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 42304; end: 42654; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 42654; end: 43059; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 43059; end: 44090; twerkGoal: 4; twerkPolicy: 1},
            Moment {start: 44090; end: 44550; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 44550; end: 44900; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 44900; end: 44936; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 44936; end: 45286; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 45286; end: 45364; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 45364; end: 46691; twerkGoal: 6; twerkPolicy: 1},
            Moment {start: 46691; end: 46772; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 46772; end: 47122; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 47122; end: 47506; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 47506; end: 47856; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 47856; end: 48237; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 48237; end: 48587; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 48587; end: 48977; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 48977; end: 49327; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 49327; end: 49332; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 49332; end: 49993; twerkGoal: 3; twerkPolicy: 1},
            Moment {start: 49993; end: 50445; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 50445; end: 50795; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 50795; end: 50834; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 50834; end: 51184; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 51184; end: 51248; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 51248; end: 52280; twerkGoal: 5; twerkPolicy: 1},
            Moment {start: 52280; end: 52304; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 52304; end: 52989; twerkGoal: 2; twerkPolicy: 1},
            Moment {start: 52989; end: 53538; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 53538; end: 53888; twerkGoal: 1; twerkPolicy: 3},
            Moment {start: 53888; end: 59843; twerkGoal: 1; twerkPolicy: 0},
            Moment {start: 59843; end: 61030; twerkGoal: 6; twerkPolicy: 3},
            Moment {start: 61030; end: 61316; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 61316; end: 62651; twerkGoal: 6; twerkPolicy: 3},
            Moment {start: 62651; end: 63062; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 63062; end: 63412; twerkGoal: 1; twerkPolicy: 3},
            Moment {start: 63412; end: 63783; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 63783; end: 64133; twerkGoal: 1; twerkPolicy: 3},
            Moment {start: 64133; end: 64503; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 64503; end: 64853; twerkGoal: 1; twerkPolicy: 3},
            Moment {start: 64853; end: 65807; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 65807; end: 66926; twerkGoal: 6; twerkPolicy: 1},
            Moment {start: 66926; end: 67211; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 67211; end: 68568; twerkGoal: 7; twerkPolicy: 1},
            Moment {start: 68568; end: 68963; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 68963; end: 69313; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 69313; end: 69733; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 69733; end: 70083; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 70083; end: 70422; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 70422; end: 70772; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 70772; end: 71666; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 71666; end: 72859; twerkGoal: 6; twerkPolicy: 1},
            Moment {start: 72859; end: 73116; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 73116; end: 74575; twerkGoal: 7; twerkPolicy: 1},
            Moment {start: 74575; end: 74929; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 74929; end: 75279; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 75279; end: 75663; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 75663; end: 76013; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 76013; end: 76459; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 76459; end: 76809; twerkGoal: 1; twerkPolicy: 1},
            Moment {start: 76809; end: 83072; twerkGoal: 1; twerkPolicy: 0},
            Moment {start: 83072; end: 83661; twerkGoal: 2; twerkPolicy: 3},
            Moment {start: 83661; end: 83811; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 83811; end: 84302; twerkGoal: 2; twerkPolicy: 3},
            Moment {start: 84302; end: 84567; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 84567; end: 85062; twerkGoal: 2; twerkPolicy: 3},
            Moment {start: 85062; end: 85355; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 85355; end: 85846; twerkGoal: 2; twerkPolicy: 3},
            Moment {start: 85846; end: 86030; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 86030; end: 86616; twerkGoal: 2; twerkPolicy: 3},
            Moment {start: 86616; end: 86783; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 86783; end: 88986; twerkGoal: 10; twerkPolicy: 3},
            Moment {start: 88986; end: 89011; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 89011; end: 89558; twerkGoal: 2; twerkPolicy: 1},
            Moment {start: 89558; end: 89733; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 89733; end: 90212; twerkGoal: 2; twerkPolicy: 1},
            Moment {start: 90212; end: 90449; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 90449; end: 90939; twerkGoal: 2; twerkPolicy: 1},
            Moment {start: 90939; end: 91236; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 91236; end: 91719; twerkGoal: 2; twerkPolicy: 1},
            Moment {start: 91719; end: 91967; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 91967; end: 92499; twerkGoal: 2; twerkPolicy: 1},
            Moment {start: 92499; end: 92634; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 92634; end: 94925; twerkGoal: 11; twerkPolicy: 1},
            Moment {start: 94925; end: 94935; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 94935; end: 95517; twerkGoal: 2; twerkPolicy: 1},
            Moment {start: 95517; end: 95614; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 95614; end: 96213; twerkGoal: 2; twerkPolicy: 1},
            Moment {start: 96213; end: 96422; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 96422; end: 96897; twerkGoal: 2; twerkPolicy: 1},
            Moment {start: 96897; end: 97120; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 97120; end: 97624; twerkGoal: 2; twerkPolicy: 1},
            Moment {start: 97624; end: 97844; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 97844; end: 98336; twerkGoal: 2; twerkPolicy: 1},
            Moment {start: 98336; end: 98596; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 98596; end: 100444; twerkGoal: 9; twerkPolicy: 1},
            Moment {start: 100444; end: 100453; twerkGoal: 1; twerkPolicy: 2},
            Moment {start: 100453; end: 100803; twerkGoal: 1; twerkPolicy: 1}
        ]
    }

    function start() {
        audio.play()
        manager.restart()
    }
}

