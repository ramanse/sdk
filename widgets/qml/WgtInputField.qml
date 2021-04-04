import QtQuick 2.13
import QtQuick.Layouts 1.12

import sdk.widgets.display 1.0


Item {
    id: root
    width: Display.dp(200)
    height: Display.dp(60)

    property string headerText: "Enter text"
    property string bgBorderColor: "#000000"
    property string headerTxtColor: Common.themeColor
    property bool showPreffix: false
    property alias preffixText: preffix.text
    property alias textInput: textInput
    property Component suffixComponent
    readonly property var suffixContent: suffixIconLoader.item

    Rectangle {
        width: parent.width
        height: parent.height - txtField.height/2
        anchors.centerIn: parent
        radius: Display.dp(8)
        border.color: bgBorderColor
        border.width: 0.65

        Rectangle{
            id: txtField
            height: headerLabel.contentHeight
            width: headerLabel.contentWidth  + Display.dp(16)
            anchors.verticalCenter: parent.top
            anchors.left: parent.left
            anchors.leftMargin: Display.dp(16)
            WgtText {
                id: headerLabel
                text: headerText
                anchors.centerIn: parent
                font.italic: true
                font.pixelSize: Display.dp(18)
                color: headerTxtColor
            }
        }

        RowLayout {
            id: inputRow
            width: parent.width - Display.dp(16)
            height: parent.height
            anchors.centerIn: parent

            WgtText {
                id: preffix
                Layout.fillWidth: true
                visible: showPreffix
                text: ""
            }

            TextInput {
                id: textInput
                Layout.fillWidth: true
                text: ""
                Layout.preferredWidth: parent.width
                Layout.preferredHeight: parent.height - Display.dp(16)
                Layout.maximumHeight: parent.height  - Display.dp(16)
                Layout.maximumWidth: parent.width
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                onTextChanged:  {
                    if ((contentWidth + 40) > root.width) {
                        textInput.maximumLength = textInput.text.length
                    }
                }
                padding: 1
                wrapMode: Text.WordWrap
                clip: true
                cursorVisible: false
                font.family: Common.font
                font.pixelSize: Display.sp(22)
                TextMetrics {
                    id: metrics
                    font: textInput.font
                    text: textInput.text
                    elideWidth: textInput.width - 5
                }
            }

        }

        Loader {
            id: suffixIconLoader
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: Display.dp(16)
            active: suffixComponent !== null
            sourceComponent: suffixComponent
            visible: active
            width: Display.dp(35)
            height: Display.dp(35)
        }
    }

}
