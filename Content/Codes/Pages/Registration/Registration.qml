import QtQuick 2.14
import QtQuick.Window 2.2
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.12
import QtGraphicalEffects 1.0

import "./../../Modules"
import "./../../Utils/"
import "./../../Utils/Utils.js" as Util
import "./../../REST/apiService.js" as Service
import "./../../../Fonts/Icon.js" as Icons
import "./../../Utils/CheckRegisterValidation.js" as RegiserValidation

ApplicationWindow{
    id: root_register

    property alias mobile   : input_MobileNumber.inputText
    property alias email    : input_Email.inputText
    property alias name     : input_Name.inputText
    property string gender  : ""
    property alias pass     : input_Password.inputText
    property alias c_pass   : input_ConfirmPassword.inputText

    property alias swipeIndex: swipe_register.currentIndex


    onClosing: {
        mobile.text = ""
        pass.text = ""
        c_pass.text = ""
        name.text = ""
        email.text = ""
    }

    signal registe()
    property bool checkRegisterValidation : RegiserValidation.checkValidation(mobile.text , email.text , name.text , gender , pass.text , c_pass.text)

    onRegiste: {

        var data = {
            'phone_number': mobile.text,
            'password': pass.text,
            'name': name.text,
            'email': email.text,
            'gender': gender
        }

        var endpoint = Service.url_signup

        Service.logIn( endpoint, data, function(resp, http) {

            console.log( "state of " + authWin.objectName + " = " + http.status + " " + http.statusText + ', /n handle log in resp: ' + JSON.stringify(resp))

            //-- check ERROR --//
            if(resp.hasOwnProperty('error')) // chack exist error in resp
            {
                authWin.log("error detected; " + resp.error)
                //                                    alarmLogin.msg = resp.error
                alarmSignupWin.msg = "مشکلی در ارتباط با اینترنت وجود دارد"
                return
            }

            //-- 400-Bad Request, 401-Unauthorized --//
            //-- No active account found with the given credentials --//
            if(http.status === 400 || http.status === 401 || resp.hasOwnProperty('non_field_errors')){

                //                                    authWin.log("error detected; " + resp.non_field_errors.toString())
                //                                    alarmLogin.msg = resp.non_field_errors.toString()
                alarmSignupWin.msg = "کاربری با مشخصات وارد شده یافت نشد"
                return
            }

            _token_access = resp.access
            _token_refresh = resp.refresh

            //-- save user and pass --//
            _userName = win_login.user.text
            _password = win_login.pass.text

            isLogined = true

            //-- save in Setting --//
            setting.username        = _userName
            setting.password        = _password
            setting.token_access    = _token_access
            setting.token_refresh   = _token_refresh

            root_register.visible = false

        })

        //        mobile.text = ""
        //        email.text = ""
        //        name.text = ""
        //        pass.text = ""
        //        c_pass.text = ""


        alarm_popup.getAlarmData(Icons.check_all , "#00ff00" , "حساب کاربری به موفقیت ایجاد شد" , "تایید" , true , false , "rtl")
        alarm_popup.open()

    }

    visible: true//false//

    minimumWidth: 700
    maximumWidth: 700
    minimumHeight: 500
    maximumHeight: 500

    title: " "
    objectName: "Registration"
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

            //-- inputs for Register -//
            Rectangle{
                Layout.fillWidth: true
                Layout.fillHeight: true
                //color: "#0000FF00"

                SwipeView{
                    id: swipe_register
                    anchors.fill: parent
                    clip: true
                    interactive: false
                    currentIndex: 0

                    onCurrentIndexChanged: {
                        if(currentIndex === 1){
                            timer_confirmSMS.resetTimer()
                            timer_confirmSMS.minutes = 1
                            timer_confirmSMS.startTimer()
                        }
                    }

                    //-- fill inputs --//
                    Item {
                        Rectangle{
                            anchors.fill: parent
                            anchors.topMargin: parent.height * 0.03
                            anchors.bottomMargin: parent.height * 0.03
                            anchors.leftMargin: parent.width * 0.15
                            anchors.rightMargin: parent.width * 0.2
                            color: "#00ffFF00"

                            ColumnLayout{
                                anchors.fill: parent
                                spacing: 10

                                //-- spacer --//
                                Item{Layout.fillHeight: true}

                                //-- "Sign up to  ZabanUp Account" text --//
                                Label{
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: implicitHeight
                                    text: "Sign up to ZabanUp Account"
                                    color: Util.color_DarkBlue
                                    font.family: segoeUI.name
                                    font.pixelSize: Qt.application.font.pixelSize * 1.3
                                    horizontalAlignment: Qt.AlignHCenter

                                }

                                //-- spacer --//
                                Item{Layout.preferredHeight: 10}

                                //-- phone --//
                                M_inputText{
                                    id: input_MobileNumber
                                    label: "تلفن همراه"
                                    icon: Icons.cellphone_android
                                    placeholder: "Phone Number"

                                    inputText.validator: RegularExpressionValidator { regularExpression: /^([0]{1})([9]{1})([0-9]{3,9})$/ }

                                    Keys.onTabPressed: {
                                        input_Email.inputText.forceActiveFocus()
                                    }
                                }

                                //-- EMail --//
                                M_inputText{
                                    id: input_Email
                                    label: "ایمیل"
                                    icon: Icons.email_outline
                                    placeholder: "E-Mail"

                                    inputText.validator: RegularExpressionValidator { regularExpression: /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/ }

                                    Keys.onTabPressed: {
                                        input_Name.inputText.forceActiveFocus()
                                    }
                                }

                                //-- name --//
                                M_inputText{
                                    id: input_Name
                                    label: "نام و نام خانوادگی"
                                    icon: Icons.account
                                    placeholder: "Name"

                                    Keys.onTabPressed: {
                                        radio_Male.forceActiveFocus()
                                    }
                                }

                                //-- Gender --//
                                Rectangle{
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 45 * ratio
                                    Layout.rightMargin: 10 * ratio


                                    Label{
                                        id:lbl_Gender
                                        width: implicitWidth
                                        height: parent.height
                                        verticalAlignment: Qt.AlignVCenter
                                        anchors.left: parent.left

                                        text: "Gender : "
                                        font.family: segoeUI.name
                                        font.pixelSize: Qt.application.font.pixelSize
                                    }

                                    ButtonGroup {id: genderRadios}
                                    RadioButton {
                                        id:radio_Male
                                        anchors.left: lbl_Gender.right
                                        width: implicitWidth
                                        height: implicitHeight
                                        font.family: segoeUI.name
                                        font.pixelSize: Qt.application.font.pixelSize
                                        anchors.verticalCenter: parent.verticalCenter
                                        Material.accent: Util.color_BaseBlue

                                        text: "Male"
                                        ButtonGroup.group: genderRadios

                                        onCheckedChanged: {
                                            if(checked) gender = "male"
                                        }

                                        Keys.onTabPressed: {
                                            radio_Female.forceActiveFocus()
                                        }

                                    }

                                    RadioButton {
                                        id:radio_Female
                                        anchors.left: radio_Male.right
                                        width: implicitWidth
                                        height: implicitHeight
                                        font.family: segoeUI.name
                                        font.pixelSize: Qt.application.font.pixelSize
                                        anchors.verticalCenter: parent.verticalCenter
                                        Material.accent: Util.color_BaseBlue

                                        text: "Female"
                                        ButtonGroup.group: genderRadios

                                        onCheckedChanged: {
                                            if(checked) gender = "female"
                                        }

                                        Keys.onTabPressed: {
                                            input_Password.inputText.forceActiveFocus()
                                        }

                                    }

                                }

                                //-- password --//
                                M_inputText{
                                    id: input_Password

                                    label: "رمز عبور"
                                    icon: Icons.lock_outline
                                    placeholder: "Password (8-Character)"
                                    echoMode: TextInput.Password
                                    clearEnable: true
                                    inputText.maximumLength: 16

                                    Label{
                                        id: lbl_eyeIcon
                                        width: implicitWidth
                                        height: parent.height
                                        anchors.left: parent.right
                                        anchors.leftMargin: 10
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
                                                    input_ConfirmPassword.echoMode = TextInput.Password
                                                }
                                                else{
                                                    lbl_eyeIcon.text = Icons.eye
                                                    input_Password.echoMode = TextInput.Normal
                                                    input_ConfirmPassword.echoMode = TextInput.Normal
                                                }
                                                passViewHandler = !passViewHandler
                                            }
                                        }
                                    }


                                    Keys.onTabPressed: {
                                        input_ConfirmPassword.inputText.forceActiveFocus()
                                    }

                                    /*inputText.onTextChanged: {
                                        if(input_ConfirmPassword.inputText.text !== ""){
                                            if(input_ConfirmPassword.inputText.text !== input_Password.inputText.text){
                                                tooltip_wrongForm.show("رمز عبور و تایید رمز عبور یکسان نیستند." , 1500)
                                            }
                                        }
                                    }*/
                                }

                                //-- Confirm password --//
                                M_inputText{
                                    id: input_ConfirmPassword

                                    label: "تایید رمز عبور"
                                    icon: Icons.lock
                                    placeholder: "Confirm Password"
                                    echoMode: TextInput.Password
                                    clearEnable: true
                                    inputText.maximumLength: 16

                                    Keys.onTabPressed: {
                                        btn_register.forceActiveFocus()
                                    }

                                    /*inputText.onTextChanged: {
                                        if(input_Password.inputText.text !== ""){
                                            if(input_Password.inputText.text !== input_ConfirmPassword.inputText.text){
                                                tooltip_wrongForm.show("رمز عبور و تایید رمز عبور یکسان نیستند." , 1500)
                                            }
                                        }
                                    }*/

                                    Label{
                                        id: lbl_confirmIcon

                                        visible: (input_Password.inputText.text === input_ConfirmPassword.inputText.text) &&
                                                 (input_Password.inputText.text !== "" && input_ConfirmPassword.inputText.text !== "") ? true : false
                                        width: implicitWidth
                                        height: parent.height
                                        anchors.right: parent.left
                                        anchors.rightMargin: 10 * ratio
                                        verticalAlignment: Qt.AlignVCenter
                                        text: Icons.check
                                        color: "#6d8517"
                                        font.family: webfont.name
                                        font.pixelSize: Qt.application.font.pixelSize * 2

                                    }


                                }

                                //-- spacer --//
                                Item{Layout.preferredHeight: 10}

                                //-- Button SIGN UP --//
                                Rectangle{
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 38

                                    radius: height / 2

                                    color: Util.color_DarkBlue

                                    Label{
                                        anchors.centerIn: parent
                                        text: "SIGN UP"
                                        font.pixelSize: Qt.application.font.pixelSize * 1
                                        color: "#ffffff"
                                    }

                                    MouseArea{
                                        id: btn_register
                                        anchors.fill: parent
                                        cursorShape: Qt.PointingHandCursor

                                        onClicked: {

                                            //-- clear msg box --//
                                            alarmSignupWin.msg = ""

                                            console.log("checkValidation === " , checkRegisterValidation)

                                            if(!checkRegisterValidation){
                                                print("validation fault, ", checkRegisterValidation)
                                                alarm_popup.getAlarmData(Icons.format_list_bulleted_square , "#444444" , "لطفا تمامی موارد را به دقت چک کنید" , "باشه" , false , true , "rtl")

                                                alarm_popup.row1_Visible = true
                                                alarm_popup.isWrong_Row1 = RegiserValidation.validateMobile(mobile.text)
                                                console.log("Mobile = " + alarm_popup.isWrong_Row1)
                                                alarm_popup.text_1 = (alarm_popup.isWrong_Row1) ? "شماره موبایل درست است" : "این شماره موبایل قبلا ثبت شده است"

                                                alarm_popup.row2_Visible = true
                                                alarm_popup.isWrong_Row2 = RegiserValidation.validateEmail(email.text)
                                                console.log("Email = "+ alarm_popup.isWrong_Row2)
                                                alarm_popup.text_2 = (alarm_popup.isWrong_Row2) ? "ایمیل به درستی وارد شده است" : "ایمیل به درستی وارد نشده است"

                                                alarm_popup.row3_Visible = true
                                                alarm_popup.isWrong_Row3 = RegiserValidation.validateName(name.text)
                                                console.log("Name = "+ alarm_popup.isWrong_Row3)
                                                alarm_popup.text_3 = (alarm_popup.isWrong_Row3) ? "نام به درستی وارد شده است" : "لطفا یک نام انتخاب کنید"

                                                alarm_popup.row4_Visible = true
                                                alarm_popup.isWrong_Row4 = RegiserValidation.validateGender(gender)
                                                console.log("Password = "+ alarm_popup.isWrong_Row4)
                                                alarm_popup.text_4 = (alarm_popup.isWrong_Row4) ? "جنسیت وارد شده است" : "لطفا جنسیت را انتخاب کنید"

                                                alarm_popup.row5_Visible = true
                                                alarm_popup.isWrong_Row5 = RegiserValidation.validatePassword(pass.text , c_pass.text)
                                                console.log("Password = "+ alarm_popup.isWrong_Row5)
                                                alarm_popup.text_5 = (alarm_popup.isWrong_Row5) ? "پسورد مورد قبول است" : "پسورد قوی نیست یا پسوردها یکی نیستند"

                                                alarm_popup.open()
                                                return
                                            }

                                            timer_confirmSMS.visible = true
                                            lbl_SendAgain.visible = false
                                            swipe_register.currentIndex = 1
                                            //registe()
                                        }


                                        Keys.onTabPressed: {
                                            input_MobileNumber.inputText.forceActiveFocus()
                                        }

                                    }
                                }

                                //-- filler --//
                                Item{Layout.fillHeight: true}
                            }


                        }

                    }

                    //-- Confirm phone Number --//
                    Item {
                        Rectangle{
                            anchors.fill: parent
                            anchors.leftMargin: parent.width * 0.15
                            anchors.rightMargin: parent.width * 0.2

                            //color: "red"


                            ColumnLayout{
                                anchors.fill: parent
                                spacing: 10

                                //-- spacer --//
                                Item{Layout.fillHeight: true}

                                //-- "Confirmation Code" text --//
                                Label{
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: implicitHeight
                                    text: "Send Confirmation Code to :"
                                    color: Util.color_DarkBlue
                                    font.family: segoeUI.name
                                    font.pixelSize: Qt.application.font.pixelSize * 1.3
                                    horizontalAlignment: Qt.AlignHCenter

                                }

                                //-- "phoneNumber" and "Phone number correction" --//
                                Item {
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 50
                                    Layout.topMargin: -10

                                    RowLayout{
                                        anchors.fill: parent
                                        spacing: 10

                                        //-- spacer --//
                                        Item{Layout.fillWidth: true}

                                        //-- "phoneNumber" text --//
                                        Label{
                                            Layout.preferredWidth: implicitWidth
                                            Layout.preferredHeight: implicitHeight
                                            text: input_MobileNumber.inputText.text
                                            color: "#444444"
                                            font.family: segoeUI.name
                                            font.pixelSize: Qt.application.font.pixelSize * 1.3
                                            horizontalAlignment: Qt.AlignHCenter

                                        }

                                        //-- "Phone number correction" text --//
                                        Label{
                                            Layout.preferredWidth: implicitWidth
                                            Layout.preferredHeight: implicitHeight
                                            text: "Change"
                                            color: Util.color_DarkBlue
                                            font.family: segoeUI.name
                                            font.pixelSize: Qt.application.font.pixelSize * 1.1
                                            horizontalAlignment: Qt.AlignHCenter

                                            MouseArea{
                                                anchors.fill: parent
                                                cursorShape: Qt.PointingHandCursor
                                                onClicked: {
                                                    swipeIndex = 0
                                                    input_MobileNumber.inputText.forceActiveFocus()
                                                    input_MobileNumber.inputText.selectAll()
                                                }
                                            }

                                        }

                                        //-- spacer --//
                                        Item{Layout.fillWidth: true}

                                    }
                                }



                                //-- spacer --//
                                //Item{Layout.preferredHeight: 10}

                                //-- TextInput Confirm --//
                                Rectangle{
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 38

                                    radius: height / 2

                                    border.width: 2
                                    border.color: Util.color_DarkBlue

                                    //-- TextField --//
                                    TextInput{
                                        id:txf_confirm

                                        clip: true
                                        maximumLength: 5

                                        horizontalAlignment: Qt.AlignHCenter
                                        verticalAlignment: Qt.AlignVCenter

                                        width: parent.width - (parent.radius * 2)
                                        height: parent.height - (parent.border.width * 2)
                                        anchors.centerIn: parent

                            //            width: parent.width - lbl_icon.implicitWidth - lbl_clear.implicitWidth  // Width of Rect - Width of Magnify
                            //            height: parent.height


                                        font.family: iranSans.name
                                        font.pixelSize: Qt.application.font.pixelSize * 1.3
                                        font.letterSpacing: 15

                                        selectByMouse: true

                                        validator: RegularExpressionValidator { regularExpression: /^[0-9]{5}$/ }

                                        onTextChanged: {
                                            if(length === 5){
                                                btn_Confirm.forceActiveFocus()
                                            }
                                        }


                                        //-- placeholder --//
                                        Label{
                                            id: lbl_placeholder

                                            visible: (txf_confirm.length >= 1) ? false : true

                                            text: "5-Digits"

                                            anchors.centerIn: parent
                                            //anchors.verticalCenter: parent.verticalCenter

                                            font.family: iranSans.name
                                            font.pixelSize: Qt.application.font.pixelSize

                                            color: "#dddddd"

                                            background: Rectangle{
                                                color: "transparent"
                                            }

                                        }

                                    }



                                }

                                //-- Button Confirm --//
                                Rectangle{
                                    id: rect_Confirm
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 38

                                    radius: height / 2

                                    color: Util.color_DarkBlue

                                    Label{
                                        anchors.centerIn: parent
                                        text: "Confirm"
                                        font.pixelSize: Qt.application.font.pixelSize * 1
                                        color: "#ffffff"
                                    }

                                    Rectangle{
                                        id: rect_focus
                                        visible: btn_Confirm.focus ? true : false
                                        width: parent.width - 5
                                        height: parent.height - 5
                                        anchors.centerIn: parent

                                        radius: height / 2
                                        color: "transparent"

                                        border.color: "#ffffff"
                                        border.width: 1


                                    }

                                    MouseArea{
                                        id: btn_Confirm
                                        anchors.fill: parent
                                        cursorShape: Qt.PointingHandCursor

                                        onClicked: {
                                            root_register.visible = false
                                            //registe()
                                        }

                                        Keys.onEnterPressed: {
                                            root_register.visible = false
                                        }

                                    }
                                }

                                //-- module Timer --//
                                Countdown_Timer{
                                    id: timer_confirmSMS
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: lbl_SendAgain.implicitHeight

                                    minutes: 1

                                    //color: "#55ff0000"
                                    lblTimer.color: "#000000"

                                    onSecondChanged: {
                                        if(minutes === 0 && second === 0){
                                            timer_confirmSMS.visible = false
                                            lbl_SendAgain.visible = true
                                        }
                                    }
                                }

                                Label{
                                    id: lbl_SendAgain
                                    visible: false
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: implicitHeight
                                    text: "ارسال مجدد"
                                    color: Util.color_DarkBlue
                                    font.family: iranSans.name
                                    font.pixelSize: Qt.application.font.pixelSize * 1.1
                                    horizontalAlignment: Qt.AlignHCenter

                                    MouseArea{
                                        anchors.fill: parent
                                        cursorShape: Qt.PointingHandCursor
                                        onClicked: {
                                            timer_confirmSMS.resetTimer()
                                            timer_confirmSMS.minutes = 1
                                            timer_confirmSMS.startTimer()
                                            lbl_SendAgain.visible = false
                                            timer_confirmSMS.visible = true



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

        }


    }

    Alarm_Popup{
        id: alarm_popup

        x: (root_register.width / 2) - (width / 2)
        y: (root_register.height / 2) - (height / 2)

        onOk_Click: {

            alarm_popup.close()
            if(alarm_popup.closeMode)
                root_register.close()
        }
    }

    //-- Alarm --//
    Rectangle{
        id: alarmSignupWin

        property string msg: ""

        width: parent.width
        height: lblAlarm.implicitHeight * 2.5
        anchors.bottom: parent.bottom

        color: msg === "" ? "transparent" : "#E91E63"

        Label{
            id: lblAlarm
            text: alarmSignupWin.msg
            anchors.centerIn: parent
            color: "white"
            font.family: iranSans.name
        }
    }

}




/*property var func: function delay(delay, callback){

        timer_delay.cntr = delay
        timer_delay.restart()


    }

        Timer {
            id: timer_delay
            interval: 1 ; running: false; repeat: false;
            property int cntr: 10
            property var del: func
            onTriggered: {
                if(cntr<= 0){
                    timer_delay.stop()
                    del.callback()
                }
            }
        }

        Button{
            text: "test"
            onClicked:{
                func(2000, function(){
                    log("milad")
                })
            }
        }*/

