import QtQuick 2.13
import QtQuick.Controls 2.12
import QtQuick.Window 2.13
import QtQuick.Layouts 1.12

import sdk.widgets.display 1.0
import sdk.widgets 1.0

ApplicationWindow {
    id: dbgWindow
    visible: true
    title: qsTr("DinaNityaDinasi")
    width: 800
    height: 600

    ButtonGroup {
        id: dispSetting
        onCheckedButtonChanged: {
            if (dispSetting.checkedButton &&  dispSetting.checkedButton.orientationType) {
                Display.changeDisplayOrientation(dispSetting.checkedButton.currentIndex);

            }
            else if (dispSetting.checkedButton) {
                Display.changeDisplay(dispSetting.checkedButton.currentIndex);

            }
        }
    }
    ButtonGroup {
        id: orientSetting
        onCheckedButtonChanged: {
            if (orientSetting.checkedButton) {
                Display.changeDisplayOrientation(orientSetting.checkedButton.currentIndex);

            }
        }
    }

    Item {
        anchors.fill: parent
        Rectangle {
            id: hLabel
            anchors.top: parent.top
            width: parent.width
            height: 60
            border.color: "#b0b0b0"
            border.width: 3
            color: "#eaeaea"

            WgtText {
                id: devices
                width: parent.width / 2
                horizontalAlignment: Text.AlignHCenter
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                text: "Devices"
            }
            WgtText {
                id: orientation
                width: parent.width / 2
                horizontalAlignment: Text.AlignHCenter
                anchors.left: devices.right
                anchors.verticalCenter: parent.verticalCenter
                text: "Orientation"
            }

        }

        Flickable {
            flickableDirection: Flickable.VerticalFlick
            boundsBehavior: Flickable.StopAtBounds
            width: parent.width
            height: 800
            anchors.top: hLabel.bottom
            contentHeight: gLayout.height
            clip: true
            ScrollBar.vertical: ScrollBar {
                active: true

                onActiveChanged: {
                    if (!active)
                        active = true;
                }
            }

            GridLayout {
                id: gLayout
                width: parent.width - 200
                height: childrenRect.height
                anchors.horizontalCenter: parent.horizontalCenter
                rows: 1
                columns: 2
                columnSpacing: 150

                ColumnLayout {
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    Repeater{
                        model: Display.displaySettings.length
                        RadioButton{
                            text: Display.displaySettings[index].deviceName
                            height: 80
                            font.family: Common.font
                            font.pixelSize: 22
                            property int currentIndex: index
                            checked: index == 9
                            ButtonGroup.group: dispSetting
                        }
                    }
                }
                ColumnLayout {
                    Layout.fillWidth: true
                    height: 160
                    Layout.alignment: Qt.AlignTop

                    Repeater{
                        model: 2

                        RadioButton{
                            text: index == 0 ? "Portrait" : "Landscape"
                            height: 80
                            font.family: Common.font
                            font.pixelSize: 22
                            checked: index == 0
                            property int currentIndex: index
                            ButtonGroup.group: orientSetting
                        }
                    }
                }
            }

        }
    }

    Component.onCompleted: show()
}
