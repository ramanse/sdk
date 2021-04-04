import QtQuick 2.13
import QtGraphicalEffects 1.13

import sdk.widgets.display 1.0


Item {
    id: btn
    property alias icon: _icon
    property alias bg: _bg
    property color colorizeTo: "white"
    property alias isShowBadge: _badge.visible
    property alias badgeText: _badgeText.text
    property bool pressEffect: true
    signal triggered()
    signal longPressed();
    width: _icon.width
    height: _icon.height

    Rectangle{
        id: _bg
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            bottom: parent.bottom
            margins: Display.dp(-10)
        }

        opacity: 0
        color: "#00f600"
        Behavior on opacity {
            NumberAnimation{}
        }
    }
    Image {
        id: _icon
        width: Display.dpForAsset(sourceSize.width)
        height: Display.dpForAsset(sourceSize.height)
        anchors.centerIn: parent
        mipmap: true
        layer.enabled: true
        layer.effect: ColorOverlay {
            color: colorizeTo
        }
    }

    Behavior on scale{
        NumberAnimation{}
    }
    Rectangle {
        id: _badge
        width: Display.dp(30)
        height: width
        anchors.right: parent.right
        anchors.rightMargin: Display.dp(-5)
        anchors.top: parent.top
        anchors.topMargin: Display.dp(-7)
        radius: width / 2
        color: Common.buttonBgColor
        border.color: "#ffffff"
        visible: false
        border.width: 1
        WgtText {
            id: _badgeText
            anchors.centerIn: parent
            font.pixelSize: Display.sp(14)
            font.bold: true
            color:  "#ffffff"
        }
    }
    MouseArea{
        anchors.fill: parent
        onPressed: {
            _bg.opacity = 0.12 && pressEffect
        }
        onReleased: {
            _bg.opacity = 0.0 && pressEffect
            triggered()
        }
        onPressAndHold :  { longPressed(); }
    }
}
