import QtQuick 2.13
import QtQuick.Controls 2.12
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.12

import sdk.widgets.display 1.0


WgtText {
    id: login
    signal linkTriggered();
    wrapMode: Text.WordWrap
    textFormat: Text.RichText;
    text:"<a href='http://'> Login? </a>" +" or " + "<a href='http://'>Password recovery</a>"
    font.pixelSize: Display.sp(16)
    font.italic: true
    opacity: 0.65
    horizontalAlignment: Text.AlignHCenter
    onLinkActivated: {
        linkTriggered();
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.NoButton // we don't want to eat clicks on the Text
        cursorShape: parent.hoveredLink ? Qt.PointingHandCursor : Qt.ArrowCursor

    }

}
