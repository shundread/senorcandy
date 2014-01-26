import QtQuick 2.0

Item {

    property alias transitionDuration: defaultTransition.duration

    Image {
        id: image1
        x: 8
        y: 402
        source: "images/leftleg.png"
    }

    Image {
        id: image3
        x: 53
        y: 271
        source: "images/leftthigh.png"
    }

    Image {
        id: image2
        x: 191
        y: 402
        source: "images/rightleg.png"
    }

    Image {
        id: image4
        x: 163
        y: 264
        source: "images/righthigh.png"
    }

    Image {
        id: image6
        x: -69
        y: 135
        source: "images/leftarm.png"
    }

    Image {
        id: image5
        x: -142
        y: 131
        source: "images/lefthand.png"
    }

    Image {
        id: image7
        x: 326
        y: 106
        source: "images/rightarm.png"
    }

    Image {
        id: image8
        x: 396
        y: 62
        source: "images/righthand.png"
    }

    Image {
        id: torso
        x: 0
        y: 0
        source: "images/torso.png"
    }

    Image {
        id: image9
        x: 64
        y: -125
        source: "images/head.png"
    }

    Image {
        id: image10
        x: 91
        y: 234
        source: "images/crotch.png"
    }
    states: [
        State {
            name: "crouch"

            PropertyChanges {
                target: image1
                x: -17
                y: 337
            }

            PropertyChanges {
                target: image2
                x: 239
                y: 337
            }

            PropertyChanges {
                target: image3
                x: 50
                y: 239
                rotation: 33
            }

            PropertyChanges {
                target: image4
                x: 175
                y: 232
                rotation: -36
            }

            PropertyChanges {
                target: image5
                x: -32
                y: 242
                rotation: -112
            }

            PropertyChanges {
                target: image6
                x: -43
                y: 162
                rotation: -73
            }

            PropertyChanges {
                target: image7
                x: 291
                y: 159
                rotation: 81
            }

            PropertyChanges {
                target: image8
                x: 337
                y: 215
                rotation: 102
            }

            PropertyChanges {
                target: image9
                x: 89
                y: -122
                rotation: 25
            }
        },
        State {
            name: "stand"
            PropertyChanges {
                target: image1
                x: 58
                y: 397
            }

            PropertyChanges {
                target: image2
                x: 210
                y: 403
                rotation: -18
            }

            PropertyChanges {
                target: image3
                x: 76
                y: 263
                rotation: -15
            }

            PropertyChanges {
                target: image4
                x: 159
                y: 256
                rotation: 2
            }

            PropertyChanges {
                target: image5
                x: -90
                y: 47
                rotation: 112
            }

            PropertyChanges {
                target: image6
                x: -71
                y: 110
                rotation: 37
            }

            PropertyChanges {
                target: image7
                x: 317
                y: 99
                rotation: -11
            }

            PropertyChanges {
                target: image8
                x: 357
                y: 42
                rotation: -42
            }

            PropertyChanges {
                target: image9
                x: 41
                y: -124
                rotation: -25
            }
        },
        State {
            name: "armscrossed"
            PropertyChanges {
                target: image1
                x: -11
                y: 339
            }

            PropertyChanges {
                target: image2
                x: 242
                y: 368
                rotation: -18
            }

            PropertyChanges {
                target: image3
                x: 54
                y: 245
                rotation: 28
            }

            PropertyChanges {
                target: image4
                x: 171
                y: 250
                rotation: -21
            }

            PropertyChanges {
                target: image5
                x: 85
                y: 82
                z: 1
                rotation: 151
            }

            PropertyChanges {
                target: image6
                x: 4
                y: 116
                z: 1
                rotation: 158
            }

            PropertyChanges {
                target: image7
                x: 239
                y: 91
                z: 1
                rotation: -122
            }

            PropertyChanges {
                target: image8
                x: 178
                y: 60
                z: 1
                rotation: -120
            }

            PropertyChanges {
                target: image9
                x: 83
                y: -104
                rotation: 25
            }
        },
        State {
            name: "chill"

            PropertyChanges {
                target: torso
                x: 10
                y: -1
                rotation: -5
            }

            PropertyChanges {
                target: image10
                x: 106
                y: 228
                rotation: 5
            }

            PropertyChanges {
                target: image3
                x: 70
                y: 251
            }

            PropertyChanges {
                target: image4
                x: 177
                y: 258
            }

            PropertyChanges {
                target: image1
                x: 24
                y: 381
            }

            PropertyChanges {
                target: image2
                x: 211
                y: 403
            }

            PropertyChanges {
                target: image6
                x: -45
                y: 167
                rotation: -37
            }

            PropertyChanges {
                target: image5
                x: -112
                y: 191
            }

            PropertyChanges {
                target: image7
                x: 318
                y: 74
                rotation: -31
            }

            PropertyChanges {
                target: image8
                x: 352
                y: 6
                rotation: -34
            }

            PropertyChanges {
                target: image9
                x: 70
                y: -121
                rotation: 4
            }

        },
        State {
            name: "jump"

            PropertyChanges {
                target: image3
                x: 39
                y: 227
                rotation: 56
            }

            PropertyChanges {
                target: image10
                x: 91
                y: 212
            }

            PropertyChanges {
                target: torso
                x: 0
                y: 13
            }

            PropertyChanges {
                target: image9
                x: 64
                y: -97
            }

            PropertyChanges {
                target: image6
                x: -63
                y: 105
                rotation: 53
            }

            PropertyChanges {
                target: image5
                x: -122
                y: 62
            }

            PropertyChanges {
                target: image7
                x: 298
                y: 95
                rotation: -43
            }

            PropertyChanges {
                target: image8
                x: 340
                y: 38
            }

            PropertyChanges {
                target: image4
                x: 179
                y: 210
                rotation: -47
            }

            PropertyChanges {
                target: image2
                x: 343
                y: 224
                rotation: -92
            }

            PropertyChanges {
                target: image1
                x: -136
                y: 199
                rotation: 88
            }
        }
    ]
    transitions: Transition {
        NumberAnimation { id: defaultTransition; properties: "x,y,rotation"; duration: 1000; easing.type: Easing.InOutQuad }
    }
}
