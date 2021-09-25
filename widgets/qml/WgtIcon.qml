import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQml.Models 2.12

import sdk.widgets.display 1.0

WgtTouchIcon {
    id: searchIconItem
    property var iconName: "icon_search"
    anchors.verticalCenter: parent.verticalCenter
    colorizeTo: "#565959"
    pressEffect: false
    icon.source: Common.getQrcIcon(iconName)
}
