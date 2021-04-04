import QtQuick 2.13
import QtQuick.Controls 2.13
import sdk.widgets.display 1.0

TabButton {
    id: control
    contentItem: Text {
            text: control.text
            font.family: Common.font
            font.pixelSize : Display.sp(21)
            color: control.checked ? "#ffffff" : Common.bgColor
            opacity: enabled ? 1.0 : 0.3
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }

        background: Rectangle {
            anchors.fill: parent
            radius: Display.dp(8)
            color: control.checked ? Common.bgColor : "transparent"
            opacity: enabled ? 1 : 0.3
        }

}
