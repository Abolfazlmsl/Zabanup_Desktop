import QtQuick 2.14
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.12
import QtGraphicalEffects 1.0

import "./../../Utils/"
import "./../../Utils/Utils.js" as Util
import "./../../../Fonts/Icon.js" as Icons

ApplicationWindow{
    id: root_auth

    property alias alarmLogin: alarmLoginWin
    property alias user: input_UserName.inputText
    property alias pass: input_Password.inputText
    property alias chbx_isRemember: cbx_remeber

    signal logIn()
    signal registe()
    signal forgotPass()



    //-- when open LoginPage inputs most be Empty --//
    signal resetForm()
    onResetForm: {
        input_UserName.inputText.text = ""
        input_Password.inputText.text = ""
        input_UserName.inputText.forceActiveFocus()
    }

    visible: true//false//
    minimumWidth: 700
    maximumWidth: 700
    minimumHeight: 500
    maximumHeight: 500
    title: " " //صفحه ورود
    objectName: "Auth"
    flags: Qt.Dialog //SplashScreen //Dialog //Widget,SubWindow //Sheet //CoverWindow

    MouseArea {
        //            anchors.fill: parent
        width: parent.width
        height: parent.height

        propagateComposedEvents: true
        property real lastMouseX: 0
        property real lastMouseY: 0
        acceptedButtons: Qt.LeftButton
        onMouseXChanged: root_auth.x += (mouseX - lastMouseX)
        onMouseYChanged: root_auth.y += (mouseY - lastMouseY)
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

            //-- inputs for login -//
            Rectangle{
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "#0000FF00"

                Rectangle{
                    anchors.fill: parent
                    anchors.topMargin: parent.height * 0.1
                    anchors.bottomMargin: parent.height * 0.1
                    anchors.leftMargin: parent.width * 0.1
                    anchors.rightMargin: parent.width * 0.15
                    color: "#00ffFF00"


                    ColumnLayout{
                        anchors.fill: parent
                        //                        visible: false

                        //-- filler --//
                        Item{Layout.fillHeight: true}

                        //-- "Sign in to your ZabanUp Account" text --//
                        Label{
                            Layout.fillWidth: true
                            Layout.preferredHeight: implicitHeight
                            text: "Sign in to your ZabanUp Account"
                            color: Util.color_DarkBlue
                            font.family: segoeUI.name
                            font.pixelSize: Qt.application.font.pixelSize * 1.3
                            horizontalAlignment: Qt.AlignHCenter

                        }

                        //-- spacer --//
                        Item{Layout.preferredHeight: 15}

                        //-- user name --//
                        M_inputText{
                            id: input_UserName
                            label: "نام کاربری"
                            icon: Icons.account
                            placeholder: "Phone Number"

                            inputText.validator: RegularExpressionValidator { regularExpression: /^([0]{1})([9]{1})([0-9]{3,9})$/ }

                            Keys.onTabPressed: {
                                input_Password.inputText.forceActiveFocus()
                            }

                        }

                        //-- spacer --//
                        Item{Layout.preferredHeight: 5 }

                        //-- password --//
                        M_inputText{
                            id: input_Password

                            label: "رمز عبور"
                            icon: Icons.lock_outline
                            placeholder: "Password"
                            echoMode: TextInput.Password
                            clearEnable: true
                            enterAsAccept: true

                            onAcceptedLogin: {
                                logIn()
                            }

                            Label{
                                id: lbl_eyeIcon
                                width: implicitWidth
                                height: parent.height
                                anchors.left: parent.right
                                anchors.leftMargin: 10 * ratio
                                verticalAlignment: Qt.AlignVCenter
                                text: Icons.eye_off
                                font.family: webfont.name
                                font.pixelSize: Qt.application.font.pixelSize * 2

                                MouseArea{

                                    property bool passViewHandler: false

                                    anchors.fill: parent
                                    cursorShape: Qt.PointingHandCursor


                                    onClicked: {
                                        if(passViewHandler){
                                            lbl_eyeIcon.text = Icons.eye_off
                                            input_Password.echoMode = TextInput.Password
                                        }
                                        else{
                                            lbl_eyeIcon.text = Icons.eye
                                            input_Password.echoMode = TextInput.Normal
                                        }
                                        passViewHandler = !passViewHandler
                                    }
                                }
                            }

                        }

                        //-- spacer --//
                        Item{Layout.preferredHeight: 10 }

                        //-- remember and forgot pass text--//
                        Rectangle {
                            Layout.fillWidth: true
                            Layout.preferredHeight: lblRemember.implicitHeight * 2
                            color: "#00ff0000"

                            RowLayout{
                                anchors.fill: parent

                                CheckBox{
                                    id: cbx_remeber
                                    text: ""
                                    Material.accent : Util.color_DarkBlue

                                    onCheckStateChanged: {
                                        setting.isRemember = checked
                                    }
                                }

                                Label{
                                    id: lblRemember
                                    text: "Keep me Signed in"
                                    color: Util.color_DarkBlue
                                    font.pixelSize: Qt.application.font.pixelSize * 0.8

                                    Layout.leftMargin: -5
                                }

                                //-- forgot pass text --//
                                Label{
                                    id: lbl_forgetPass
                                    Layout.preferredWidth: parent.width / 2
                                    Layout.preferredHeight: implicitHeight
                                    Layout.alignment: Qt.AlignLeft
                                    Layout.leftMargin: 15
                                    text: "Forgot your Password ?"
                                    font.pixelSize: Qt.application.font.pixelSize * 0.8
                                    color: Util.color_DarkBlue

                                    MouseArea{
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        cursorShape: Qt.PointingHandCursor

                                        onClicked: {
                                            forgotPass()
                                        }

                                    }
                                }


                            }
                        }


                        //-- spacer --//
                        Item{Layout.preferredHeight: 10 }

                        //-- Button Login --//
                        Rectangle{
                            Layout.fillWidth: true
                            Layout.preferredHeight: 38

                            radius: height / 2

                            color: Util.color_DarkBlue

                            Label{
                                anchors.centerIn: parent
                                text: "SIGN IN"
                                font.pixelSize: Qt.application.font.pixelSize * 1
                                color: "#ffffff"
                            }

                            MouseArea{
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onClicked: {
                                    logIn()
                                }
                            }
                        }

                        //-- spacer --//
                        Item{Layout.preferredHeight: 15}

                        //-- "Create Account" text --//
                        Label{
                            Layout.fillWidth: true
                            Layout.preferredHeight: implicitHeight
                            text: "Create Account"
                            color: Util.color_DarkBlue
                            font.family: segoeUI.name
                            font.pixelSize: Qt.application.font.pixelSize * 1.1
                            horizontalAlignment: Qt.AlignHCenter

                            MouseArea{
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onClicked: {
                                    registe()
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

}
