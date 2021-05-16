import QtQuick 2.14
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.12
import QtGraphicalEffects 1.0

import "./../../Utils/"
import "./../../Modules"
import "./../../Utils/Utils.js" as Util
import "./../../../Fonts/Icon.js" as Icons
import "./../../REST/apiService.js" as Service


ApplicationWindow{
        id: root_forgotpass

        property alias alarmLogin: alarmLoginWin
        property alias user: input_PhoneNumber.inputText

        onClosing: {
            user.text = ""
        }

        signal registe()
        signal forgotPassRequest()

        onForgotPassRequest: {
            //-- clear msg box --//
            alarmLogin.msg = ""


            //-- check user empty --//
            if(root_forgotpass.user.text.length < 11){
                alarm_popup_Forgot.getAlarmData( Icons.alert , "red" , "The Phone Number is not Valid !" , "OK" , false , false , "ltr")
                alarm_popup_Forgot.open()
                return
            }


            //-- check user empty --//
            if(win_forgotPass.user.text === ""){

                alarmLogin.msg = "Please Enter your Phone Number"
                return
            }

            var data = {
                'phone_number': root_forgotpass.user.text
            }

            var endpoint = Service.url_forgotPassword

            Service.logIn( endpoint, data, function(resp, http) {

//                /*authWin*/console.log( "state of " + authWin.objectName + " = " + http.status + " " + http.statusText + ', /n handle log in resp: ' + JSON.stringify(resp))

                //-- check ERROR --//
                if(resp.hasOwnProperty('error')) // chack exist error in resp
                {
                    console.log("error detected; " + resp.error)
                    //                                    alarmLogin.msg = resp.error
                    alarmLogin.msg = "مشکلی در ارتباط با اینترنت وجود دارد"
                    return
                }

                //-- 400-Bad Request, 401-Unauthorized --//
                //-- No active account found with the given credentials --//
                if(http.status === 400 || http.status === 401 || resp.hasOwnProperty('non_field_errors')){

//                                    authWin.log("error detected; " + resp.non_field_errors.toString())
                    //                                    alarmLogin.msg = resp.non_field_errors.toString()
                    alarmLogin.msg = "شماره تلفن وارد شده یافت نشد"
                    return
                }

                root_forgotpass.close()
                show_login()

            })
        }

        visible: true//false//
        minimumWidth: 700
        maximumWidth: 700
        minimumHeight: 500
        maximumHeight: 500
        title: " "
        objectName: "ForgotPass"
        flags: Qt.Dialog //SplashScreen //Dialog //Widget,SubWindow //Sheet //CoverWindow

        MouseArea {
            //            anchors.fill: parent
            width: parent.width
            height: parent.height

            propagateComposedEvents: true
            property real lastMouseX: 0
            property real lastMouseY: 0
            acceptedButtons: Qt.LeftButton
            onMouseXChanged: root_forgotpass.x += (mouseX - lastMouseX)
            onMouseYChanged: root_forgotpass.y += (mouseY - lastMouseY)
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

            RowLayout{
                anchors.fill: parent
                spacing: 0

                //-- logo and intro -//
                Rectangle{
                    Layout.preferredWidth: parent.width * 0.5
                    Layout.fillHeight: true
                    color: "#00FF0000"

                    Image {
                        id: img_intro
                        source: "qrc:/Content/Images/Registration/Signin.jpg"
                        width: parent.width
                        height: parent.height
                        fillMode: Image.PreserveAspectFit

                        Image {
                            id: img_logoIntro
                            source: "qrc:/Content/Images/logo/logo_Blue.png"
                            sourceSize.width: width / 3
                            sourceSize.height: width / 3

                            fillMode: Image.PreserveAspectFit
                            antialiasing: true

                            anchors.top: parent.top
                            anchors.topMargin: 15
                            anchors.left: parent.left
                            anchors.leftMargin: 15

                        }

                        ColumnLayout{
                            anchors.fill: parent
                            spacing: 15

                            Item {
                                Layout.fillHeight: true
                            }

                            Label{
                                Layout.fillWidth: true
                                Layout.preferredHeight: implicitHeight
                                text: "Welcome to ZabanUp"
                                color: Util.color_white
                                font.family: segoeUI.name
                                font.pixelSize: Qt.application.font.pixelSize * 2.2
                                horizontalAlignment: Qt.AlignHCenter
                            }

                            Rectangle{
                                Layout.preferredWidth: parent.width / 11
                                Layout.preferredHeight: 4
                                radius: 2
                                Layout.alignment: Qt.AlignHCenter
                            }

                            Label{
                                Layout.fillWidth: true
                                Layout.preferredHeight: implicitHeight
                                text: "Just Speed Up , Never Give Up"
                                color: Util.color_white
                                font.family: segoeUI.name
                                font.pixelSize: Qt.application.font.pixelSize * 1.3
                                horizontalAlignment: Qt.AlignHCenter
                            }

                            Item {
                                Layout.fillHeight: true
                            }
                        }

                    }

                }

                //-- inputs for ForgotPassword -//
                Rectangle{
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: "#0000FF00"

                    Rectangle{
                        anchors.fill: parent
                        anchors.topMargin: parent.height * 0.15
                        anchors.bottomMargin: parent.height * 0.15
                        anchors.leftMargin: parent.width * 0.15
                        anchors.rightMargin: parent.width * 0.2
                        color: "#00ffFF00"

                        ColumnLayout{
                            anchors.fill: parent
                            spacing: 15

                            //-- filler --//
                            Item{Layout.fillHeight: true}

                            //-- phone or email --//
                            M_inputText{
                                id: input_PhoneNumber
                                label: "شماره تلفن همراه"
                                icon: Icons.cellphone_android
                                placeholder: "Phone Number"
                                Layout.topMargin: -20

                                inputText.validator: RegularExpressionValidator { regularExpression: /^([0]{1})([9]{1})([0-9]{3,9})$/ }

                            }

                            //-- Button Login --//
                            Rectangle{
                                Layout.fillWidth: true
                                Layout.preferredHeight: 38

                                radius: height / 2

                                color: Util.color_DarkBlue

                                Label{
                                    anchors.centerIn: parent
                                    text: "SEND"
                                    font.pixelSize: Qt.application.font.pixelSize * 1
                                    color: "#ffffff"
                                }

                                MouseArea{
                                    anchors.fill: parent
                                    cursorShape: Qt.PointingHandCursor

                                    onClicked: {
                                        forgotPassRequest()
                                    }

                                }
                            }




                            //-- filler --//
                            Item{Layout.fillHeight: true}
                        }
                    }
                }
            }

        }

        //-- Alarm --//
        Rectangle{
            id: alarmLoginWin

            property string msg: ""

            width: parent.width
            height: lblAlarm.implicitHeight * 2.5
            anchors.bottom: parent.bottom

            color: msg === "" ? "transparent" : "#E91E63"

            Label{
                id: lblAlarm
                text: alarmLogin.msg
                anchors.centerIn: parent
                color: "white"
                font.family: iranSans.name
            }
        }

        Alarm_Popup{
            id: alarm_popup_Forgot

            x: (root_forgotpass.width / 2) - (width / 2)
            y: (root_forgotpass.height / 2) - (height / 2)

            onOk_Click: {

                alarm_popup_Forgot.close()
                if(alarm_popup_Forgot.closeMode)
                    root_forgotpass.close()
            }
        }

    }
