pragma Singleton

import QtQuick 2.13
import QtQuick.Controls 2.12
import QtQuick.Window 2.13


import sdk.widgets.display 1.0

Item {

    readonly property real refScreenWidth: 1208
    readonly property real refScreenHeight: 720
    readonly property real screenWidth: Screen.width
    readonly property real screenHeight: Screen.height
    property bool isOverlayOpen: false
    function hscale(size) {
        return Math.round(size * (screenWidth / refScreenWidth))
    }

    function vscale(size) {
        return Math.round(size * (screenHeight / refScreenHeight))
    }
    function tscale(size) {
        return Math.round((hscale(size) + vscale(size)) / 2)
    }

    property real scaleFactor: Display.scaleFactor
    property var  font: robotoRegular.name
    property var  fontBold: robotoBold.name
    property var  fontItallic: robotoItallic.name
    property var  garmondSpecial: garmondItallic.name
    property var isPotrait: false
    property bool isDNDManager: false
    property color bgColor: Common.themeColor
    property color themeColor: "#007600"
    property color buttonBgColor: "#d42b00"
    property color mainPageColor: "white"
    readonly property string robotoRegularFile: "Roboto-Regular.ttf"
    readonly property string robotoBoldFile: "Roboto-Bold.ttf"
    readonly property string robotoItallicFile: "Roboto-Italic.ttf"
    readonly property string garmondSSKItalic: "GaramondRetrospectiveSSKItalic.ttf"
    signal pushMenu(var url)
    signal toHome()

    function getQrcIcon(iconName) {

            return "../../assets/icons/" + iconName +".png"

    }
    function getQrcImage(imageName) {

            return "../../assets/images/" + imageName +".png"

    }

    function getQrcFont(ttfName) {
        if (isDNDManager) {
            return "../../../fonts/" + ttfName
        }

        return "../../../sdk/assets/fonts/"+ttfName
    }

    FontLoader{
        id: robotoBold
        source: getQrcFont(robotoBoldFile)
    }
    FontLoader{
        id: robotoRegular
        source: getQrcFont(robotoRegularFile)
    }
    FontLoader{
        id: robotoItallic
        source: getQrcFont(robotoItallicFile)
    }
    FontLoader{
        id: garmondItallic
        source: getQrcFont(garmondSSKItalic)
    }
    function dpiSize (value) {
        return (Display.scaleFactor * value)
    }
    function fontSize (value) {
        return Display.dp(value)
    }

}
