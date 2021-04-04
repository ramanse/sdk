import QtQuick 2.13
import QtQuick.Controls 2.12

import sdk.widgets.display 1.0

BusyIndicator {
    width: Display.dp(150)
    height: Display.dp(150)
    property string baseColor: "#ffffff"
    Component.onCompleted: {
        contentItem.pen = "transparent"
        contentItem.fill = baseColor !== Common.themeColor ? Common.themeColor : "#ffffff"
    }
}
