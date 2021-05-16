import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.13

import Qt.labs.platform 1.0

import io.qt.examples.texteditor 1.0
import "./../../Utils"
import "./../../Utils/Utils.js" as Utils

Item {
    id: rootQ
    width: 200 //parent.width
    height: qHeight

    property int qHeight: radio_1.implicitHeight + radio_2.implicitHeight + radio_3.implicitHeight +radio_4.implicitHeight + textArea.implicitHeight //-- content height of text area module --//
    property alias qNumber: lbl_QNumber.text
    property string qText: "Aries pointed out that children did different types of work to adults during the Middle Ages. Aries pointed out that children did different types of work to adults during the Middle Ages. Aries pointed out that children did different types of work to adults during the Middle Ages."
    property var objTxt: textArea
    property alias btnG: btn_group.checkState
    property alias sizeR: slider_size.value
    property real sizeRatio: 2.0

    property alias choice1: radio_1
    property alias choice2: radio_2
    property alias choice3: radio_3
    property alias choice4: radio_4

    Component.onCompleted: {
        btn_group.addButton(radio_1)
        btn_group.addButton(radio_2)
        btn_group.addButton(radio_3)
        btn_group.addButton(radio_4)
    }

    //-- size porpos --//
    Label{id: lbl_size; visible: false; text: "Not Given"; font.pixelSize: Qt.application.font.pixelSize*sizeRatio}

    Rectangle{
        anchors.fill: parent
        color: "#00FF0000"
    }

    ButtonGroup {
        id:btn_group
        //        buttons: column.children
    }

    ColumnLayout {
        id: column
        width: parent.width - lbl_size.implicitHeight
        x: lbl_size.implicitHeight
        height: (lbl_size.implicitHeight * 2.2 * 4) + textArea.implicitHeight
        spacing: 0

        //-- question --//
        Item {
            id: itm_text
            Layout.fillWidth: true
            Layout.preferredHeight: textArea.implicitHeight //lbl_QNumber.height + textArea.height + (5 * ratio)

            TextArea{
                id: textArea
                anchors.fill: parent
                anchors.leftMargin: lbl_QNumber.width

                text: qText
                textFormat: TextEdit.RichText

                font.family: segoeUI.name
                font.pixelSize: lbl_size.font.pixelSize
                color: "#000000"
                wrapMode: Text.WordWrap

                readOnly: true
                selectByMouse: true

                background: Rectangle{
                    color: "#ffffff"
                }

                onFocusChanged: {
                    textArea.deselect()
                }


                //-- Number --//
                QstNumber{
                    id: lbl_QNumber
                    width: lbl_size.implicitHeight * 1.4
                    height: width
                    anchors.top: parent.top
                    anchors.topMargin: lbl_size.implicitHeight / 2
                    anchors.left: parent.left
                    anchors.leftMargin: -width - 1
                    font.pixelSize: lbl_size.font.pixelSize
                }

            }

        }


        //-- option 1 --//
        Item {
            Layout.fillWidth: true
            Layout.preferredHeight: radio_1.implicitHeight

            RowLayout{
                width: parent.width
                height: lbl_QNumber.height
                ButtonGroup.group: btn_group
                anchors.top: parent.top
                spacing: 0

                //-- Number --//
                Label{
                    id:lbl_QNumber_op1

                    Layout.preferredWidth: lbl_size.implicitHeight * 1.2
                    Layout.preferredHeight: width
                    text: "A"
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

                //-- option 1 --//
                RadioButton {
                    id: radio_1
                    text: qsTr("DAB")
                    font.pixelSize: lbl_size.font.pixelSize

                    onCheckedChanged: {
                        if(checked){
                            fillAnswer(qNumber, "A")
                        }
                    }

                    indicator.height: lbl_size.implicitHeight * 1.2
                    indicator.width: indicator.height
                    Layout.preferredHeight: lbl_size.implicitHeight * 2.2

                }

                //-- filler --//
                Item{Layout.fillWidth: true}
            }
        }

        //-- option 2 --//
        Item {
            Layout.fillWidth: true
            Layout.preferredHeight: radio_2.implicitHeight

            RowLayout{
                width: parent.width
                height: lbl_QNumber.height

                anchors.top: parent.top
                spacing: 0

                //-- Number --//
                Label{
                    id:lbl_QNumber_op2

                    Layout.preferredWidth: lbl_size.implicitHeight * 1.2
                    Layout.preferredHeight: width
                    text: "B"
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

                //-- option 2 --//
                RadioButton {
                    id: radio_2
                    text: qsTr("DAB")
                    font.pixelSize: lbl_size.font.pixelSize
                    onCheckedChanged: {
                        if(checked){
                            fillAnswer(qNumber, "B")
                        }
                    }

                    indicator.height: lbl_size.implicitHeight * 1.2
                    indicator.width: indicator.height
                    Layout.preferredHeight: lbl_size.implicitHeight * 2.2

                }

                //-- filler --//
                Item{Layout.fillWidth: true}
            }
        }

        //-- option 3 --//
        Item {
            Layout.fillWidth: true
            Layout.preferredHeight: radio_3.implicitHeight

            RowLayout{
                width: parent.width
                height: lbl_QNumber.height

                anchors.top: parent.top
                spacing: 0

                //-- Number --//
                Label{
                    id:lbl_QNumber_op3

                    Layout.preferredWidth: lbl_size.implicitHeight * 1.2
                    Layout.preferredHeight: width
                    text: "C"
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

                //-- option 3 --//
                RadioButton {
                    id: radio_3
                    text: qsTr("DAB")
                    font.pixelSize: lbl_size.font.pixelSize
                    onCheckedChanged: {
                        if(checked){
                            fillAnswer(qNumber, "C")
                        }
                    }

                    indicator.height: lbl_size.implicitHeight * 1.2
                    indicator.width: indicator.height
                    Layout.preferredHeight: lbl_size.implicitHeight * 2.2

                }

                //-- filler --//
                Item{Layout.fillWidth: true}
            }
        }

        //-- option 4 --//
        Item {
            Layout.fillWidth: true
            Layout.preferredHeight: radio_4.implicitHeight

            RowLayout{
                width: parent.width
                height: lbl_QNumber.height

                anchors.top: parent.top
                spacing: 0

                //-- Number --//
                Label{
                    id:lbl_QNumber_op4

                    Layout.preferredWidth: lbl_size.implicitHeight * 1.2
                    Layout.preferredHeight: width
                    text: "D"
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

                //-- option 4 --//
                RadioButton {
                    id: radio_4
                    text: qsTr("DAB")
                    font.pixelSize: lbl_size.font.pixelSize
                    onCheckedChanged: {
                        if(checked){
                            fillAnswer(qNumber, "D")
                        }
                    }

                    indicator.height: lbl_size.implicitHeight * 1.2
                    indicator.width: indicator.height
                    Layout.preferredHeight: lbl_size.implicitHeight * 2.2

                }

                //-- filler --//
                Item{Layout.fillWidth: true}
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


