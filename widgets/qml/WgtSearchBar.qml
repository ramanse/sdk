import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQml.Models 2.12

import sdk.widgets.display 1.0

Rectangle {
    id: searchBar
    property alias searchFieldText: disableText.text
    property alias searchText: textInput.displayText
    property alias showSearchIcon: searchIconItem.visible
    property var iconScale: 1.0
    radius:  Display.dp(10)
    color: "white"
    border.color: Common.themeColor
    border.width: 1
    WgtTouchIcon {
        id: searchIconItem
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin:  Display.dp(16)
        colorizeTo: "#565959"
        pressEffect: false
        scale: iconScale
        icon.source: Common.getQrcIcon("icon_search")
    }

    WgtText {
        id: disableText
        color: "#565959"
        anchors.left: searchIconItem.visible? searchIconItem.right : parent.left
        anchors.leftMargin:  Display.dp(8)
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: Display.sp(20)
        text: qsTr("Search")
        visible: textInput.displayText === ""
    }
    TextInput {
        id: textInput
        text: ""
        anchors.left: disableText.left
        anchors.right: deleteIcon.left
        height: parent.height
        anchors.verticalCenter: parent.verticalCenter
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        cursorVisible: false
        font.family: Common.font
        font.pixelSize: Display.sp(20)

    }
    WgtTouchIcon {
        id: deleteIcon
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin:  Display.dp(16)
        visible: textInput.displayText.length > 0
        colorizeTo: Common.themeColor
        pressEffect: false
        icon.source: Common.getQrcIcon("icon_backspace")
        scale: iconScale
        onTriggered: {
            textInput.remove(textInput.cursorPosition - 1,textInput.cursorPosition)
        }
        onLongPressed: {
            textInput.clear();
        }
    }

}
