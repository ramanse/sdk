import QtQuick 2.12
import QtQuick.Layouts 1.12
import sdk.widgets.display 1.0


Rectangle {
    id: root
    width: 0
    height: parent.height
    anchors.left: parent.left
    property real openWidth: parent.width - Display.dp(106)
    property var actionModel
    property bool showHightlight: false
    property bool autoClose: true
    readonly property bool isOpen: state === "open"
    property string selectedTextColor: Common.themeColor
    property string textColor: "#414141"
    color: "#ffffff"
    function open() {
        state = "open"
    }
    function close() {
        state = "close"
    }
    Rectangle {
        id: header
        width: parent.width
        height: Display.dp(160)
        anchors.top: parent.top
        color: Common.themeColor
        visible: isOpen
        WgtTouchIcon {
            id: logo
            anchors.left: parent.left
            anchors.leftMargin: Display.dp(16)
            anchors.verticalCenter: title.verticalCenter
            anchors.verticalCenterOffset: Display.dp(-8)
            icon.source: Common.getQrcIcon("icon_dndLogo")
        }

        WgtText {
            id: title
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: logo.right
            anchors.leftMargin: Display.dp(8)
            color: "#ffffff"
            text: Common.titleText
        }

    }
    ListView{
        id: view
        anchors.top: header.bottom
        anchors.bottom: parent.bottom
        clip: true
        width: parent.width
        anchors.horizontalCenter: parent.horizontalCenter
        model: actionModel.length
        interactive: contentHeight > height
        visible: isOpen
        delegate: Item {
            id: _actionsDelegate
            width: parent.width
            height: Display.dp(64)

            property string colorize: view.currentIndex === index && showHightlight?
                                          selectedTextColor : textColor
            Rectangle {
                width: parent.width - Display.dp(16)
                height: parent.height
                anchors.centerIn: parent
                color: _actionsDelegate.colorize
                opacity: 0.12
                radius: Display.dp(5)
                visible: (mArea.containsMouse) && showHightlight
            }
            Row {
                width: parent.width - Display.dp(32)
                height: Display.dp(24)
                anchors.centerIn: parent
                spacing: Display.dp(24)
                WgtTouchIcon{
                    anchors.verticalCenter: actionText.verticalCenter
                    icon.source: Common.getQrcIcon(actionModel[index].icon)
                    colorizeTo: _actionsDelegate.colorize
                    icon.width: Display.dp(36)
                    icon.height: Display.dp(36)
                }
                WgtText {
                    id: actionText
                    text: actionModel[index].name
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: Display.sp(16)
                    color: _actionsDelegate.colorize
                }
            }
            MouseArea{
                id: mArea
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    view.currentIndex = index;
                    actionModel[index].action();
                    if (autoClose)
                        close();
                }
            }
        }
    }

    state: "close"
    states: [
        State {
            name : "open"
            PropertyChanges {
                target: root
                width: openWidth
            }
        },
        State {
            name : "close"
            PropertyChanges {
                target: root
                width: 0
            }
        }

    ]
    transitions: Transition {
        NumberAnimation { properties: "width"; easing.type: Easing.InOutQuad }
    }
}
