import QtQuick 2.12
import QtQuick.Controls 2.2
import QtQuick.Window 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

import "./../../Fonts/Icon.js" as Icons
import "./../Utils/Enum.js" as Enum
import "./../Utils/Utils.js" as Util
import "./../REST/apiService.js" as Service

import "./Dashboard"
import "./Learn"
import "./Practice"
import "./Activity"
import "./Test"
import "./Settings"
import "./Help"
import "./AboutUs"
import "./Test/CambridgeBooksTest"
import "./ListModels"
import "./Account"
import "./../Modules"
import "./../Utils/ReadingFooter"
import "./Test/AnswerPage"
import "./Test/PassageTestPage"
import "./Test/SubmitPage"

Page{
    id: mainPage

    property ListModel testBooks: SelectTestModel{}

    // -- Question number of each section for showing in submitpage (passagetext and fulltext) -- //
    property var qN1
    property var qN2
    property var qN3

    // -- clarify this is a passagetext or fulltext -- //
    property bool passage: true

    // -- Start and end number of checkbox questions in each section -- //
    property var start_1: 0
    property var end_1: 0
    property var start_2: 0
    property var end_2: 0
    property var start_3: 0
    property var end_3: 0
    // -- Question number of each section (For clarifying the Checkbox qusetions) -- //
    property var questionCount_1: 0
    property var questionCount_2: 0
    property var questionCount_3: 0

    // -- Question number of passagetext (For clarifying the Checkbox qusetions) -- //
    property var questionCount: 0
    property var questionsCheckCount: 0

    // -- Get remaining time after submit -- //
    property var remainhour: 0
    property var remainsecond: 0

    signal searchClick
    onSearchClick: {
        console.log("Search Clicked !!!!!")
    }

    property int selectStart
    property int selectEnd
    property int curPos

    //-- right panel buttons states --//
    property string _BTN_DOSHBOARD:     "DOSHBOARD"
    property string _BTN_LEARN:         "LEARN"
    property string _BTN_PRACTICE:      "PRACTICE"
    property string _BTN_ACTIVITY:      "ACTIVITY"
    property string _BTN_SETTING:       "SETTING"
    property string _BTN_HELP:          "HELP"
    property string _BTN_ABOUTUS:       "ABOUTUS"
    property string _BTN_DICTIONARY:    "DICTIONARY"

    ListModel{id: model_answer}
    ListModel{id: model_ans}

    anchors.fill: parent

    state: _BTN_DOSHBOARD

    //-- state of right panel --//
    states: [
        //-- DOSHBOARD --//
        State {
            name: "DOSHBOARD"
            PropertyChanges { //-- btnDashboard iconColor --//
                target: btnDashboard
                iconColor : "#00fff0"
            }
            PropertyChanges { //-- btnLearn iconColor --//
                target: btnLearn
                iconColor : "#ffffff"
            }
            PropertyChanges { //-- btnPractice iconColor --//
                target: btnPractice
                iconColor : "#ffffff"
            }
            PropertyChanges { //-- btnActivity iconColor --//
                target: btnActivity
                iconColor : "#ffffff"
            }
            PropertyChanges { //-- btnSettings iconColor --//
                target: btnSettings
                iconColor : "#ffffff"
            }
            PropertyChanges { //-- btnHelp iconColor --//
                target: btnHelp
                iconColor : "#ffffff"
            }
            PropertyChanges { //-- btnAboutUs iconColor --//
                target: btnAboutUs
                iconColor : "#ffffff"
            }
            PropertyChanges { //-- btnDictionary iconColor --//
                target: btnDictionary
                iconColor : "#ffffff"
            }
        },
        //-- LEARN --//
        State {
            name: "LEARN"
            PropertyChanges { //-- btnDashboard iconColor --//
                target: btnDashboard
                iconColor : "#ffffff"
            }
            PropertyChanges { //-- btnLearn iconColor --///
                target: btnLearn
                iconColor : "#00fff0"
            }
            PropertyChanges { //-- btnPractice iconColor --//
                target: btnPractice
                iconColor : "#ffffff"
            }
            PropertyChanges { //-- btnActivity iconColor --//
                target: btnActivity
                iconColor : "#ffffff"
            }
            PropertyChanges { //-- btnSettings iconColor --//
                target: btnSettings
                iconColor : "#ffffff"
            }
            PropertyChanges { //-- btnHelp iconColor --//
                target: btnHelp
                iconColor : "#ffffff"
            }
            PropertyChanges { //-- btnAboutUs iconColor --//
                target: btnAboutUs
                iconColor : "#ffffff"
            }
            PropertyChanges { //-- btnDictionary iconColor --//
                target: btnDictionary
                iconColor : "#ffffff"
            }

        },
        //-- PRACTICE --//
        State {
            name: "PRACTICE"
            PropertyChanges { //-- btnDashboard iconColor --//
                target: btnDashboard
                iconColor : "#ffffff"
            }
            PropertyChanges { //-- btnLearn iconColor --//
                target: btnLearn
                iconColor : "#ffffff"
            }
            PropertyChanges { //-- btnPractice iconColor --//
                target: btnPractice
                iconColor : "#00fff0"
            }
            PropertyChanges { //-- btnActivity iconColor --//
                target: btnActivity
                iconColor : "#ffffff"
            }
            PropertyChanges { //-- btnSettings iconColor --//
                target: btnSettings
                iconColor : "#ffffff"
            }
            PropertyChanges { //-- btnHelp iconColor --//
                target: btnHelp
                iconColor : "#ffffff"
            }
            PropertyChanges { //-- btnAboutUs iconColor --//
                target: btnAboutUs
                iconColor : "#ffffff"
            }
            PropertyChanges { //-- btnDictionary iconColor --//
                target: btnDictionary
                iconColor : "#ffffff"
            }

        },
        //-- ACTIVITY --//
        State {
            name: "ACTIVITY"
            PropertyChanges { //-- btnDashboard iconColor --//
                target: btnDashboard
                iconColor : "#ffffff"
            }
            PropertyChanges { //-- btnLearn iconColor --//
                target: btnLearn
                iconColor : "#ffffff"
            }
            PropertyChanges { //-- btnPractice iconColor --//
                target: btnPractice
                iconColor : "#ffffff"
            }
            PropertyChanges { //-- btnActivity iconColor --//
                target: btnActivity
                iconColor : "#00fff0"
            }
            PropertyChanges { //-- btnSettings iconColor --//
                target: btnSettings
                iconColor : "#ffffff"
            }
            PropertyChanges { //-- btnHelp iconColor --//
                target: btnHelp
                iconColor : "#ffffff"
            }
            PropertyChanges { //-- btnAboutUs iconColor --//
                target: btnAboutUs
                iconColor : "#ffffff"
            }
            PropertyChanges { //-- btnDictionary iconColor --//
                target: btnDictionary
                iconColor : "#ffffff"
            }

        },
        //-- DICTIONARY --//
        State {
            name: "DICTIONARY"
            PropertyChanges { //-- btnDashboard iconColor --//
                target: btnDashboard
                iconColor : "#ffffff"
            }
            PropertyChanges { //-- btnLearn iconColor --//
                target: btnLearn
                iconColor : "#ffffff"
            }
            PropertyChanges { //-- btnPractice iconColor --//
                target: btnPractice
                iconColor : "#ffffff"
            }
            PropertyChanges { //-- btnActivity iconColor --//
                target: btnActivity
                iconColor : "#ffffff"
            }
            PropertyChanges { //-- btnSettings iconColor --//
                target: btnSettings
                iconColor : "#ffffff"
            }
            PropertyChanges { //-- btnHelp iconColor --//
                target: btnHelp
                iconColor : "#ffffff"
            }
            PropertyChanges { //-- btnAboutUs iconColor --//
                target: btnAboutUs
                iconColor : "#ffffff"
            }
            PropertyChanges { //-- btnDictionary iconColor --//
                target: btnDictionary
                iconColor : "#00fff0"
            }

        },
        //-- SETTING --//
        State {
            name: "SETTING"
            PropertyChanges { //-- btnDashboard iconColor --//
                target: btnDashboard
                iconColor : "#ffffff"
            }
            PropertyChanges { //-- btnLearn iconColor --//
                target: btnLearn
                iconColor : "#ffffff"
            }
            PropertyChanges { //-- btnPractice iconColor --//
                target: btnPractice
                iconColor : "#ffffff"
            }
            PropertyChanges { //-- btnActivity iconColor --//
                target: btnActivity
                iconColor : "#ffffff"
            }
            PropertyChanges { //-- btnSettings iconColor --//
                target: btnSettings
                iconColor : "#00fff0"
            }
            PropertyChanges { //-- btnHelp iconColor --//
                target: btnHelp
                iconColor : "#ffffff"
            }
            PropertyChanges { //-- btnAboutUs iconColor --//
                target: btnAboutUs
                iconColor : "#ffffff"
            }
            PropertyChanges { //-- btnDictionary iconColor --//
                target: btnDictionary
                iconColor : "#ffffff"
            }

        },
        //-- Help --//
        State {
            name: "HELP"
            PropertyChanges { //-- btnDashboard iconColor --//
                target: btnDashboard
                iconColor : "#ffffff"
            }
            PropertyChanges { //-- btnLearn iconColor --//
                target: btnLearn
                iconColor : "#ffffff"
            }
            PropertyChanges { //-- btnPractice iconColor --//
                target: btnPractice
                iconColor : "#ffffff"
            }
            PropertyChanges { //-- btnActivity iconColor --//
                target: btnActivity
                iconColor : "#ffffff"
            }
            PropertyChanges { //-- btnSettings iconColor --//
                target: btnSettings
                iconColor : "#ffffff"
            }
            PropertyChanges { //-- btnHelp iconColor --//
                target: btnHelp
                iconColor : "#00fff0"
            }
            PropertyChanges { //-- btnAboutUs iconColor --//
                target: btnAboutUs
                iconColor : "#ffffff"
            }
            PropertyChanges { //-- btnDictionary iconColor --//
                target: btnDictionary
                iconColor : "#ffffff"
            }

        },
        //-- ABOUTUS --//
        State {
            name: "ABOUTUS"
            PropertyChanges { //-- btnDashboard iconColor --//
                target: btnDashboard
                iconColor : "#ffffff"
            }
            PropertyChanges { //-- btnLearn iconColor --//
                target: btnLearn
                iconColor : "#ffffff"
            }
            PropertyChanges { //-- btnPractice iconColor --//
                target: btnPractice
                iconColor : "#ffffff"
            }
            PropertyChanges { //-- btnActivity iconColor --//
                target: btnActivity
                iconColor : "#ffffff"
            }
            PropertyChanges { //-- btnSettings iconColor --//
                target: btnSettings
                iconColor : "#ffffff"
            }
            PropertyChanges { //-- btnHelp iconColor --//
                target: btnHelp
                iconColor : "#ffffff"
            }
            PropertyChanges { //-- btnAboutUs iconColor --//
                target: btnAboutUs
                iconColor : "#00fff0"
            }
            PropertyChanges { //-- btnDictionary iconColor --//
                target: btnDictionary
                iconColor : "#ffffff"
            }

        }


    ]

    //-- HEADER --//
    header: Rectangle{
        id: mainHeader

        ParallelAnimation{
            id: hideSearch

            //-- Half Menu--//
            NumberAnimation { target: rightMenu; property: "width"; to: btnDashboard.iconWidth; duration: 250 }

        }

        ParallelAnimation{
            id: showSearch
            //-- Full Menu --//
            NumberAnimation { target: rightMenu; property: "width"; to: 170 * ratio; duration: 250 }
        }


        width: parent.width
        height: 40 //* ratio

        color: "#e9eaea"

        //-- Vertical Line After Profile Name --//
        Rectangle{
            width: 2 * ratio
            height: parent.height * 0.7

            color: "#dddddd"

            anchors.verticalCenter:  parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: rightMenu.width - width
        }

        //-- Header Items --//
        RowLayout{
            anchors.fill: parent
            layoutDirection: Qt.RightToLeft
            spacing: 0

            //-- Account Icon --//
            Label{
                id: header_AccountIcon
                Layout.preferredWidth: height / 4 * 3  // 75%
                Layout.fillHeight: true

                Layout.rightMargin: 12 * ratio

                text: Icons.account_circle
                font.family: webfont.name
                font.pixelSize: 72//Qt.application.font.pixelSize
                minimumPixelSize: 10
                fontSizeMode: Text.Fit

                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter

                color: "#444444"

                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        if(isLogined){
                            if(sView.currentItem.objectName !== "Profile"){
                                //                            mainPage.state = _BTN_ACTIVITY
                                sView.push(Enum._PAGE_Profile)
                                profilePage.visitProfile()

                            }
                        }
                    }
                }

            }

            //-- account / login/ register --//
            Item{
                Layout.preferredWidth: rightMenu.width - header_AccountIcon.width - (20 * ratio)
                Layout.preferredHeight: parent.height / 2 // 50%

                RowLayout{
                    anchors.fill: parent

                    Item{Layout.fillWidth: true} //-- filler --//

                    //-- Account Profile Name --//
                    Label{
                        visible: isLogined
                        id: header_AccountName

                        text: _userName //"میلاد بابایی مزرعه شاهی"
                        font.family: iranSans.name
                        font.pixelSize: Qt.application.font.pixelSize //Qt.application.font.pixelSize
                        renderType: Text.NativeRendering

                        verticalAlignment: Qt.AlignVCenter

                        color: "#444444"
                        clip: true
                        elide: Text.ElideRight
                    }

                    //-- Account register --//
                    Label{
                        id: header_AccountRegister

                        visible: !isLogined
                        text: "ثبت نام"
                        font.family: iranSans.name
                        font.pixelSize: Qt.application.font.pixelSize //Qt.application.font.pixelSize
                        renderType: Text.NativeRendering

                        verticalAlignment: Qt.AlignVCenter

                        color: "#444444"
                        clip: true
                        elide: Text.ElideRight

                        MouseArea{
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked:{

                                show_registeration()
                            }
                        }
                    }

                    //-- / --//
                    Label{
                        visible: !isLogined
                        text: "/"
                        font.family: iranSans.name
                        font.pixelSize: Qt.application.font.pixelSize //Qt.application.font.pixelSize
                        verticalAlignment: Qt.AlignVCenter
                        color: "#444444"
                    }

                    //-- Account login --//
                    Label{
                        id: header_AccountLogin

                        visible: !isLogined
                        text: "ورود"
                        font.family: iranSans.name
                        font.pixelSize: Qt.application.font.pixelSize //Qt.application.font.pixelSize
                        renderType: Text.NativeRendering

                        verticalAlignment: Qt.AlignVCenter

                        color: "#444444"
                        clip: true
                        elide: Text.ElideRight

                        MouseArea{
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked:{
                                show_login()
                            }
                        }
                    }

                }

            }

            //-- Label of Search (invisible) --//
            Label{
                id:lbl_search

                visible: false

                Layout.preferredWidth: implicitWidth
                Layout.preferredHeight: parent.height / 2 // 50%

                Layout.rightMargin: 30 * ratio

                text: "جستجو"
                font.family: iranSans.name
                font.pixelSize: Qt.application.font.pixelSize //Qt.application.font.pixelSize

                horizontalAlignment: Qt.AlignRight
                verticalAlignment: Qt.AlignVCenter

                color: "#444444"
            }

            //-- InputBox For Search (invisible) --//
            /*Rectangle{
                visible: false
                id: searchRect
                Layout.preferredWidth: 220 * ratio
                Layout.preferredHeight: parent.height * 0.8 // 80%

                Layout.rightMargin: 10 * ratio

                border.width: 1 * ratio
                border.color: "#444444"

                clip: true

                //-- Magnify Icon (Search Icon) --//
                Label{
                    width: parent.height
                    height: parent.height

                    anchors.right: parent.right

                    text: Icons.magnify
                    font.family: webfont.name
                    font.pixelSize: 72//Qt.application.font.pixelSize
                    minimumPixelSize: 10
                    fontSizeMode: Text.Fit

                    color: "#ffffff"

                    horizontalAlignment: Qt.AlignHCenter
                    verticalAlignment: Qt.AlignVCenter

                    background: Rectangle{
                        color: "#444444"
                    }

                    ItemDelegate{
                        id: searchAction

                        anchors.fill: parent
                        onClicked: {
                            searchClick()
                        }
                    }
                }

                //-- TextField of Search --//
                TextInput{
                    id:txf_Search

                    clip: true
                    width: parent.width - parent.height  // Width of Rect - Width of Magnify
                    height: parent.height

                    verticalAlignment: Qt.AlignVCenter

                    rightPadding: 10 * ratio
                    leftPadding: 5 * ratio

                    font.family: iranSans.name
                    font.pixelSize: Qt.application.font.pixelSize

                    selectByMouse: true


                    //-- placeholder --//
                    Label{

                        visible: (txf_Search.length >= 1) ? false : true

                        text: "جستجو..."

                        anchors.right: parent.right
                        anchors.rightMargin: 10 * ratio
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

                            selectStart = txf_Search.selectionStart
                            selectEnd = txf_Search.selectionEnd
                            curPos = txf_Search.positionAt(mouse.x)
                            copyPaste_Menu.x = mouse.x
                            copyPaste_Menu.y = mouse.y
                            txf_Search.cursorPosition = curPos
                            copyPaste_Menu.open()

                            txf_Search.select(selectStart,selectEnd)
                        }
                        onPressAndHold: {
                            if (mouse.source === Qt.MouseEventNotSynthesized) {
                                selectStart = txf_Search.selectionStart
                                selectEnd = txf_Search.selectionEnd
                                curPos = txf_Search.positionAt(mouse.x)
                                copyPaste_Menu.x = mouse.x
                                copyPaste_Menu.y = mouse.y
                                txf_Search.cursorPosition = curPos
                                copyPaste_Menu.open()

                                txf_Search.select(selectStart,selectEnd)
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
                                    txf_Search.select(selectStart,selectEnd)
                                    txf_Search.cut()
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
                                    txf_Search.select(selectStart,selectEnd)
                                    txf_Search.copy()
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
                                    txf_Search.paste()
                                }

                                TextInput {
                                    id: txtTemp
                                    visible: false
                                }
                            }
                            onOpened: {

                                txf_Search.select(selectStart,selectEnd)
                                txf_Search.cursorPosition = curPos

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
                        searchClick()
                    }

                }

            }*/

            //- navbar --//
            Item{
                Layout.fillHeight: true
                Layout.fillWidth: true

                ListModel {
                    id: model_navbar
                    ListElement {
                        title: "خانه"
                        link: ""
                    }
                }

                ListView{
                    anchors.fill: parent
                    anchors.rightMargin: 5

                    model: model_navbar
                    orientation: ListView.Horizontal
                    layoutDirection: Qt.RightToLeft

                    delegate: ItemDelegate{
                        width: lbl_model_title.implicitWidth * 1.2 + lbl_model_slash.implicitWidth
                        height: parent.height

                        Label{
                            id: lbl_model_title
                            text: model.title
                            anchors.centerIn: parent

                            font.family: iranSans.name
                            font.pixelSize: Qt.application.font.pixelSize //Qt.application.font.pixelSize
                            renderType: Text.NativeRendering
                            color: Util.color_RightMenu
                        }

                        Label{
                            id: lbl_model_slash
                            text: " / "
                            anchors.right: lbl_model_title.left
                            anchors.verticalCenter: lbl_model_title.verticalCenter

                            font.family: iranSans.name
                            font.pixelSize: Qt.application.font.pixelSize //Qt.application.font.pixelSize
                            renderType: Text.NativeRendering
                            color: Util.color_RightMenu
                        }
                    }
                }
            }

            //          Item { Layout.fillWidth: true } //-- filler --//

            //-- Back Icon (Back Button) (invisible) --//
            Label{
                visible: false
                id: header_BackIcon
                Layout.preferredWidth: height / 4 * 3  // 75%
                Layout.fillHeight: true

                enabled: (sView.depth > 1) ? true : false

                Layout.leftMargin: 12 * ratio

                text: Icons.arrow_left_bold_circle_outline
                font.family: webfont.name
                font.pixelSize: 72//Qt.application.font.pixelSize
                minimumPixelSize: 10
                fontSizeMode: Text.Fit

                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter

                color: (enabled) ? "#444444" : "gray"

                MouseArea{
                    id: mArea_Back
                    anchors.fill: parent
                    hoverEnabled: true

                    onReleased: {
                        if(sView.depth > 1){
                            sView.pop()
                        }

                    }
                }

            }

            //-- Label of zabanup --//
            Label{

                Layout.alignment: Qt.AlignBottom
                Layout.bottomMargin: 1

                color: Util.color_StatusBar
                renderType: Text.NativeRendering
                text: "just speed up, never give up"
                font.family: iranSans.name
                font.pixelSize: Qt.application.font.pixelSize * 0.8
            }

            Image {
                Layout.fillHeight: true
                Layout.margins: 4
                sourceSize.height: height
                source: "qrc:/Content/Images/logo.png"
                fillMode: Image.PreserveAspectFit
            }

        }

    }

    //-- Body --//
    Rectangle{
        id: mainBody
        width: parent.width - rightMenu.width
        height: parent.height
        //        color: "#ffffff"

        ColumnLayout{
            width: parent.width
            height: parent.height
            spacing: 0

            //-- Pages --//
            StackView {
                id: sView

                Layout.fillWidth: true
                Layout.fillHeight: true

                initialItem: Enum._PAGE_Dashborad

                onCurrentItemChanged: {

                    print('--- ', sView.currentItem.objectName)

                    if(sView.currentItem.objectName === "ReadingTestPage"){
                        hideSearch.restart()

                        log("-----in exam -----")
                        root.global_countDownTimer.restart()
                        return
                    }
                    else{
                        showSearch.restart()
                        readingTest.resetTimer()
                    }



                    //                    console.log("Change Stack Item to : " + sView.currentItem.objectName )
                }


                //-- Dashboard  index "0" , Enum "_PAGE_Dashborad" --//
                Dashboard{
                    id:dashboardPage
                    visible: false

                }

                //-- Learn  index "1" , Enum "_PAGE_Learn" --//
                LearnPage{
                    id: learnPage
                    visible: false

                }

                //-- Practice  index "2" , Enum "_PAGE_Practice" --//
                PracticePage{
                    id: practicePage
                    visible: false

                }

                //-- SelectTest  index "3" , Enum "_PAGE_SelectTest" --//
                SelectTestPage{
                    id: selectTestPage
                    visible: false

                }

                //-- CambridgeBookTest  index "4" , Enum "_PAGE_CambridgeBookTest" --//
                CambridgeBookTest{
                    id:cambridgeBook
                    visible: false

                }

                //-- ReadingTest  index "5" , Enum "_PAGE_ReadingTest" --//
                ReadingTestPage{
                    id: readingTest
                    width: parent.width
                    height: parent.height
                    visible: false
                }

                //-- SettingsPage index "6" , Enum "_Page_Settings" --//
                SettingsPage{
                    id:settingsPage
                    visible: false
                }

                //-- HelpPage index "7" , Enum "_Page_Help" --//
                HelpPage{
                    id:helpPage
                    visible: false
                }

                //-- AboutUsPage index "8" , Enum "_Page_AboutUs" --//
                AboutUsPage{
                    id:aboutUsPage
                    visible: false
                }

                //-- AboutUsPage index "9" , Enum "_Page_Activity" --//
                ActivityPage{
                    id: activityPage
                    visible: false

                }

                //-- Profile index "10" , Enum "_Page_Profile" --//
                Profile{
                    id: profilePage
                    visible: false

                }

                //-- AnswerPage --//
                AnswerPage{
                    id: answerPage
                    width: parent.width
                    height: parent.height
                    visible: false
                }

                //-- PassageTestPage index "12" , Enum "_PAGE_PassageTest" --//
                PassageTestPage{
                    id: passageTestPage
                    visible: false

                }

                Item {
                    visible: false
                    Label{
                        anchors.centerIn: parent
                        text: "nothing"
                    }
                }

            }

            //-- FOOTER --//
            Rectangle{
                id: mainFooter

                visible: {
                    if(sView.currentItem.objectName === readingTest.objectName){
                        return false
                    }

                    else if(sView.currentItem.objectName === passageTestPage.objectName) {
                        return false
                    }

                    else {
                        return true
                    }

                }

                Layout.fillWidth: true
                Layout.preferredHeight: 40 * ratio
                Layout.bottomMargin: -2

                color: Util.color_StatusBar

                //-- Footer Items --//
                RowLayout{

                    anchors.fill: parent
                    spacing: 0
                    anchors.leftMargin: 12 * ratio
                    layoutDirection: Qt.RightToLeft

                    //-- Filler --//
                    Item {
                        Layout.fillWidth: true
                    }


                    //-- exit text --//
                    Label{
                        id:footerLogoText

                        Layout.leftMargin: 5 * ratio

                        text: "خروج از نرم افزار"
                        font.family: iranSans.name
                        font.pixelSize: Qt.application.font.pixelSize * 0.9
                        renderType: Text.NativeRendering

                        verticalAlignment: Qt.AlignBottom

                        color: "#ffffff"

                        MouseArea{
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                exitProgram.open()
                            }
                        }
                    }

                    //-- Icon  --//
                    Label{
                        id: lbl_exit

                        text: Icons.logout_variant
                        font.family: webfont.name
                        font.pixelSize: Qt.application.font.pixelSize * 1.5
                        color: Util.color_white

                        verticalAlignment: Qt.AlignVCenter

                        MouseArea{
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                exitProgram.open()
                            }
                        }

                    }

                }

            }

        }

    }

    //-- Right Menu --//
    Rectangle{
        id: rightMenu


        anchors.right: parent.right

        width: 170 * ratio
        height: parent.height

        color: "#444444"

        //-- Right Menu Items --//
        ColumnLayout{
            anchors.fill: parent
            anchors.topMargin: 15 * ratio
            anchors.bottomMargin: mainFooter.height - btnAboutUs.height

            spacing: 0

            //-- Dashboard Button --//
            ButtonPanel{
                id: btnDashboard

                Layout.fillWidth: true
                Layout.preferredHeight: 45 * ratio

                icon: Icons.home_outline
                text: "پیشخوان"

                onBtnClicked: {
                    if(sView.currentItem.objectName !== "Dashboard"){
                        mainPage.state = _BTN_DOSHBOARD
                        sView.push(Enum._PAGE_Dashborad)
                        console.log("objectName : " , sView.currentItem.objectName)
                    }

                }

            }

            //-- Learn Button --//
            ButtonPanel{
                id: btnLearn

                Layout.fillWidth: true
                Layout.preferredHeight: 45 * ratio

                icon: Icons.school
                text: "آموزش"

                onBtnClicked: {
                    if(sView.currentItem.objectName !== "LearnPage"){
                        mainPage.state = _BTN_LEARN
                        sView.push(Enum._PAGE_Learn)
                    }
                }

            }

            //-- Practice Button --//
            ButtonPanel{
                id: btnPractice

                Layout.fillWidth: true
                Layout.preferredHeight: 45 * ratio

                icon: Icons.book_open_page_variant
                text: "تمرین"

                onBtnClicked: {

                    if(sView.currentItem.objectName !== "PracticePage"){
                        mainPage.state = _BTN_PRACTICE
                        //                        sView.push(Enum._PAGE_Practice)
                        sView.push(Enum._PAGE_ReadingTest)
                    }
                }

            }

            //-- Activity Button --//
            ButtonPanel{
                id: btnActivity

                Layout.fillWidth: true
                Layout.preferredHeight: 45 * ratio

                icon: Icons.pulse
                text: "فعالیت ها"

                onBtnClicked: {
                    if(sView.currentItem.objectName !== "ActivityPage"){
                        mainPage.state = _BTN_ACTIVITY
                        sView.push(Enum._PAGE_Activity)
                    }
                }

            }

            //-- Dictionary Button --//
            ButtonPanel{
                id: btnDictionary

                Layout.fillWidth: true
                Layout.preferredHeight: 45 * ratio

                icon: Icons.book_open_outline
                text: "لغت نامه"

                onBtnClicked: {
                    if(sView.currentItem.objectName !== "Dictionary"){
                        mainPage.state = _BTN_DICTIONARY
                        sView.push(Enum._PAGE_Dictionary)
                    }
                }

            }


            Item { Layout.fillHeight: true } //-- Filler --//

            //-- Settings Button --//
            ButtonPanel{
                id: btnSettings

                Layout.fillWidth: true
                Layout.preferredHeight: 45 * ratio

                icon: Icons.tune
                text: "تنظیمات"

                onBtnClicked: {
                    if(sView.currentItem.objectName !== "SettingsPage"){
                        mainPage.state = _BTN_SETTING
                        sView.push(Enum._PAGE_Settings)
                    }
                }

            }

            //-- Help SoftWare Button --//
            ButtonPanel{
                id: btnHelp

                Layout.fillWidth: true
                Layout.preferredHeight: 45 * ratio

                icon: Icons.help_circle_outline
                text: "راهنما"

                onBtnClicked: {
                    if(sView.currentItem.objectName !== "HelpPage"){
                        mainPage.state = _BTN_HELP
                        sView.push(Enum._PAGE_Help)
                    }
                }

            }

            //-- AboutUs Button --//
            ButtonPanel{
                id: btnAboutUs

                Layout.fillWidth: true
                Layout.preferredHeight: 45 * ratio

                icon: Icons.information_outline
                text: "درباره ما"

                onBtnClicked: {
                    if(sView.currentItem.objectName !== "AboutUsPage"){
                        mainPage.state = _BTN_ABOUTUS
                        sView.push(Enum._PAGE_AboutUs)
                    }
                }

            }

            //-- Logout --//
            ButtonPanel{
                id: btnLogout

                visible: isLogined

                Layout.fillWidth: true
                Layout.preferredHeight: 45 * ratio

                icon: Icons.logout
                text: "خروج"

                onBtnClicked: {
                    sView.push(Enum._PAGE_Dashborad)
                    logout()
                }

            }

            //-- social media icons --//
            Item{
                Layout.fillWidth: true
                Layout.preferredHeight: mainFooter.height
                Layout.rightMargin: 10 * ratio

                Rectangle{ width: parent.width - 4; height: 1; x: 7; color: Util.color_StatusBar}

                RowLayout{
                    anchors.fill: parent

                    Item{Layout.fillWidth: true} //-- filler --//

                    //-- Dashboard Icon --//
                    Label{
                        id:lbl_whatsapp

                        //                        anchors.verticalCenter: parent.verticalCenter

                        text: Icons.whatsapp

                        font.family: webfont.name
                        font.pixelSize: Qt.application.font.pixelSize * 1.3

                        color: "#ffffff"
                    }

                    //-- Dashboard Icon --//
                    Label{

                        //                        anchors.verticalCenter: parent.verticalCenter

                        text: Icons.instagram

                        font.family: webfont.name
                        font.pixelSize: Qt.application.font.pixelSize * 1.3

                        color: "#ffffff"
                    }

                }
            }


        }


    }

    //--Submitpage of fulltext--//
    Component{
        id: pagesubmitcomponent

        SubmitPage{
            questionNumberSec1: qN1
            questionNumberSec2: qN2
            questionNumberSec3: qN3
        }
    }

     //--Answerpage of fulltext--//
    Component{
        id: pageanswercomponent

        AnswerPage{
            questionNumberSec1: qN1
            questionNumberSec2: qN2
            questionNumberSec3: qN3
        }
    }

}
