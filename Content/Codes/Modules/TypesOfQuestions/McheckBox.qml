import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.13

import Qt.labs.platform 1.0

import io.qt.examples.texteditor 1.0
import "./../../Utils/Utils.js" as Utils
import "./../../Utils"

Item {
    id: rootQ
    width: parent.width
    height: control.implicitHeight

    property alias qNumber: lbl_QNumber.text
    property string qText: "Aries pointed out that children did different types of work to adults during the Middle Ages. Aries pointed out that children did different types of work to adults during the Middle Ages. Aries pointed out that children did different types of work to adults during the Middle Ages.Aries pointed out that children did different types of work to adults during the Middle Ages."
    property int qHeight: control.implicitHeight //-- content height of text area module --//
    property alias sizeR: slider_size.value
    property real sizeRatio: 2.0
    property alias qCheckState: control.checkState
//    property alias qChecked: control.checked

    //-- local property --//
    property string m_color_blue: "#1b4080"

    signal triggerCheck(string key, var status)

    Rectangle{
        anchors.fill: parent
        color: "#00FF0000"
    }

    //-- size porpos --//
    Label{id: lbl_size; visible: false; text: "Not Given"; font.pixelSize: Qt.application.font.pixelSize*sizeRatio}

    //-- number and dropdown --//
    RowLayout{
        width: parent.width
        height: lbl_QNumber.height

        anchors.top: parent.top

        spacing: 5 * ratio

        //-- Number --//
        Label{
            id:lbl_QNumber

            Layout.preferredWidth: lbl_size.implicitHeight * 1.3
            Layout.preferredHeight: width
            text: "1"
            font.family: segoeUI.name
            font.pixelSize: lbl_size.font.pixelSize * 0.9
            color: "#000000"

            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter

            background: Rectangle{
                anchors.fill: parent
                anchors.centerIn: parent
                radius: width / 2
                color: "#d0d0d0"
                smooth: false
            }

            ItemDelegate{
                anchors.fill: parent
            }
        }

        CheckBox{
            id: control

            font.pixelSize: lbl_size.font.pixelSize
            text: qText

            indicator.height: lbl_size.implicitHeight * 1.2
            indicator.width: indicator.height
            Layout.preferredHeight: lbl_size.implicitHeight * 2.2
            Layout.fillWidth: true

            onCheckStateChanged: {
            }
            onClicked: {

                log(" lv_options " + lv_options.answerCheck)
                log(qNumber)
                triggerCheck(qNumber, checkState)
            }

            contentItem: Text {
                text: control.text
                font: control.font
                opacity: enabled ? 1.0 : 0.3
                color: control.down ? "#aa000000" : "#000000"
                verticalAlignment: Text.AlignVCenter
                leftPadding: control.indicator.width + control.spacing
                wrapMode: Text.WordWrap
                width: control.width
                renderType: Text.NativeRendering
            }


        }
    }


    //-- (unchange) chabge size fo test --//
    Slider{
        visible: false
        id: slider_size
        anchors.right: parent.right
        from: 1
        to: 4
        stepSize: 0.5
        Label{ text: parent.value }
        onValueChanged: { sizeRatio = value }
    }

}
