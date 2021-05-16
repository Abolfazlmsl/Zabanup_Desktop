import QtQuick 2.9
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

import "./Utils.js" as Util
import "./../../Fonts/Icon.js" as Icons

//-- InputBox For Search --//
Rectangle{
    id: root_txf

    property alias inputText: txf_main
    property string label: ""
    property string icon: ""
    property string iconColor: ""
    property alias placeholder: lbl_placeholder.text
    property alias echoMode: txf_main.echoMode
    property alias clearEnable: lbl_clear.visible
    property string borderColor: "#444444"
    property bool enterAsAccept: false

    signal acceptedLogin()

    property int selectStart
    property int selectEnd
    property int curPos

    color: "#f7f7f7"

    Layout.fillWidth: true
    Layout.preferredHeight: 45 * ratio
    Layout.rightMargin: 10 * ratio

    Rectangle{
        width: 3
        height: parent.height
        anchors.left: parent.left
        color: "#077ef4"
    }

    RowLayout{

        anchors.fill: parent
        anchors.rightMargin: 5 * ratio
        anchors.leftMargin: 5 * ratio

        //-- TextField --//
        TextInput{
            id:txf_main

            clip: true
            Layout.fillHeight: true
            Layout.fillWidth: true
//            width: parent.width - lbl_icon.implicitWidth - lbl_clear.implicitWidth  // Width of Rect - Width of Magnify
//            height: parent.height

            verticalAlignment: Qt.AlignVCenter

            rightPadding: 10 * ratio
            leftPadding: 5 * ratio

            font.family: iranSans.name
            font.pixelSize: Qt.application.font.pixelSize
            selectedTextColor: "#3399ff"

            selectByMouse: true


            //-- placeholder --//
            Label{
                id: lbl_placeholder

                visible: (txf_main.length >= 1) ? false : true

                text: "متن پیش فرض"

                anchors.left: parent.left
                anchors.leftMargin: 10 * ratio
                anchors.verticalCenter: parent.verticalCenter

                font.family: iranSans.name
                font.pixelSize: Qt.application.font.pixelSize

                color: "gray"

                background: Rectangle{
                    color: "transparent"
                }

            }


            //-- Cut Copy Paste => MouseArea --//
            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.RightButton
                hoverEnabled: true

                onClicked: {

                    selectStart = txf_main.selectionStart
                    selectEnd = txf_main.selectionEnd
                    curPos = txf_main.positionAt(mouse.x)
                    copyPaste_Menu.x = mouse.x
                    copyPaste_Menu.y = mouse.y
                    txf_main.cursorPosition = curPos
                    copyPaste_Menu.open()

                    txf_main.select(selectStart,selectEnd)
                }
                onPressAndHold: {
                    if (mouse.source === Qt.MouseEventNotSynthesized) {
                        selectStart = txf_main.selectionStart
                        selectEnd = txf_main.selectionEnd
                        curPos = txf_main.positionAt(mouse.x)
                        copyPaste_Menu.x = mouse.x
                        copyPaste_Menu.y = mouse.y
                        txf_main.cursorPosition = curPos
                        copyPaste_Menu.open()

                        txf_main.select(selectStart,selectEnd)
                    }
                }

                //-- Cut Copy Paste => Menu --//
                Menu {
                    id: copyPaste_Menu
                    topPadding: 0
                    bottomPadding: 0
                    width: 150 * ratio
                    height: 150 * ratio
                    MenuItem {
                        text: "Cut"
                        font.family: iranSans.name
                        font.pixelSize: 15 * ratio

                        enabled: (selectEnd - selectStart !== 0) ? true : false

                        width: 150 * ratio
                        height: 50 * ratio

                        onTriggered: {
                            txf_main.select(selectStart,selectEnd)
                            txf_main.cut()
                        }
                    }
                    MenuItem {
                        text: "Copy"
                        font.family: iranSans.name
                        font.pixelSize: 15 * ratio

                        enabled: (selectEnd - selectStart !== 0) ? true : false

                        width: 150 * ratio
                        height: 50 * ratio

                        onTriggered: {
                            txf_main.select(selectStart,selectEnd)
                            txf_main.copy()
                        }
                    }
                    MenuItem {
                        text: "Paste"

                        font.family: iranSans.name
                        font.pixelSize: Qt.application.font.pixelSize
                        enabled:txtTemp.text != "" ? true : false

                        width : 150 * ratio
                        height : 50 * ratio

                        onTriggered: {
                            txf_main.paste()
                        }

                        TextInput {
                            id: txtTemp
                            visible: false
                        }
                    }
                    onOpened: {

                        txf_main.select(selectStart,selectEnd)
                        txf_main.cursorPosition = curPos

                        //console.log(txf_Search.cursorPosition)
                    }

                    onAboutToShow: {
                        //-- paste enable check --//
                        txtTemp.text = ""
                        txtTemp.paste()
                    }
                }
            }

            onAccepted: {

                if(enterAsAccept){
                    acceptedLogin()

                }

            }

        }


        //-- clear Icon  --//
        Label{
            id: lbl_clear

            visible: false
            text: Icons.close
            font.family: webfont.name
            font.pixelSize: Qt.application.font.pixelSize * 1.5

            color: Util.color_RightMenu

            verticalAlignment: Qt.AlignVCenter
            Layout.alignment: Qt.AlignRight

            ItemDelegate{
                anchors.fill: parent
                onClicked: {
                    txf_main.text = ""
                }
            }

        }


    }

}

