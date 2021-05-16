import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Styles 1.4

import "./../../Fonts/Icon.js" as Icons
import "./../Utils/Utils.js" as Util

Dialog{
    id:pReport

    width: 800 * ratio
    height: 600 * ratio

    padding: 0
    topPadding: 0

    modal: true

    //-- background --//
    RowLayout{

        anchors.fill: parent
        spacing: 0

        //-- background (Right - color : gray -) --//
        Rectangle{
            Layout.preferredWidth: parent.width * 0.65
            Layout.fillHeight: true
            color: "#e5e5e5"
        }

        //-- background (Right - color : white -) --//
        Rectangle{
            Layout.fillWidth: true
            Layout.fillHeight: true


            //-- Close Button --//
            Label{
                width: 30 * ratio
                height: width

                anchors.right: parent.right
                anchors.top: parent.top
                anchors.topMargin: 10 * ratio
                anchors.rightMargin: 10 * ratio
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter

                text: Icons.close
                font.family: webfont.name
                font.pixelSize: Qt.application.font.pixelSize * 1.5
                color: "#ffffff"

                background: Rectangle{
                    color: "#83888c"
                    radius: parent.width / 2
                }

                MouseArea{
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        pReport.close()

                    }
                }

            }
        }

    }

    //-- Body --//
    RowLayout{
        anchors.fill: parent
        spacing: 0

        //-- Description --//
        Rectangle{
            Layout.preferredWidth: parent.width * 0.4
            Layout.fillHeight: true
            color: "transparent"

            ColumnLayout{
                anchors.fill: parent
                anchors.topMargin: 40 * ratio
                anchors.bottomMargin: 15 * ratio
                spacing: 0

                //-- Description --//
                Label{
                    Layout.preferredWidth: parent.width - (40 * ratio)
                    Layout.preferredHeight: implicitHeight
                    Layout.alignment: Qt.AlignHCenter
                    horizontalAlignment: Qt.AlignRight

                    text: "لطفا با ارائه گزارشات، انتفادات و پیشنهادات سازنده خود، ما را در بهینه سازی و ارتقا این نرم افزار یاری نمایید."
                    color: "#81868c"
                    font.family: iranSans.name
                    font.pixelSize: Qt.application.font.pixelSize * 1.1
                    wrapMode: Text.Wrap
                    lineHeight: 1.2
                }

                //-- Line --//
                Rectangle{
                    Layout.preferredWidth: parent.width - (40 * ratio)
                    Layout.preferredHeight: 1
                    Layout.alignment: Qt.AlignHCenter
                    Layout.topMargin: 10 * ratio
                    color: "#81868c"
                }

                Item { Layout.fillHeight: true }    //-- filler --//

                //-- Image --//
                Rectangle{
                    Layout.preferredWidth: parent.width - (50 * ratio)
                    Layout.fillHeight: true
                    Layout.alignment: Qt.AlignHCenter
                    color: "transparent"

                    Image {
                        width: parent.width
                        height: parent.height
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/Content/Images/logo.png"
                    }

                }

                Item { Layout.fillHeight: true }    //-- filler --//

                //-- Line --//
                Rectangle{
                    Layout.preferredWidth: parent.width - (40 * ratio)
                    Layout.preferredHeight: 1
                    Layout.alignment: Qt.AlignHCenter
                    Layout.bottomMargin: 5 * ratio
                    color: "#81868c"
                }

                //-- Copy Right Description (ZabanUp) --//
                Label{
                    Layout.preferredWidth: parent.width - (40 * ratio)
                    Layout.preferredHeight: implicitHeight
                    Layout.alignment: Qt.AlignHCenter
                    horizontalAlignment: Qt.AlignLeft

                    text:"Zabanup Institute. All right reserved."
                    color: "#81868c"
                    font.family: segoeUI.name
                    font.pixelSize: Qt.application.font.pixelSize
                    font.bold: true
                    wrapMode: Text.Wrap
                    lineHeight: 1.2
                }

                //-- Copy Right Description  (Mediasoft)--//
                Label{
                    Layout.preferredWidth: parent.width - (40 * ratio)
                    Layout.preferredHeight: implicitHeight
                    Layout.alignment: Qt.AlignHCenter
                    horizontalAlignment: Qt.AlignLeft

                    text:"Developed By Mediasoft"
                    color: "#81868c"
                    font.family: segoeUI.name
                    font.pixelSize: Qt.application.font.pixelSize * 0.9
                    wrapMode: Text.Wrap
                    lineHeight: 1.2
                }
            }


        }

        //-- Inputs --//
        Rectangle{
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "transparent"

            //-- shadow --//
            DropShadow {
                anchors.fill: inputArea
                horizontalOffset: 0
                verticalOffset: 0
                radius: 9.0
                samples: 17
                color: "#80000000"
                source: inputArea
            }

            //-- Input Area --//
            Rectangle {
                id: inputArea
                width: parent.width * 0.8
                height: parent.height - (80 *  ratio)
                anchors.top: parent.top
                anchors.topMargin: 40 * ratio
                radius: 5 * ratio

                ColumnLayout{
                    anchors.fill: parent
                    spacing: 0

                    //-- Header --//
                    Rectangle{
                        Layout.preferredWidth: parent.width
                        Layout.preferredHeight: 40 * ratio
                        radius: 5 * ratio

                        color: "#81868c"

                        Rectangle{
                            width: parent.width
                            height: parent.radius
                            anchors.bottom: parent.bottom
                            color: parent.color
                        }

                        //-- گزارش خظا --//
                        Label{
                            width: implicitWidth
                            height: implicitHeight

                            anchors.centerIn: parent
                            text: "گزارش خطا"
                            color: "#ffffff"
                            font.family: iranSans.name
                            font.pixelSize: Qt.application.font.pixelSize * 1.2
                        }

                    }

                    //-- Subject --//
                    Rectangle{
                        Layout.fillWidth: true
                        Layout.preferredHeight: 100 * ratio
                        Layout.topMargin: 30 * ratio
                        color: "transparent"


                        RowLayout{
                            anchors.fill: parent
                            spacing: 10
                            layoutDirection: Qt.RightToLeft
                            //-- Title Label --//
                            Label{
                                id: lbl_PRTitle
                                Layout.preferredWidth: implicitWidth
                                Layout.preferredHeight: parent.height
                                Layout.rightMargin: 35 * ratio
                                Layout.topMargin: -20 * ratio
                                clip: true

                                text: "موضوع :"
                                font.family: iranSans.name
                                font.pixelSize: Qt.application.font.pixelSize * 1.2
                                font.bold: true
                                color: "#81868c"

                                verticalAlignment: Qt.AlignVCenter
                                horizontalAlignment: Qt.AlignRight

                            }

                            //-- Title input //
                            Rectangle{
                                Layout.fillWidth: true
                                Layout.preferredHeight: lbl_PRTitle.implicitHeight * 2
                                color: "transparent"

                                //-- Title TextField --//
                                TextField{
                                    anchors.fill: parent

                                    verticalAlignment: Qt.AlignVCenter
                                    horizontalAlignment: Qt.AlignRight
                                    anchors.topMargin: -8 * ratio
                                    topPadding: 10 * ratio
                                    bottomInset: 10 * ratio
                                    maximumLength: 50

                                    rightPadding: 10 * ratio
                                    leftPadding: 10 * ratio
                                    Material.accent: "#dddddd"

                                    background: Rectangle{
                                        //                                    color: "#eeeeee"
                                        border.color: "#dedede"
                                        border.width: 1
                                        radius: 5 * ratio
                                    }
                                }

                            }


                            Item {
                                Layout.preferredWidth: 35 * ratio
                            }
                        }

                    }

                    //-- Description TextArea --//
                    TextArea{
                        id: txa_RPDescription
                        Layout.fillWidth: true
                        Layout.preferredHeight: 250 * ratio
                        Layout.leftMargin: 35 * ratio
                        Layout.rightMargin: 35 * ratio
                        clip: true

                        horizontalAlignment: Qt.AlignRight
                        rightPadding: 20 * ratio
                        topPadding: 20 * ratio
                        wrapMode: Text.Wrap

                        Material.accent: "#dddddd"

                        placeholderText: "توضیحات"

                        background: Rectangle{
                            border.color: "#dedede"
                            border.width: 1
                            radius: 5 * ratio
                        }

                        //-- Maximum Length in TextArea --//
                        onLengthChanged: {
                            //                        console.log("change length")
                            if (txa_RPDescription.length > 500){
                                //                            console.log("length = " + length + "  text = " + txa_RPDescription.text)
                                var txt = txa_RPDescription.text.slice(0,500)
                                txa_RPDescription.text = txt
                                txa_RPDescription.cursorPosition = txa_RPDescription.length
                            }
                        }

                    }


                    //-- Buttons --//
                    Rectangle{
                        Layout.fillWidth: true
                        Layout.preferredHeight: 35 * ratio
                        Layout.topMargin: 30 * ratio
                        color: "transparent"

                        RowLayout{
                            anchors.fill: parent
                            spacing: 20 * ratio

                            Item { Layout.fillWidth: true }  //-- Filler --//

                            //-- Cancel Button --//
                            Rectangle{
                                Layout.preferredWidth: 100 * ratio
                                Layout.fillHeight: true
                                color: "#81868c"
                                radius: 5 * ratio

                                Label{
                                    text: "انصراف"
                                    font.family: iranSans.name
                                    font.pixelSize: Qt.application.font.pixelSize * 1.2
                                    color: "#ffffff"
                                    anchors.centerIn: parent
                                }


                                MouseArea{
                                    anchors.fill: parent
                                    cursorShape: Qt.PointingHandCursor

                                    onClicked: {
                                        pReport.close()
                                    }
                                }
                            }

                            //-- Send Button --//
                            Rectangle{
                                Layout.preferredWidth: 100 * ratio
                                Layout.fillHeight: true
                                color: "#1a73e9"
                                radius: 5 * ratio

                                Label{
                                    text: "ارسال"
                                    font.family: iranSans.name
                                    font.pixelSize: Qt.application.font.pixelSize * 1.2
                                    color: "#ffffff"
                                    anchors.centerIn: parent
                                }



                                MouseArea{
                                    anchors.fill: parent
                                    cursorShape: Qt.PointingHandCursor

                                    onClicked: {
                                        console.log("SEND REPORT")
                                        pReport.close()
                                    }
                                }
                            }

                            Item { Layout.fillWidth: true }  //-- Filler --//

                        }
                    }

                    Item {
                        Layout.fillHeight: true
                    }
                }


            }
        }


    }



}
