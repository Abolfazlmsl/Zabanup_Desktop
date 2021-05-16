import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.12
import QtGraphicalEffects 1.0

import "Utils.js" as Util
import "./../../Fonts/Icon.js" as Icons

ApplicationWindow{
        id: root_register

        signal selectDate()

        visible: true//false//
        minimumWidth: 400
        maximumWidth: 400
        minimumHeight: 400
        maximumHeight: 400
        title: " "
        objectName: "DateSelect"
        flags: Qt.Dialog //SplashScreen //Dialog //Widget,SubWindow //Sheet //CoverWindow

        MouseArea {
            //            anchors.fill: parent
            width: parent.width
            height: parent.height

            propagateComposedEvents: true
            property real lastMouseX: 0
            property real lastMouseY: 0
            acceptedButtons: Qt.LeftButton
            onMouseXChanged: root_register.x += (mouseX - lastMouseX)
            onMouseYChanged: root_register.y += (mouseY - lastMouseY)
            onPressed: {
                if(mouse.button == Qt.LeftButton){
                    parent.forceActiveFocus()
                    lastMouseX = mouseX
                    lastMouseY = mouseY

                    //-- seek clip --//
                    //                    player.seek((player.duration*mouseX)/width)
                }
//                mouse.accepted = false
            }
        }

        Pane {
            id: popup

            font.family: font_irans.name

            Rectangle{
                anchors.fill: parent; color: Util.color_white
            }

            anchors.fill: parent
            anchors.margins: -11

            ColumnLayout{
                anchors.fill: parent
                spacing: 0

                //-- logo and intro -//
                Rectangle{
                    Layout.preferredHeight: parent.height * 0.3
                    Layout.fillWidth: true
                    color: "#00000000"

                    //-- red background --//
                    Canvas{
                        id: mycanvas
                        anchors.fill: parent

                        onPaint: {
                            var ctx = getContext("2d");

                            //-- set red color --//
                            ctx.fillStyle = Util.color_Tile_activity

                            //-- shadow --//
                            ctx.shadowBlur = 10;
                            ctx.shadowOffsetX = 10;
                            ctx.shadowOffsetY = 10;
                            ctx.shadowColor = Util.color_StatusBar;

                            var margin = 5;
                            var x1 = 0 + margin;
                            var x2 = width - margin;
                            var y1 = 0 + margin;
                            var y2 = height - ctx.shadowOffsetY*2;
                            var y3 = height * 0.5;

                            //-- draw polygon path --//
                            // x1, y1
                            //  _________ x2,y1
                            // |        |
                            // |        |
                            // |________|
                            // x1,y3   x2,y2
                            //
                            ctx.beginPath();
                            ctx.moveTo(x1, y1);
                            ctx.lineTo(x2, y1);
                            ctx.lineTo(x2, y2);
                            ctx.lineTo(x1, y3);
                            ctx.lineTo(x1, y1);
                            ctx.closePath();
                            ctx.fill();
                        }

                    }

                    //-- account section --//
                    Image {
                        id: img_account2
                        source: "qrc:/Content/Images/Utils/taghvim.png"

                        anchors.right: parent.right
                        anchors.rightMargin: 20 * ratio
                        anchors.top: parent.top
                        anchors.topMargin: 20 * ratio
                        height: mycanvas.height * 0.6
                        fillMode: Image.PreserveAspectFit

                    }

                    //-- title --//
                    Label{
                        text: "انتخاب تاریخ"
                        color: Util.color_white
                        font.family: font_iransMedium.name
                        font.pixelSize: Qt.application.font.pixelSize * 2
                        renderType: Text.NativeRendering

                        anchors.right: img_account2.left
                        anchors.rightMargin: 8 * ratio
                        anchors.verticalCenter: img_account2.verticalCenter
                    }
                }

                //-- inputs for editAccountData -//
                Rectangle{
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: "#0000FF00"

                    Rectangle{

                        width: parent.width * 0.7
                        height: parent.height * 0.9
                        anchors.left: parent.left
                        anchors.leftMargin: parent.width * 0.15
                        anchors.top: parent.top
                        anchors.topMargin: parent.height * 0.05
                        color: "#00ffFF00"

                        ColumnLayout{
                            anchors.fill: parent

                            //-- start date --//
                            M_inputText{

                                label: "تاریخ شروع"
                                icon: Icons.calendar_month_outline
                                placeholder: "----/--/--"


                            }

                            //-- spacer --//
                            Item{Layout.preferredHeight: 20 * ratio}

                            //-- finish date --//
                            M_inputText{

                                label: "تاریخ پایان"
                                icon: Icons.calendar_month_outline
                                placeholder: "----/--/--"

                            }

                            //-- spacer --//
                            Item{Layout.preferredHeight: 10 * ratio}

                            Button{
                                id: btn_register

                                text: "تایید"
                                Material.background: Util.color_Material_Blue
                                Material.foreground: Util.color_white
                                font.family: font_iransMedium.name

                                Layout.alignment: Qt.AlignRight
                                Layout.rightMargin: 10 * ratio

                                Rectangle{
                                    width: parent.implicitWidth + (radius*2)
                                    height: parent.implicitHeight * 0.75
                                    anchors.centerIn: parent
                                    anchors.verticalCenterOffset: 0
                                    color: Util.color_Material_Blue
                                    radius: 6
                                }

                                onClicked: {
                                    selectDate()
                                }
                            }

                            //-- filler --//
                            Item{Layout.fillHeight: true}
                        }
                    }
                }
            }

        }


    }
