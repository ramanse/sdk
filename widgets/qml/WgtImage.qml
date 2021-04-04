import QtQuick 2.13
import QtGraphicalEffects 1.13

Image {
    property var colorizeTo: "transparent"
    width: sourceSize.width * Common.scaleFactor
    height: sourceSize.height * Common.scaleFactor
    layer.enabled: colorizeTo !== "transparent"
    layer.effect: ColorOverlay {
        color: colorizeTo
    }
}
