import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.12

import sdk.widgets.display 1.0


Item {
    id: btn
    property alias btnText:btnLabel.text
    property alias btnLabel:btnLabel
    property alias btnBg:btnBg
    property alias showBtnBg: btnBg.visible
    property alias btnImageSource: btnImg.source
    property alias btnLabelImage: labelImg
    enabled: true
    signal triggered()
    opacity: !enabled ? 0.75: 1.0
    Rectangle{
        id: btnBg
        anchors.fill: parent
        radius: Display.dp(8)
        color: Common.buttonBgColor
    }
    Row {
        anchors.centerIn: parent
        height: parent.height

        WgtText{
            id: btnLabel
            anchors.verticalCenter: parent.verticalCenter
            color: "white"
        }

        WgtTouchIcon{
            id: labelImg

            anchors.verticalCenter: parent.verticalCenter
            pressEffect: false
            visible: false
        }
    }
    WgtImage{
        id: btnImg
        anchors.centerIn: parent
        visible: source !== ""
    }



    WgtMouseArea{
        anchors.fill: parent
        enabled: parent.enabled
        rectRadius: btnBg.radius
        onCustomClick: triggered()
    }

}
