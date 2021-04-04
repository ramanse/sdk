import QtQuick 2.13

import QtQuick.Controls 2.13
import QtQuick.Layouts 1.12

import sdk.widgets.display 1.0


Rectangle {
    id: delegate
    width: parent.width - Display.dp(16)
    height: Display.dp(185)
    anchors.horizontalCenter: parent.horizontalCenter
    color: "#f8f8f8"

    Rectangle{
        opacity: 0.65
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            bottom: parent.bottom
            leftMargin: 1
            rightMargin: 1
            topMargin: 4
            bottomMargin: 4
        }
        border.color: "#eeeeee"
        border.width: 0.5
        radius: Display.dp(10)
    }

}
