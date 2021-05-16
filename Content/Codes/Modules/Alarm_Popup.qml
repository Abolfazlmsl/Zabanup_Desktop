import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

import "./../../Fonts/Icon.js" as Icons
import "./../Utils/Utils.js" as Util

Dialog{
    id: alarm_dialog

    onOk_Click: {
        console.log(alarm_dialog.width + "=> WIDTH")
        console.log(alarm_dialog.height + "=> HEIGHT")
        console.log(txt_Main.width + "=> MAIN_TEXT WIDTH")
        console.log(txt_Main.width + "=> MAIN_TEXT HEIGHT")
    }

    function getAlarmData( func_icon , func_iconColor , func_text , func_buttonText , func_closeMode , fanc_multiLine , func_direction){
        alarm_dialog.icon = func_icon
        alarm_dialog.iconColor = func_iconColor
        alarm_dialog.mainText = func_text
        alarm_dialog.textButton = func_buttonText
        alarm_dialog.closeMode = func_closeMode
        alarm_dialog.direction = func_direction

        if(fanc_multiLine){
            row1_Visible = true
            row1.height = 50
            row2_Visible = true
            row2.height = 50
            row3_Visible = true
            row3.height = 50
            row4_Visible = true
            row4.height = 50
            row5_Visible = true
            row5.height = 50
        }
        else{
            row1_Visible = false
            row1.height = 0
            row2_Visible = false
            row2.height = 0
            row3_Visible = false
            row3.height = 0
            row4_Visible = false
            row4.height = 0
            row5_Visible = false
            row5.height = 0
        }
    }

    property string icon: Icons.check
    property string iconColor: "#000000"
    property string direction: "rtl" // "rtl" , "ltr"
    property string mainText: "با موفقیت ثبت شد"
    property string text_1: " "
    property string text_2: " "
    property string text_3: " "
    property string text_4: " "
    property string text_5: " "

    property alias row1_Visible: row1.visible
    property alias row2_Visible: row2.visible
    property alias row3_Visible: row3.visible
    property alias row4_Visible: row4.visible
    property alias row5_Visible: row5.visible

    property bool isWrong_Row1: false
    property bool isWrong_Row2: false
    property bool isWrong_Row3: false
    property bool isWrong_Row4: false
    property bool isWrong_Row5: false

    property string textButton: "تایید"
    property bool closeMode: false  // "برای وقتی است که در صورت کلیک برروی دکمه تایید ، فقط پاپ آپ بسته شود یا کلا پنجره رجیستر بسته شود"

    signal ok_Click()


    width: 300
    height: mainRow.height + row1.height + row2.height + row3.height + row4.height + row4.height + btn.height
//    clip: true

    modal: true

    padding: 0
    topPadding: 0

    Rectangle{
        anchors.fill: parent
        radius: 10

        ColumnLayout{
            anchors.fill: parent
            spacing: 0

            //-- Text and Icon (Main) --//
            Rectangle{
                id: mainRow

                Layout.fillWidth: true
                Layout.preferredHeight: 50
                Layout.leftMargin: (alarm_dialog.direction === "ltr") ? (parent.width - (((txt_Main.lineCount > 1) ? txt_Main.width : txt_Main.implicitWidth) + mainIcon.width)) / 2 : 0
                Layout.rightMargin: (alarm_dialog.direction === "rtl") ? (parent.width - (((txt_Main.lineCount > 1) ? txt_Main.width : txt_Main.implicitWidth) + mainIcon.width)) / 2 : 0

                RowLayout{
                    anchors.fill: parent
                    spacing: 5
                    layoutDirection: (alarm_dialog.direction === "ltr") ? Qt.LeftToRight : Qt.RightToLeft

                    //-- Icon --//
                    Label{
                        id: mainIcon
                        Layout.fillHeight: true
                        Layout.preferredWidth: implicitWidth * 1.1

                        text: icon
                        color: iconColor

                        font.family: webfont.name
                        font.pixelSize: Qt.application.font.pixelSize * 2

                        verticalAlignment: Qt.AlignVCenter
                        horizontalAlignment: Qt.AlignHCenter

                    }

                    //-- Text --//
                    Label{
                        id: txt_Main
                        Layout.fillHeight: true
                        Layout.fillWidth: true

                        text: mainText
                        font.family: iranSans.name
                        font.pixelSize: Qt.application.font.pixelSize * 1
                        wrapMode: Text.WordWrap
                        verticalAlignment: Qt.AlignVCenter
                        horizontalAlignment:(alarm_dialog.direction === "ltr") ? Qt.AlignLeft : Qt.AlignRight
                        color: "#444444"
                    }
                }
            }

            //-- Text and Icon (1) --//
            Rectangle{
                id: row1

                Layout.fillWidth: true
                Layout.preferredHeight: 50
                Layout.leftMargin: 15
                Layout.rightMargin: 15

                RowLayout{
                    anchors.fill: parent
                    spacing: 5
                    layoutDirection: (alarm_dialog.direction === "ltr") ? Qt.LeftToRight : Qt.RightToLeft

                    //-- Icon --//
                    Label{
                        id: icon1
                        Layout.fillHeight: true
                        Layout.preferredWidth: implicitWidth * 1.1

                        text: (isWrong_Row1) ? Icons.check_circle : Icons.close_circle
                        color: (isWrong_Row1) ? "#00ff00" : "#ff0000"

                        font.family: webfont.name
                        font.pixelSize: Qt.application.font.pixelSize * 2

                        verticalAlignment: Qt.AlignVCenter
                        horizontalAlignment: Qt.AlignHCenter

                    }

                    //-- Text --//
                    Label{

                        Layout.fillHeight: true
                        Layout.fillWidth: true

                        text: text_1
                        font.family: iranSans.name
                        font.pixelSize: Qt.application.font.pixelSize * 1
                        wrapMode: Text.WordWrap
                        verticalAlignment: Qt.AlignVCenter
                        horizontalAlignment: (alarm_dialog.direction === "ltr") ?Qt.AlignLeft : Qt.AlignRight
                        color: "#444444"
                    }
                }
            }

            //-- Text and Icon (2) --//
            Rectangle{
                id: row2

                Layout.fillWidth: true
                Layout.preferredHeight: 50
                Layout.leftMargin: 15
                Layout.rightMargin: 15

                RowLayout{
                    anchors.fill: parent
                    spacing: 5
                    layoutDirection: (alarm_dialog.direction === "ltr") ? Qt.LeftToRight : Qt.RightToLeft

                    //-- Icon --//
                    Label{
                        id: icon2
                        Layout.fillHeight: true
                        Layout.preferredWidth: implicitWidth * 1.1

                        text: (isWrong_Row2) ?  Icons.check_circle : Icons.close_circle
                        color: (isWrong_Row2) ? "#00ff00" : "#ff0000"

                        font.family: webfont.name
                        font.pixelSize: Qt.application.font.pixelSize * 2

                        verticalAlignment: Qt.AlignVCenter
                        horizontalAlignment: Qt.AlignHCenter

                    }

                    //-- Text --//
                    Label{

                        Layout.fillHeight: true
                        Layout.fillWidth: true

                        text: text_2
                        font.family: iranSans.name
                        font.pixelSize: Qt.application.font.pixelSize * 1
                        wrapMode: Text.WordWrap
                        verticalAlignment: Qt.AlignVCenter
                        horizontalAlignment: (alarm_dialog.direction === "ltr") ?Qt.AlignLeft : Qt.AlignRight
                        color: "#444444"
                    }
                }
            }

            //-- Text and Icon (3) --//
            Rectangle{
                id: row3

                Layout.fillWidth: true
                Layout.preferredHeight: 50
                Layout.leftMargin: 15
                Layout.rightMargin: 15

                RowLayout{
                    anchors.fill: parent
                    spacing: 5
                    layoutDirection: (alarm_dialog.direction === "ltr") ? Qt.LeftToRight : Qt.RightToLeft

                    //-- Icon --//
                    Label{
                        id: icon3
                        Layout.fillHeight: true
                        Layout.preferredWidth: implicitWidth * 1.1

                        text: (isWrong_Row3) ? Icons.check_circle : Icons.close_circle
                        color: (isWrong_Row3) ? "#00ff00" : "#ff0000"

                        font.family: webfont.name
                        font.pixelSize: Qt.application.font.pixelSize * 2

                        verticalAlignment: Qt.AlignVCenter
                        horizontalAlignment: Qt.AlignHCenter

                    }

                    //-- Text --//
                    Label{

                        Layout.fillHeight: true
                        Layout.fillWidth: true

                        text: text_3
                        font.family: iranSans.name
                        font.pixelSize: Qt.application.font.pixelSize * 1
                        wrapMode: Text.WordWrap
                        verticalAlignment: Qt.AlignVCenter
                        horizontalAlignment: (alarm_dialog.direction === "ltr") ?Qt.AlignLeft : Qt.AlignRight
                        color: "#444444"
                    }
                }
            }

            //-- Text and Icon (4) --//
            Rectangle{
                id: row4

                Layout.fillWidth: true
                Layout.preferredHeight: 50
                Layout.leftMargin: 15
                Layout.rightMargin: 15
                color: "#ffffff"

                RowLayout{
                    anchors.fill: parent
                    spacing: 5
                    layoutDirection: (alarm_dialog.direction === "ltr") ? Qt.LeftToRight : Qt.RightToLeft

                    //-- Icon --//
                    Label{
                        id: icon4

                        Layout.fillHeight: true
                        Layout.preferredWidth: implicitWidth * 1.1

                        text: (isWrong_Row4) ? Icons.check_circle : Icons.close_circle
                        color: (isWrong_Row4) ? "#00ff00" : "#ff0000"

                        font.family: webfont.name
                        font.pixelSize: Qt.application.font.pixelSize * 2

                        verticalAlignment: Qt.AlignVCenter
                        horizontalAlignment: Qt.AlignHCenter

                    }

                    //-- Text --//
                    Label{

                        Layout.fillHeight: true
                        Layout.fillWidth: true

                        text: text_4
                        font.family: iranSans.name
                        font.pixelSize: Qt.application.font.pixelSize * 1
                        wrapMode: Text.WordWrap
                        verticalAlignment: Qt.AlignVCenter
                        horizontalAlignment: (alarm_dialog.direction === "ltr") ?Qt.AlignLeft : Qt.AlignRight
                        color: "#444444"
                    }
                }
            }

            //-- Text and Icon (5) --//
            Rectangle{
                id: row5

                Layout.fillWidth: true
                Layout.preferredHeight: 50
                Layout.leftMargin: 15
                Layout.rightMargin: 15
                color: "#ffffff"

                RowLayout{
                    anchors.fill: parent
                    spacing: 5
                    layoutDirection: (alarm_dialog.direction === "ltr") ? Qt.LeftToRight : Qt.RightToLeft

                    //-- Icon --//
                    Label{
                        id: icon5

                        Layout.fillHeight: true
                        Layout.preferredWidth: implicitWidth * 1.1

                        text: (isWrong_Row5) ? Icons.check_circle : Icons.close_circle
                        color: (isWrong_Row5) ? "#00ff00" : "#ff0000"

                        font.family: webfont.name
                        font.pixelSize: Qt.application.font.pixelSize * 2

                        verticalAlignment: Qt.AlignVCenter
                        horizontalAlignment: Qt.AlignHCenter

                    }

                    //-- Text --//
                    Label{

                        Layout.fillHeight: true
                        Layout.fillWidth: true

                        text: text_5
                        font.family: iranSans.name
                        font.pixelSize: Qt.application.font.pixelSize * 1
                        wrapMode: Text.WordWrap
                        verticalAlignment: Qt.AlignVCenter
                        horizontalAlignment: (alarm_dialog.direction === "ltr") ?Qt.AlignLeft : Qt.AlignRight
                        color: "#444444"
                    }
                }
            }


            //-- Button --//
            Rectangle{
                id: btn
                Layout.fillWidth: true
                Layout.preferredHeight: 50

                Label{

                    height: implicitHeight + 10
                    width: implicitWidth + 30
                    anchors.horizontalCenter: parent.horizontalCenter

                    text: textButton
                    color: "#ffffff"

                    font.family: iranSans.name
                    font.pixelSize: Qt.application.font.pixelSize * 1.5

                    verticalAlignment: Qt.AlignVCenter
                    horizontalAlignment: Qt.AlignHCenter

                    background: Rectangle{
                        color: Util.color_BaseBlue
                        radius: 6
                    }

                    ItemDelegate{
                        anchors.fill: parent
                        onClicked: {
                            ok_Click()
                        }
                    }

                }


            }
        }


    }


}
