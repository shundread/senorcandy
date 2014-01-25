import QtQuick 2.1
import QtSensors 5.0
import QtMultimedia 5.0

Item {
    Timer {
        id: manager
        property int ticks: 0
        property var moments: []
        interval: 100
        running: true
        repeat: true
        Component.onCompleted: start()
        onTriggered: {
            switch (ticks++) {
            case 50:
                moments[0].on = true;
                break;
            case 100:
                moments[0].on = false;
                break;
            default:
                break;
            }
        }
    }

    Audio {
        id: audio
        source: "audio/track1.wav"
        Component.onCompleted: play()
    }

    Accelerometer {
        id: accelerometer
        property vector3d previous
        onReadingChanged: previous = reading
    }

    Instantiator {
        model: 2
        delegate: QtObject {
            id: moment
            property alias on: binding.when
            property real twerks: 2
            property real tolerance: 0.5
            property real amplitude
            property int samples
            property vector3d previousValue
            property vector3d value
            onValueChanged: {
                if (value.dotProduct(previousValue) < 0) {
                    console.log('change in direction, average accel:', amplitude/samples)
                    amplitude = 0;
                    samples = 0;
                }
                previousValue = value;
                amplitude += value.length();
                ++samples;
            }

            property Binding binding: Binding {
                id: binding
                when: true//false
                target: moment
                property: "value"
                value: accelerometer.reading
            }
        }
        onObjectAdded: manager.moments = manager.moments.concat(object)
    }
}
