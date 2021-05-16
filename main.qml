import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.12
import QtGraphicalEffects 1.0
import Qt.labs.settings 1.0

import "./Content/Codes/Pages"
import "./Content/Codes/Pages/Registration"
import "./Content/Codes/Pages/Account"
import "./Content/Codes/Modules"
import "./Content/Codes/Utils"
import "./Content/Codes/Modules/TypesOfQuestions"
import "./Content/Codes/REST/apiService.js" as Service
import "./Content/Codes/Utils/Utils.js" as Util
import "./Content/Fonts/Icon.js" as Icons
import "./Content/Codes/Utils/ConvertRTFtoPlain.js" as ConvertRTFtoPlain


QtObject {

    property real ratio : 1//(((Screen.pixelDensity * 25.4)/72)) * 0.5  //-- ratio for diffrent screen --//
    property double widthRatio: root.width / 1920
    property double heightRatio: root.height / 1080

    property alias font_iransMedium: iranSansMedium
    property alias font_irans: iranSans
    property alias font_material: webfont
    property alias font_segoeUI: segoeUI

    property string _token_access: ""
    property string _token_refresh: ""
    property bool   isLogined: false
    property string _userName: ""
    property string _password: ""
    property bool   isAdminPermission: false

    //-- information of user in profile page --//
    property var userInfo

    //-- font size --//
    property real _fontSize: Qt.application.font.pixelSize * 1.6

    objectName: "root item"

    //-- show log of console --//
    property bool isLogOff: false

    //-- show login window --//
    signal show_login()
    onShow_login: {
        win_login.visible = true
        win_login.resetForm()
    }

    //-- show registeration window --//
    signal show_registeration()
    onShow_registeration: {
        win_register.swipeIndex = 0
        win_register.visible = true
    }

    //-- show forgot Password window --//
    signal show_forgotPassword()
    onShow_forgotPassword: {
        win_forgotPass.visible = true
    }

    //-- TEST window --//
    property var mainWin2: ApplicationWindow {
        id: root2
        visible: false
        width: 500
        height: 500

        //-

        ListModel{id: test}
        Button{
            text: "Get Data"
            onClicked: {

                var d  = Service.get_all(Service.url_book, function(data, xhr){

                    for(var i=0 ; i< data.length ; i++){

                        //console.log(data[i].name)
                        test.append(data[i])
                    }


                    console.log("test.count: ", test.count)

                    for(var j=0; j< test.count; j++){
                        print("j ",test.get(i).name)
                    }

                })

                /*var data  = Service.request('GET' , 'http://kootwall.com/api/kootwall/Category')
                for(var i=0 ; i< data.length ; i++){
                    console.log(data[i].title)
                }*/
            }
        }


        Button{
            text: "Get SubCategory Data"
             y: 40
            onClicked: {
                var d  = Service.request('GET' , 'http://kootwall.com/api/kootwall/BaseCategory', function(data){

                    for(var i=0 ; i< data.length ; i++){
                        console.log(data[i].title)
                    }

                })
                /*var data  = Service.request('GET' , 'http://kootwall.com/api/kootwall/Category')
                for(var i=0 ; i< data.length ; i++){
                    console.log(data[i].title)
                }*/
            }
        }
    }

    //-- main window --//
    property var mainWin: ApplicationWindow {
        id: root

        property bool visibilityOfWinChanged : false
        onVisibilityChanged: {
            visibilityOfWinChanged = !visibilityOfWinChanged
        }

        //-- global timer (in page ..) --//
        property var global_countDownTimer

        property alias _PassageTestQuestions : model_PassageTestQuestions
        ListModel{id: model_PassageTestQuestions}

        property alias _FullTestQuestions_1 : model_FullTestQuestionsSection1
        ListModel{id: model_FullTestQuestionsSection1}
        property alias _FullTestQuestions_2 : model_FullTestQuestionsSection2
        ListModel{id: model_FullTestQuestionsSection2}
        property alias _FullTestQuestions_3 : model_FullTestQuestionsSection3
        ListModel{id: model_FullTestQuestionsSection3}
        property var _PaasageText : ""
        property var _FullText_1 : ""
        property var _FullText_2 : ""
        property var _FullText_3 : ""

        //flags: Qt.WindowCloseButtonHint
        FontLoader{ id: segoeUI; source: "qrc:/Content/Fonts/segoeui.ttf"}                          // segoeUI FONT
        FontLoader{ id: iranSans; source: "qrc:/Content/Fonts/IRANSansMobile.ttf"}                  // iransans FONT
        FontLoader{ id: iranSansFAnum; source: "qrc:/Content/Fonts/IRANSansMobile(FaNum).ttf"}                  // iranSans FARSI number FONT
        FontLoader{ id: iranSansMedium; source: "qrc:/Content/Fonts/IRANSans_Medium.ttf"}           // iransans Medium FONT
        FontLoader{ id: webfont; source: "qrc:/Content/Fonts/materialdesignicons-webfont.ttf"}      //ICONS FONT
        FontLoader{ id: nunito; source: "qrc:/Content/Fonts/Nunito/Nunito-Regular.ttf"}      //ICONS FONT
        FontLoader{ id: nunito_italic; source: "qrc:/Content/Fonts/Nunito/Nunito-Italic.ttf"}      //ICONS FONT

        //-- font metric for size porpose --//
        FontMetrics{
            id: fontMetric
            font.family: iranSans.name
            font.pixelSize: Qt.application.font.pixelSize
        }

        visible: true
        title: qsTr(" ")
        font.family: font_irans.name
        objectName: "main"

        minimumWidth: 1024
        minimumHeight: 720

        width: Screen.width / 2

        height: Screen.height / 2

        visibility: "Windowed"  // FullScreen , Maximized , Windowed

        //-- global models --//
        ListModel{id: model_Books}
        ListModel{id: model_FilterTopic}
        ListModel{id: model_FilterTypeofQuestion}
        ListModel{id: model_FilterTypeofText}
        ListModel{id: model_LoadPassages}
        ListModel{id: model_LoadPassages_backup}
        ListModel{id: model_LoadTexts}
        ListModel{id: model_LoadTexts_backup}
        ListModel{id: model_PassageTest}

        //-- body --//
        Home{
            id:home
        }


        Button{
            text: "test"
            visible: false//true
            onClicked: {
                var obj = {
                    'obj1': 'data1',
                    'obj2': 'data2',
                    'objNest': {
                        'subObj1': 'dataSubObj1'
                    }
                }



//                obj = JSON.parse(temp)

//                print(JSON.stringify(obj))

                //-- load passageInfo for passageTest--// --------------------------------------------------
                var f  = Service.get_all(Service.url_passageTest , function(data){
    //                print("data: ", JSON.stringify(data))
    //                print(data.length)

                    var temp = data

                    console.log("DATA : " , temp)

                    model_PassageTest.clear()

                    model_PassageTest.append(temp)

//                    obj = JSON.parse(data)

                    //-- JSON to S

//                    for(var i=0 ; i< data.length ; i++){

//                        delete data[i]['questions']; //-- delete object element --//
//                        delete data[i]['subject'];   //-- delete object element --//

//                    }

                })


//                console.log("  TEMP = " + temp.length )  //مثال خیلی مهم console.log("  TEMP = " + obj['text'])
//                console.log("  TEMP = " + JSON.stringify(obj['exam'])) //مثال خیلی مهم  console.log("  TEMP = " + JSON.stringify(obj['exam']))


            }
        }

        onClosing: {
            close.accepted = false
            exitProgram.open()
        }

        onWidthChanged: {
//            console.log("width = " + width + "    widthRatio = " + widthRatio + "    heightRatio = " + heightRatio)
        }

        Quit_Popup{
            id:exitProgram

            width: 350 * ratio * sizeRatio
            height: 181 * ratio * sizeRatio

            x: (root.width / 2) - (width / 2)
            y: (root.height / 2) - (height / 2)

        }

        Component.onCompleted: {


            //-- load Passage on SelectTestPage --// ---------------------------------------------------
            var e  = Service.get_all(Service.getPassages("","","",""), function(data){

//                print("data: ", JSON.stringify(data))
//                print(data.length)

                //-- JSON to S

                for(var i=0 ; i< data.length ; i++){

                    var subjs = ""
                    //-- parse subject sub-array --//
                    for(var j=0 ; j< data[i].subject.length ; j++){
                        if(j===0) subjs = data[i].subject[j].name
                        else subjs = subjs +','+ data[i].subject[j].name
                    }

                    delete data[i]['subject']; //-- delete object element --//
                    data[i]['subject'] = subjs  //-- add custom item to json --//

//                    print(JSON.stringify(data[i]))
                    model_LoadPassages.append(data[i])
                    console.log("DATA : " , data[i].id)
                    model_LoadPassages_backup.append(data[i])
                }
                addPassageQuestionNumber()
            })

            //-- load Passage on SelectTestPage --// ---------------------------------------------------
            var e  = Service.get_all(Service.getFulltext("","","",""), function(data){

//                print("data: ", JSON.stringify(data))
//                print(data.length)

                //-- JSON to S

                for(var i=0 ; i< data.length ; i++){

                    var subjs = ""
                    //-- parse subject sub-array --//
                    subjs = data[i].book.name

                    delete data[i]['subject']; //-- delete object element --//
                    data[i]['subject'] = subjs  //-- add custom item to json --//

//                    print(JSON.stringify(data[i]))
                    model_LoadTexts.append(data[i])
                    console.log("DATA : " , model_LoadTexts.count)
                    model_LoadTexts_backup.append(data[i])
                }
                addFulltextQuestionNumber()

            })

            //-- load filters on SelectTestPage (Book) --// --------------------------------------------
            var d  = Service.get_all(Service.url_bookFilter, function(data){

                for(var i=0 ; i< data.length ; i++){
                    //console.log(data[i].name)
                    model_Books.append(data[i])
                    model_Books.set(i , {"isSelected": false , "type": "Book"})
                }

            })

            //-- load filters on SelectTestPage (Topic) --// -------------------------------------------
            var a  = Service.get_all(Service.url_topicFilter, function(data){

                for(var i=0 ; i< data.length ; i++){
                    model_FilterTopic.append(data[i])
                    model_FilterTopic.set(i , {"isSelected": false})
//                    console.log("DATA : " , data[i].name)
                }

            })

            //-- load filters on SelectTestPage (Type of Question)--// ---------------------------------
            var b  = Service.get_all(Service.url_typeofQuestionFilter, function(data){

                for(var i=0 ; i< data.length ; i++){
                    model_FilterTypeofQuestion.append(data[i])
                    model_FilterTypeofQuestion.set(i , {"isSelected": false})
//                    console.log("DATA : " , data[i].name)
                }

            })

            //-- load filters on SelectTestPage (Type of Question)--// ---------------------------------
            var c  = Service.get_all(Service.url_typeofTextFilter, function(data){

                for(var i=0 ; i< data.length ; i++){
                    model_FilterTypeofText.append(data[i])
                    model_FilterTypeofText.set(i , {"isSelected": false})
//                    console.log("DATA : " , data[i].name)
                }

            })


            return
            //-- load passageInfo for passageTest--// --------------------------------------------------
            var f  = Service.get_all(Service.url_passageTest, function(data){
//                print("data: ", JSON.stringify(data))
//                print(data.length)
                console.log("DATA : " , JSON.stringify(data))

                //-- JSON to S

                for(var i=0 ; i< data.length ; i++){

                    delete data[i]['questions']; //-- delete object element --//
                    delete data[i]['subject'];   //-- delete object element --//

                    print(JSON.stringify(data[i]))
                    model_PassageTest.append(data[i])
                }

            })

        }
    }

    //-- save app setting --//
    property var setting: Settings{
        id: setting

        property string username: ""
        property string password: ""
        property string token_access: ""
        property string token_refresh: ""
        property bool   isRemember

        property alias mainWinWidth: root.width
        property alias mainWinHeight: root.height

    }


    //-- auth --//
    property var authWin:  LogIn{
        id: win_login

        visible: false //false//true

        minimumWidth: 700
        maximumWidth: 700
        minimumHeight: 500
        maximumHeight: 500


        Component.onCompleted: {

            win_login.chbx_isRemember.checked = setting.isRemember

            if(!win_login.chbx_isRemember.checked) return

            _token_access       = setting.token_access
            _token_refresh      = setting.token_refresh
            _userName           = setting.username
            _password           = setting.password
            win_login.user.text       = setting.username
            win_login.pass.text       = setting.password


            //-- auto click --//
            if(win_login.user.text != "" && win_login.pass.text != ""){
                logIn()
            }

            //            log(setting.username + "," + setting.password)
        }

        //-- login --//
        onLogIn:{
            console.log("login")
            //-- clear msg box --//
            alarmLogin.msg = ""

            //-- check user empty --//
            if(win_login.user.text === ""){

                alarmLogin.msg = "لطفا نام کاربری را وارد کنید"
                return
            }

            //-- check pass empty --//
            if(win_login.pass.text === ""){

                alarmLogin.msg = "لطفا رمز عبور را وارد کنید"
                return
            }

            var data = {
                'phone_number': win_login.user.text,
                'password': win_login.pass.text
            }

            var endpoint = "api/token/"

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
                    alarmLogin.msg = "کاربری با مشخصات وارد شده یافت نشد"
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

                win_login.visible = false

                console.log("Token = " , _token_access)

            })



        }

        onRegiste: {
            console.log("Registe")
            win_login.visible = false
            show_registeration()
        }
        onForgotPass: {
            console.log("ForgotPass")
            win_login.visible = false
            show_forgotPassword()
        }
    }

    //-- Registration --//
    property var registrationWin: Registration{
        id: win_register

        visible: false//true//false//

        minimumWidth: 700
        maximumWidth: 700
        minimumHeight: 500
        maximumHeight: 500

        onRegiste: {
//            console.log("Registe")
//            win_register.visible = false
//            show_login()
        }
    }

    //-- ForgotPassword --//
    property var forgotPassWin: ForgotPassword{
        id: win_forgotPass

        visible: false//false//

        minimumWidth: 700
        maximumWidth: 700
        minimumHeight: 500
        maximumHeight: 500

        onRegiste: {
            console.log("Registe")
            win_forgotPass.visible = false
            show_registeration()
        }

    }

    //-- Account Info Edit --//
    property var accountChangeWin: AccountInfoEdit{
        id: win_accountInfoEdit

        visible: false//false//

        minimumWidth: 400// * ratio
        maximumWidth: 400// * ratio
        minimumHeight: 400// * ratio
        maximumHeight: 400// * ratio

        onEditAccountData: {

        }

    }

    //-- Pass edit --//
    property var passChangeWin: AccountPasswordEdit{
        id: win_accountPasswordEdit

        visible: false//false//

        minimumWidth: 700 * ratio
        maximumWidth: 700 * ratio
        minimumHeight: 600 * ratio
        maximumHeight: 600 * ratio

        onEditPass: {
            console.log("editAccountData")
        }
    }

    //-- date selector --//
    property var dateSelectorWin: DateSelect{
        id: win_dateSelect

        visible: false//

        minimumWidth: 700 * ratio
        maximumWidth: 700 * ratio
        minimumHeight: 600 * ratio
        maximumHeight: 600 * ratio

        onSelectDate: {
            console.log("selectDate")
        }
    }


    //-- referesh token --//
    function refereshToken(cb){

        var data = {
            'refresh': _token_refresh
        }

        var endpoint = "api/token/refresh/"

        Service.verify( endpoint, data, function(resp, http) {

            console.log( "state = " + http.status + " " + http.statusText + ', /n handle refersh resp: ' + JSON.stringify(resp))

            //-- check ERROR --//
            if(resp.hasOwnProperty('error')) // chack exist error in resp
            {
                mainWin.log("error detected; " + resp.error)
                win_login.alarmLogin.msg = resp.error
                if(cb) cb(false)
                return false
            }

            //-- 200- OK --//
            if(http.status === 200 || resp.hasOwnProperty('access')){

                //                log("Unauthorized; " + resp.detail.toString())
                //                alarmLogin.msg = resp.detail.toString()

                //-- refresh token --//
                _token_access = resp.access
                console.log("new access toke refreshed")
                if(cb) cb(true)
                return true
            }

            console.log("new access token was not refreshed")
            if(cb) cb(false)
            return false

        })

    }

    //-- verify token (referesh/access) --//
    function verifyToken(token, cb){


        var data = {
            'token': token //_token_refresh //_token_access
        }

        var endpoint = "api/token/verify/"

        Service.verify( endpoint, data, function(resp, http) {

//            console.log( "state = " + http.status + " " + http.statusText + ', /n handle verify_token resp: ' + JSON.stringify(resp))

            //-- check ERROR --//
            if(resp.hasOwnProperty('error')) // chack exist error in resp
            {
                console.log("error detected; " + resp.error)
                win_loginalarmLogin.msg = resp.error
                if(cb) cb(false)
                return
            }

            //-- 401- Unauthorized --//
            if(http.status === 401 || http.status === 400 || resp.hasOwnProperty('detail')){

                //                log("Unauthorized; " + resp.detail.toString())
                //                alarmLogin.msg = resp.detail.toString()
                if(cb) cb(false)
                return

                //-- refresh token --//
            }

            if(cb) cb(true)
            return

        })

    }

    //-- check token --//
    function checkToken(cb){

        //-- check user logIn status --//
        /*if(!isLogined){
            mainWin.log("LogIned Please")
            if(cb) cb(false)
            return false
        }*/

        //-- verify access token --//
        console.log("check access token ...")
        verifyToken(_token_access, function(resp) {
//            console.log("resp _token_access = " + resp)

            //-- access token is valid --//
            if(resp){
                if(cb) cb(true)
                return true
            }
            else{

                //-- verify referesh token --//
//                console.log("check referesh token ...")
                verifyToken(_token_refresh, function(resp) {
//                    console.log("resp _token_referesh = " + resp)

                    if(!resp){

                        console.log("refresh token expired; user loged out")
                        isLogined = false
                        if(cb) cb(false)
                        return false
                    }
                    else{

                        console.log("try to refresh access token")
                        //-- referesh token --//
                        refereshToken(function(resp) {

//                            console.log("resp referesh access Token status: = " + resp)

                            //-- access token refereshed --//
                            if(resp){
                                if(cb) cb(true)
                                return true
                            }
                            else{

                                console.log("new access token was not refreshed")
                                if(cb) cb(false)

                                return false
                            }

                        })
                    }
                })
            }
        })


    }


    //-- logout --//
    function logout(){
        //-- LogOut proccess --//
        if(isLogined){

            //-- remove signIn saved setting property --//
            setting.username = ""
            setting.password = ""
            setting.token_access  = ""
            setting.token_refresh = ""

            _token_access = ""
            _token_refresh = ""

            //-- save user and pass --//
            _userName = ""
            _password = ""

            isLogined = false
            isAdminPermission = false
        }
        else{
            print("user already logged out")
        }
    }

    function log(arg1, arg2){

        if(isLogOff) return;

        if(arg2 !== undefined){

            if(arg1 !== false) console.log(arg2)
        }

        else if(arg1 !== undefined){

            console.log(arg1)
        }

    }

    function addFulltextQuestionNumber(){
        for (var num=1; num<=model_LoadTexts.count; num++){
            var d  = Service.get_all(Service.url_fullTest + num , function(data){
                root._FullTestQuestions_1.clear()
                root._FullTestQuestions_2.clear()
                root._FullTestQuestions_3.clear()
                var id = data.id
                for (var k=0; k < data.passages.length; k++){

                    var firstData = JSON.stringify(data.passages[k])

                    var indx = firstData.indexOf('\\n')
                    while(indx !== -1){
                        firstData = firstData.replace('\\n' , "")
                        indx = firstData.indexOf('\\n')
                    }

                    var indx1 = firstData.indexOf('\\r')
                    while(indx1 !== -1){
                        firstData = firstData.replace('\\r' , "")
                        indx1 = firstData.indexOf('\\r')
                    }

                    var indx2 = firstData.indexOf('null')
                    while(indx2 !== -1){
                        firstData = firstData.replace('null' , "0")
                        indx2 = firstData.indexOf('null')
                    }

                    var firstDataJSON = JSON.parse(firstData)

                    var handleQuestion = []
                    for(var i = 0 ; i < firstDataJSON.question_description.length ; i++){
                        handleQuestion.push(firstDataJSON.question_description[i])
                    }

                    var myQuestionDataJson = JSON.parse(JSON.stringify(handleQuestion))
                    for(var j = 0 ; j < myQuestionDataJson[0].questions.length ; j++){
                        myQuestionDataJson[0].questions[j].text = myQuestionDataJson[0].questions[j].text.replace('<p>' , '<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;')
                    }

                    if (k===0){
                        root._FullTestQuestions_1.append(myQuestionDataJson)
                    }else if (k===1){
                        root._FullTestQuestions_2.append(myQuestionDataJson)
                    }else{
                        root._FullTestQuestions_3.append(myQuestionDataJson)
                    }
                }
                getTotalQuestions(id)
            })
        }
    }

    function addPassageQuestionNumber(){
        var passgeQuestion = 0
        for (var num=1; num<=model_LoadPassages.count; num++){
            var d  = Service.get_all(Service.url_passageTest + num , function(data){
                passgeQuestion = 0
                var firstData = JSON.stringify(data)
                var id = data.id

                var indx = firstData.indexOf('\\n')
                while(indx !== -1){
                    firstData = firstData.replace('\\n' , "")   //\n
                    indx = firstData.indexOf('\\n')
                }

                var indx1 = firstData.indexOf('\\r')
                while(indx1 !== -1){
                    firstData = firstData.replace('\\r' , "")  // \r
                    indx1 = firstData.indexOf('\\r')
                }

                var indx2 = firstData.indexOf('null')
                while(indx2 !== -1){
                    firstData = firstData.replace('null' , "0")
                    indx2 = firstData.indexOf('null')
                }

                var firstDataJSON = JSON.parse(firstData)

                var handleQuestion = []
                for(var i = 0 ; i < firstDataJSON.question_description.length ; i++){
                    handleQuestion.push(firstDataJSON.question_description[i])
                }

                for (var f=0; f<handleQuestion.length; f++){
                    root._PassageTestQuestions.clear()
                    root._PassageTestQuestions.append(handleQuestion[f])
                    passgeQuestion += getTotalPassgeQuestion()
                }

                model_LoadPassages.setProperty(id-1, "question_number", passgeQuestion)
                model_LoadPassages_backup.setProperty(id-1, "question_number", passgeQuestion)

            })}
    }

    //-- Get number of questions in questions of type 1 --//
    function getTotalQuestion_1(data){
        var questionCount = 0
        questionCount = data[0]['questions'].length
        return questionCount
    }

    //-- Get number of questions in questions of type 2 --//
    function getTotalQuestion_2(data){

        var questionCount = 0
        var questionSplit = []
        var questionText = ""

        questionText = ConvertRTFtoPlain.rtfToPlain(data[0]['questions'][0]['text'])

        questionSplit = questionText.split(" ")

        questionCount = 0
        for(var i =  0 ; i < questionSplit.length ; i++) if(questionSplit[i] === "_BLANK") questionCount++;
        return questionCount
    }

    //-- Get number of questions in questions of type 3 --//
    function getTotalQuestion_3(data){
        var questionCount = 0
        var questionText = ""
        var trArray = []
        questionText = ConvertRTFtoPlain.removeBackSlashT(data[0]['questions'][0]['text'])

        var tableIndx = questionText.indexOf('<table')
        if(tableIndx !== -1){

            var indx = questionText.indexOf('<tr')
            while(indx !== -1){
                trArray.push({'row': questionText.substring(indx , questionText.indexOf('</tr>') + 5)})
                questionText = questionText.replace(questionText.substring(indx , questionText.indexOf('</tr>') + 5) , "")
                indx = questionText.indexOf('<tr');
            }
            questionCount = trArray.length - 1
        }
        return questionCount
    }

    function getTotalQuestions(id){
        var counter = 0
        var num = 0
        var mObj = []
        for (var j=0; j<root._FullTestQuestions_1.count; j++){
            mObj = []
            mObj.push(JSON.parse(JSON.stringify(root._FullTestQuestions_1.get(j))))

            if(mObj[0]['type'].name === "Multiple choice" || mObj[0]['type'].name === "main idea"
                    || mObj[0]['type'].name === "matching heading" || mObj[0]['type'].name === "Yes No NotGiven"
                    || mObj[0]['type'].name === "classifying information" || mObj[0]['type'].name === "matching information with paragraphs"
                    || mObj[0]['type'].name === "matching sentence ending" || mObj[0]['type'].name === "matching statements & people & ..."
                    || mObj[0]['type'].name === "True False Not Given" || mObj[0]['type'].name === "short answer"
                    || mObj[0]['type'].name === "sentence completion"){
                num = getTotalQuestion_1(mObj)
                counter += num
            }else if(mObj[0]['type'].name === "completing summary paragraph"){
                num = getTotalQuestion_2(mObj)
                counter += num
            }else if(mObj[0]['type'].name === "map and chart"){
                num = getTotalQuestion_3(mObj)
                counter += num
            }else if (mObj[0]['type'].name === "multiple choice list"){
                num = getTotalQuestion_1(mObj)
                counter += num
            }
        }
        var section1_Count = counter


        var counter1 = 0
        var num1 = 0
        for (var j=0; j<root._FullTestQuestions_2.count; j++){
            mObj = []
            mObj.push(JSON.parse(JSON.stringify(root._FullTestQuestions_2.get(j))))

            if(mObj[0]['type'].name === "Multiple choice" || mObj[0]['type'].name === "main idea"
                    || mObj[0]['type'].name === "matching heading" || mObj[0]['type'].name === "Yes No NotGiven"
                    || mObj[0]['type'].name === "classifying information" || mObj[0]['type'].name === "matching information with paragraphs"
                    || mObj[0]['type'].name === "matching sentence ending" || mObj[0]['type'].name === "matching statements & people & ..."
                    || mObj[0]['type'].name === "True False Not Given" || mObj[0]['type'].name === "short answer"
                    || mObj[0]['type'].name === "sentence completion"){
                num1 = getTotalQuestion_1(mObj)
                counter1 += num1
            }else if(mObj[0]['type'].name === "completing summary paragraph"){
                num1 = getTotalQuestion_2(mObj)
                counter1 += num1
            }else if(mObj[0]['type'].name === "map and chart"){
                num1 = getTotalQuestion_3(mObj)
                counter1 += num1
            }else if (mObj[0]['type'].name === "multiple choice list"){
                num1 = getTotalQuestion_1(mObj)
                counter1 += num1
            }

        }
        var section2_Count =  counter1


        var counter2 = 0
        var num2 = 0
        for (var j=0; j<root._FullTestQuestions_3.count; j++){
            mObj = []
            mObj.push(JSON.parse(JSON.stringify(root._FullTestQuestions_3.get(j))))

            if(mObj[0]['type'].name === "Multiple choice" || mObj[0]['type'].name === "main idea"
                    || mObj[0]['type'].name === "matching heading" || mObj[0]['type'].name === "Yes No NotGiven"
                    || mObj[0]['type'].name === "classifying information" || mObj[0]['type'].name === "matching information with paragraphs"
                    || mObj[0]['type'].name === "matching sentence ending" || mObj[0]['type'].name === "matching statements & people & ..."
                    || mObj[0]['type'].name === "True False Not Given" || mObj[0]['type'].name === "short answer"
                    || mObj[0]['type'].name === "sentence completion"){
                num2 = getTotalQuestion_1(mObj)
                counter2 += num2
            }else if(mObj[0]['type'].name === "completing summary paragraph"){
                num2 = getTotalQuestion_2(mObj)
                counter2 += num2
            }else if(mObj[0]['type'].name === "map and chart"){
                num2 = getTotalQuestion_3(mObj)
                counter2 += num2
            }else if (mObj[0]['type'].name === "multiple choice list"){
                num2 = getTotalQuestion_1(mObj)
                counter2 += num2
            }
        }
        var section3_Count = counter2

        model_LoadTexts.setProperty(id-1, "question_number", section1_Count+section2_Count+section3_Count)
        model_LoadTexts_backup.setProperty(id-1, "question_number", section1_Count+section2_Count+section3_Count)

    }

    function getTotalPassgeQuestion(){
        var mainObj = []
        var questionCount = 0
        mainObj.push(JSON.parse(JSON.stringify(root._PassageTestQuestions.get(0))))
        if(mainObj[0]['type'].name === "Multiple choice" || mainObj[0]['type'].name === "main idea"
                || mainObj[0]['type'].name === "matching heading" || mainObj[0]['type'].name === "Yes No NotGiven"
                || mainObj[0]['type'].name === "classifying information" || mainObj[0]['type'].name === "matching information with paragraphs"
                || mainObj[0]['type'].name === "matching sentence ending" || mainObj[0]['type'].name === "matching statements & people & ..."
                || mainObj[0]['type'].name === "True False Not Given" || mainObj[0]['type'].name === "short answer"
                || mainObj[0]['type'].name === "sentence completion"){
            questionCount = getTotalQuestion_1(mainObj)
        }else if(mainObj[0]['type'].name === "completing summary paragraph"){
            questionCount = getTotalQuestion_2(mainObj)
        }else if(mainObj[0]['type'].name === "map and chart"){
            questionCount = getTotalQuestion_3(mainObj)
        }else if (mainObj[0]['type'].name === "multiple choice list"){
            questionCount = getTotalQuestion_1(mainObj)
        }
        return questionCount
    }
}
