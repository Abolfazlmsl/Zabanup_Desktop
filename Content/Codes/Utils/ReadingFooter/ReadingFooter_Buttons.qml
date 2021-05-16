import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

import "./../../../Fonts/Icon.js" as Icons



Rectangle{
    id: root

    signal clickRFB

    property alias lblText: lbl_RFB.text
    property alias iconSource: img_RFB.source
    property real labelRightMargin: 10 * ratio
    property real sendWidth: lbl_RFB.width + img_RFB.width +( 35 * ratio)
    property bool centerFlag: false

    color: "transparent"

    Label{
        id:lbl_RFB

        width: implicitWidth
        height: parent.height

        anchors.right: parent.right
        anchors.rightMargin: (centerFlag) ? (parent.width - (lbl_RFB.width + img_RFB.width)) / 2 : labelRightMargin
        verticalAlignment: Qt.AlignVCenter

        text: ""
        font.pixelSize: Qt.application.font.pixelSize * 1.2
        font.family: iranSans.name

        color: "#ffffff"

    }

    Image {
        id: img_RFB

        sourceSize.width: 30
        sourceSize.height: 30

        height: parent.height
        width: height * 0.55
        anchors.right: lbl_RFB.left
        anchors.rightMargin: 5 * ratio

        fillMode: Image.PreserveAspectFit

        source: "qrc:/Content/Images/Reading_Footer/footer_Send.png"

        ColorOverlay{
            anchors.fill: img_RFB
            source: img_RFB
            color: "#ffffff"
        }
    }

    ItemDelegate{
        anchors.fill: parent
        onClicked: {
            clickRFB()
        }
    }

}
