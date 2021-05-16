import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.12
import QtGraphicalEffects 1.0

import "./../../Utils/"
import "./../../Utils/Utils.js" as Util
import "./../../REST/apiService.js" as Service
import "./../../../Fonts/Icon.js" as Icons

ApplicationWindow{
        id: root_register

        signal editAccountData()
        onEditAccountData: {
            console.log("editAccountData")

            var data = {
                'name': input_name.inputText.text,
                'email': input_email.inputText.text,
                'gender':"male",
                'favorite_question':[]
            }

            Service.update_item(_token_access , Service.url_userInfo , data , function(res){

                console.log("UPDATED" , JSON.stringify(res))

                userInfo = data

            })



        }
        signal fillInputs(var tel , var email , var name)
        onFillInputs: {
            input_phone.inputText.text = tel
            input_email.inputText.text = email
            input_name.inputText.text = name
        }



        property alias waitingVisible: waiting.visible

        visible: true//false//
        onVisibleChanged: {
            if(visible === true){
                console.log("Visible = True")
                waitingVisible = true
                checkToken(function(res){

                    if(res === true){
                        Service.get_data(_token_access , Service.url_userInfo , null , function(res2){
                            //console.log("MY DATA : " , _userName ,"  ", res2.email ,"  ", res2.name)

                            fillInputs(_userName , res2.email , res2.name)

                            console.log("User Info : " , JSON.stringify(res2))

                            waitingVisible = false

                        })
                    }
                    else{
                        console.log("Please Login !")
                    }


                })

            }
            else{
                console.log("Visible = False")
            }
        }



        minimumWidth: 400
        maximumWidth: 400
        minimumHeight: 400
        maximumHeight: 400
        title: " "
        objectName: "AccountEdit"
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
                        source: "qrc:/Content/Images/Utils/account.png"

                        anchors.right: parent.right
                        anchors.rightMargin: 20 * ratio
                        anchors.top: parent.top
                        anchors.topMargin: 20 * ratio
                        height: mycanvas.height * 0.6
                        fillMode: Image.PreserveAspectFit

                    }

                    //-- title --//
                    Label{
                        text: "اطلاعات کاربری"
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

                            //-- phone --//
                            M_inputText{
                                id: input_phone
                                label: "تلفن همراه"
                                icon: Icons.cellphone_android
                                placeholder: "09xxxxxxxxx"

                            }

                            //-- spacer --//
                            Item{Layout.preferredHeight: 20 * ratio}

                            //-- Email --//
                            M_inputText{
                                id: input_email
                                label: "ایمیل"
                                icon: Icons.email_outline
                                placeholder: "E-Mail"
                            }

                            //-- spacer --//
                            Item{Layout.preferredHeight: 20 * ratio}

                            //-- name --//
                            M_inputText{
                                id: input_name
                                label: "نام و نام خانوادگی"
                                icon: Icons.account
                                placeholder: "Name"

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

                                    win_accountInfoEdit.close()

                                    editAccountData()

                                }
                            }

                            //-- filler --//
                            Item{Layout.fillHeight: true}
                        }
                    }
                }
            }

        }

        Rectangle{
            id: waiting
            visible: false
            anchors.fill: parent
            color: "#80dddddd"

            BusyIndicator {
                anchors.centerIn: parent
                font.pixelSize: 20
                running: waiting.visible === true
            }
        }

    }
