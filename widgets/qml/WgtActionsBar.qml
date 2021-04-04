import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQml.Models 2.12

import sdk.widgets.display 1.0

Rectangle {
    id: root
    width: parent.width
    height: Display.dp(100)
    anchors.left: parent.left
    property var actionsModel: buttonsModel
    ObjectModel {
        id: buttonsModel
        WgtSearchBar {

        }
    }
    ListView{
        id: view
        height: parent.height - Display.dp(20)
        clip: true
        width: parent.width
        anchors.centerIn: parent
        model: actionsModel
        orientation: ListView.Horizontal
        spacing: Display.dp(20)

    }

}
