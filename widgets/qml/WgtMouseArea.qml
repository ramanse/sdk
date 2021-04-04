import QtQuick 2.13
import sdk.widgets.display 1.0

MouseArea {
    id: mouseArea
    width: 200
    height: 200
    property real rectRadius: 0.0
    signal customClick()
    Rectangle {
        id: redRect
        anchors.fill: parent
        color: Common.themeColor
        anchors.centerIn: parent
        radius: radiusFactor
        opacity: opacityFactor
        clip: true
        property real opacityFactor: 0.0
        property real radiusFactor : rectRadius

    }
    states: [
        State {
            name: "pressed"; when: mouseArea.pressed
            PropertyChanges { target: redRect; opacityFactor: 0.25 }

        }
    ]

    transitions:
        Transition {
        from: "pressed"; to: "*"
        SequentialAnimation {
            ParallelAnimation {
                NumberAnimation {
                    target: redRect
                    property: "radiusFactor";
                    from: redRect.width/2
                    to: redRect.width
                    easing.type: Easing.InOutQuad;
                    duration: 200;
                }
                NumberAnimation {
                    target: redRect
                    property: "scale";
                    from: 0.5
                    to: 1.0
                    easing.type: Easing.InOutQuad;
                    duration: 200;
                }
                NumberAnimation {
                    target: redRect
                    property: "opacityFactor";
                    from: 0.4
                    to: 0.0
                    easing.type: Easing.InOutQuad;
                    duration: 200;
                }



            }
            ScriptAction { script: {
                    redRect.opacityFactor = 0;
                    redRect.scale = 1.0;
                    redRect.radiusFactor = rectRadius;
                    mouseArea.customClick();
                } }
        }
    }


}
