import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.13

import Qt.labs.platform 1.0

import io.qt.examples.texteditor 1.0
import "./../../Utils/Utils.js" as Utils

Item {
    id: rootQ
    width: parent.width
    height: 100

    property alias qNumber: lbl_QNumber.text
    property string qText: "Aries pointed out that children did different types of work to adults during the Middle Ages. Aries pointed out that children did different types of work to adults during the Middle Ages. Aries pointed out that children did different types of work to adults during the Middle Ages.Aries pointed out that children did different types of work to adults during the Middle Ages."
    property var objTxt: textArea
    property alias comboAnswer: yesNoCombo
    property alias qHeight: textArea.implicitHeight //-- content height of text area module --//
    property alias sizeR: slider_size.value
    property real sizeRatio: 2.0

    signal pressedb()
    signal fillAnswer()


    //-- size porpos --//
    Label{id: lbl_size; visible: false; text: "Not Given"; font.pixelSize: Qt.application.font.pixelSize*sizeRatio}


    TextArea{
        id: textArea

        width: parent.width
        height: parent.height

        text:{

            if(sizeRatio<1.5) return("\t                " + qText)
            else if(sizeRatio<2) return("\t\t      " + qText)
            else if(sizeRatio<2.5) return("\t\t\t" + qText)
            else if(sizeRatio<3) return("\t\t\t\t" + qText)
            else if(sizeRatio<3.5) return("\t\t\t\t\t" + qText)
            else if(sizeRatio<4) return("\t\t\t\t\t\t" + qText)
            return("\t\t\t\t\t\t\t" + qText)
        }
        font.family: segoeUI.name
        font.pixelSize: lbl_size.font.pixelSize
        color: "#000000"
        wrapMode: Text.WordWrap
        renderType: Text.NativeRendering

        readOnly: true
        selectByMouse: true
        persistentSelection: true

        onPressed: pressedb()

        background: Rectangle{
            color: "#ffffff"
        }

        onFocusChanged: {
            textArea.deselect()
        }

        //-- number and dropdown --//
        RowLayout{
            width: parent.width
            height: lbl_QNumber.height

            anchors.top: parent.top

            spacing: 5 * ratio

            //-- Number --//
            Label{
                id:lbl_QNumber

                Layout.preferredWidth: lbl_size.implicitHeight * 1.2
                Layout.preferredHeight: width
                text: "1"
                font.family: segoeUI.name
                font.pixelSize: lbl_size.font.pixelSize
                color: "#ffffff"

                verticalAlignment: Qt.AlignVCenter
                horizontalAlignment: Qt.AlignHCenter

                background: Rectangle{
                    radius: width / 2
                    color: Utils.color_Tile_practice//"#1aa260"
                }

                ItemDelegate{
                    anchors.fill: parent
                }
            }

            //-- options --//
            ComboBox {
                id: yesNoCombo

                width: lbl_size.contentWidth * 1

                model: ["", "True", "False", "Not Given"]

                font.pixelSize: lbl_size.font.pixelSize

                onCurrentValueChanged: {
    //            onCurrentIndexChanged:{
                        fillAnswer()
                }

                //-- item in dropdown --//
                delegate: ItemDelegate {
                    width: yesNoCombo.width * 1
                    height: lbl_size.implicitHeight * 1.2
                    contentItem: Text {
                        text: modelData
                        font: yesNoCombo.font
                        elide: Text.ElideRight
                        verticalAlignment: Text.AlignVCenter
                    }
                    highlighted: yesNoCombo.highlightedIndex === index
                }

                background: Rectangle {
                    implicitWidth: lbl_size.contentWidth * 2
                    implicitHeight: lbl_size.implicitHeight * 1.2
                    border.color: yesNoCombo.pressed ? Utils.color_Tile_practice : "#88000000"
                    border.width: yesNoCombo.visualFocus ? 2 : 1
                    radius: 2
                }

                //-- threeangle icon --//
                indicator: Canvas {
                    id: canvas
                    x: yesNoCombo.width - width - yesNoCombo.rightPadding
                    y: yesNoCombo.topPadding + (yesNoCombo.availableHeight - height) / 2
                    width: yesNoCombo.height *0.3 //12
                    height: width * 0.6 //8
                    contextType: "2d"

                    Connections {
                        target: yesNoCombo
                        function onPressedChanged() { canvas.requestPaint(); }
                    }

                    onPaint: {
                        context.reset();
                        context.moveTo(0, 0);
                        context.lineTo(width, 0);
                        context.lineTo(width / 2, height);
                        context.closePath();
                        context.fillStyle = yesNoCombo.pressed ? Utils.color_Tile_practice : "#ee000000";
                        context.fill();
                    }
                }

            }

            //-- filler --//
            Item{Layout.fillWidth: true}
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
