import QtQuick 2.12
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.0

import "./../../../Fonts/Icon.js" as Icons

Item {
    width: btnTag.width
    height: btnTag.height

    property alias tagText: lbl_Tag.text
    property alias btnColor: btnTag.color
    property alias btnSize: btnTag
    property alias lblColor: lbl_Tag.color
    signal clickTag
    onClickTag: {
        console.log(tagText)
    }

    //    DropShadow {
    //        anchors.fill: btnTag
    //        transparentBorder: true
    //        horizontalOffset: 2
    //        verticalOffset: 2
    //        spread: 0.0
    //        radius: 10
    //        samples: 40
    //        color: "#cccccc"
    //        source: btnTag
    //    }

    Rectangle {
        id: btnTag

        width: (lbl_Tag.implicitWidth + (30 * ratio))// + (lbl_CloseIcon.implicitWidth + (10 * ratio))
        height: 35
                radius: height / 2

        color: "lightblue"

        Label{
            id: lbl_Tag
            text: "TEST"
            font.family: iranSans.name
            font.pixelSize: Qt.application.font.pixelSize * 1
            //            font.bold: true
            anchors.centerIn: parent
            color: "#5d5d5d"
        }
        Label{
            id: lbl_CloseIcon
            visible: false
            anchors.fill: parent
            text: Icons.close
            font.family: webfont.name
            font.pixelSize: Qt.application.font.pixelSize * 1.5
            //            font.bold: true
            color: "#ffffff"//lbl_Tag.color

            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter

            background: Rectangle{
                color: "#50000000"
                radius: btnTag.radius
            }

        }


        MouseArea{
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: true
            onClicked: {
                clickTag()

            }

            onEntered: {
                lbl_CloseIcon.visible = true
            }

            onExited: {
                lbl_CloseIcon.visible = false
            }

        }



    }
}

