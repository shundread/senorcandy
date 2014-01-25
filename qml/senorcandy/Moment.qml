import QtQuick 2.0

QtObject {
    property int start
    property int end
    property real twerks
    property real threshold
    property vector3d oldSample: Qt.vector3d(0, 0, 0)

    function handleSample(newSample) {
        console.log("New sample")
        if(newSample.dotProduct(oldSample) < 0 && newSample.length > threshold)
            console.log("direction change")
        oldSample = newSample
    }
}
