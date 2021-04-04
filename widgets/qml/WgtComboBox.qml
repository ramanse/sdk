import QtQuick 2.13
import QtGraphicalEffects 1.13
import QtQuick.Controls 2.12

import sdk.widgets.display 1.0

ComboBox {
    id: control
    property var headerText: "Type"
    delegate: ItemDelegate {
        width: control.width
        contentItem: WgtText {
            text: modelData
            elide: Text.ElideRight
            verticalAlignment: Text.AlignVCenter
        }
        highlighted: control.highlightedIndex === index
    }

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
            color: Common.themeColor
        }
    }

    indicator: Canvas {
        id: canvas
        x: control.width - width - control.rightPadding
        y: control.topPadding + (control.availableHeight - height) / 2
        width: 12
        height: 8
        contextType: "2d"

        Connections {
            target: control
            onPressedChanged: canvas.requestPaint()
        }

        onPaint: {
            context.reset();
            context.moveTo(0, 0);
            context.lineTo(width, 0);
            context.lineTo(width / 2, height);
            context.closePath();
            context.fillStyle = control.pressed ? "#ffffff" : Common.themeColor;
            context.fill();
        }
    }

    contentItem: WgtText {
        leftPadding: Display.dp(8)
        rightPadding: control.indicator.width + control.spacing
        text: control.displayText
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    background: Rectangle {
        implicitWidth: 120
        implicitHeight: 40
        border.color: control.pressed ? "#ffffff" : Common.themeColor
        border.width: control.visualFocus ? 2 : 1
        radius: Display.dp(10)
    }

    popup: Popup {
        y: control.height - 1
        width: control.width
        implicitHeight: contentItem.implicitHeight
        padding: 1

        contentItem: ListView {
            clip: true
            implicitHeight: contentHeight
            model: control.popup.visible ? control.delegateModel : null
            currentIndex: control.highlightedIndex

            ScrollIndicator.vertical: ScrollIndicator { }
        }

        background: Rectangle {
            border.color: Common.themeColor
            radius: Display.dp(3)
        }
    }
}
