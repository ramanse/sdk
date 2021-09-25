import QtQuick 2.13
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12



Rectangle {
    id: root
    color: "#f8f8f8"
    property alias pageContent: pageLoader.sourceComponent
    property alias content: pageLoader.item
    property alias headerContent: headerLoader.item
    signal showPopup(var component)
    signal closePopup()
    signal refresh();
    signal back();
    signal contentLoaded();
    property bool enableBusyTimer: true
    property bool showMangerHeader: false
    property alias showBusy: busyLoader.active
    property alias headerComponent: headerLoader.sourceComponent
    property alias footerComponent: footerLoader.sourceComponent


    Loader {
        id: busyLoader
        active: false
        anchors.fill: pageLoader
        sourceComponent: busyLoading
    }
    Timer {
        id: busyTimer
        running: showBusy && enableBusyTimer
        interval: 750
        onTriggered:  {
            showBusy = false;
        }
    }

    Component {
        id: busyLoading
        Item {
            anchors.fill: parent
            WgtBusyIndicator {
                baseColor: root.color
                anchors.centerIn: parent
            }
        }
    }

    Loader{
        id: pageLoader
        width: parent.width
        opacity: !showBusy
        anchors {
            top: headerLoader.bottom
            bottom: footerLoader.bottom
            left: parent.left
            right: parent.right
        }
        onLoaded: {
            if (item) {
                contentLoaded();
            }
        }
    }

    Loader {
        id: headerLoader
        anchors.top: parent.top
        width: parent.width
        height: item ? item.height : 0

    }

    Loader {
        id: footerLoader
        anchors.bottom: parent.bottom
        width: parent.width
        height: item ? item.height : 0
    }

}
