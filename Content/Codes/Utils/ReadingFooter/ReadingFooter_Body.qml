import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

import "./../../../Fonts/Icon.js" as Icons
import "./../Enum.js" as Enum

import "./../../Modules"
import "./../../Pages/Test"


Rectangle{
    id:readingFooter

    property bool showList: false // footer in Open(True) or Close(false)
    property real downFooter_Height: 40 * ratio // Height of footer When is Open
    property real upFooter_Height: 150 * ratio // Height of footer When is Close

    //-- footer To Down --//
    signal footerToDown
    onFooterToDown: {
        f_height40.restart()
    }

    //-- get signal of stopTimer form Countdown_Timer for use in Home.qml --/
    signal stopTimer
    onStopTimer: {
        cTimer.stopTimer()
    }

    //-- get signal of startTimer form Countdown_Timer for use in Home.qml --/
    signal startTimer
    onStartTimer: {
        cTimer.startTimer()
    }

    //-- get signal of resetTimer form Countdown_Timer for use in Home.qml --/
    signal resetTimer
    onResetTimer: {
        cTimer.resetTimer()
    }

    ParallelAnimation{
        id: f_height300;
        PropertyAnimation { target: lbl_testsListIcon ; properties: "rotation"; to: 180; duration: 500 }
        PropertyAnimation { target: readingFooter ; properties: "height"; to: upFooter_Height; duration: 500 }
        PropertyAnimation { targets: [cTimer , btn_SendRF , btn_ReviewRF , btn_SolutionRF , separator1 , separator2] ; properties: "opacity" ; to: 0 ; duration: 300}
        PropertyAnimation { targets: [cTimer , btn_SendRF , btn_ReviewRF , btn_SolutionRF , separator1 , separator2] ; properties: "visible" ; to: false ; duration: 0}
    }

    ParallelAnimation{
        id: f_height40;
        PropertyAnimation { target: lbl_testsListIcon ; properties: "rotation"; to: 0; duration: 500 }
        PropertyAnimation { target: readingFooter ; properties: "height"; to: downFooter_Height; duration: 500 }
        PropertyAnimation { targets: [cTimer , btn_SendRF , btn_ReviewRF , btn_SolutionRF , separator1 , separator2] ; properties: "opacity" ; to: 1 ; duration: 300}
        PropertyAnimation { targets: [cTimer , btn_SendRF , btn_ReviewRF , btn_SolutionRF , separator1 , separator2] ; properties: "visible" ; to: true ; duration: 0}
    }

    width: parent.width - rightMenu.width
    height: 40 * ratio

    ColumnLayout{
        anchors.fill: parent
        spacing: 0
        anchors.topMargin: 0

        //-- Reading Footer (header) --//
        Rectangle{

            Layout.fillWidth: true
            Layout.preferredHeight: 40 * ratio

            color: "#5b75a7"

            //-- Countdown Timer --//
            Countdown_Timer{
                id: cTimer

                height: 40 * ratio

                anchors.horizontalCenter: parent.horizontalCenter

            }

            RowLayout{

                width: parent.width
                height: 40 * ratio
                anchors.top: parent.top
                spacing: 0
                layoutDirection: Qt.RightToLeft

                //-- Send Button --//
                ReadingFooter_Buttons{
                    id:btn_SendRF           // RF => Reading Footer
                    Layout.preferredWidth: sendWidth
                    Layout.preferredHeight: 40 * ratio
                    //Layout.rightMargin: 10 * ratio

                    lblText: "ارسال"

                    iconSource: "qrc:/Content/Images/Reading_Footer/footer_Send.png"

                    onClickRFB: {
                        console.log(lblText)
                        stopTimer()

                        sView.push(pagesubmitcomponent)
                    }

                    labelRightMargin: 20 * ratio

                }

                //-- Separator --//
                Rectangle{
                    id: separator1
                    Layout.preferredWidth: 1 * ratio
                    Layout.preferredHeight: (40 * ratio) * 0.6

                    Layout.alignment: Qt.AlignVCenter

                    color: "#ffffff"
                }

                //-- Review Button --//
                ReadingFooter_Buttons{
                    id: btn_ReviewRF             // RF => Reading Footer
                    Layout.preferredWidth: sendWidth
                    Layout.preferredHeight: 40 * ratio

                    lblText: "بازبینی"

                    iconSource: "qrc:/Content/Images/Reading_Footer/footer_Review.png"

                    onClickRFB: {
                        console.log(lblText)
                        reviewTest.open()
                    }

                }

                //-- Separator --//
                Rectangle{
                    id: separator2
                    Layout.preferredWidth: 1 * ratio
                    Layout.preferredHeight: (40 * ratio) * 0.6

                    Layout.alignment: Qt.AlignVCenter

                    color: "#ffffff"
                }

                //-- Solution Button --//
                ReadingFooter_Buttons{
                    id: btn_SolutionRF       // RF => Reading Footer
                    Layout.preferredWidth: sendWidth
                    Layout.preferredHeight: 40 * ratio

                    lblText: "پاسخ سوالات"

                    iconSource: "qrc:/Content/Images/Reading_Footer/footer_Light.png"

                    onClickRFB: {
                        console.log(lblText)
                        stopTimer()

                        sView.push(pageanswercomponent)

                    }

                }

                //-- Filler --//
                Item {
                    Layout.fillWidth: true
                }

                //-- List of Test Label and Icon --//
                Rectangle{
                    Layout.preferredHeight: 40 * ratio
                    Layout.preferredWidth: lbl_testsList.width + lbl_testsListIcon.width

                    color: "transparent"

                    //-- "List of Test" Label --//
                    Label{
                        id: lbl_testsList

                        width: implicitWidth + (20 * ratio * widthRatio)
                        height: parent.height

                        anchors.right: parent.right
                        verticalAlignment: Qt.AlignVCenter
                        horizontalAlignment: Qt.AlignHCenter

                        text: "لیست سوالات"
                        font.family: iranSansMedium.name
                        font.pixelSize: Qt.application.font.pixelSize * 1.3


                        color: "#ffffff"
                    }

                    //-- "List of Test" Icon --//
                    Label{
                        id: lbl_testsListIcon

                        width: height
                        height: parent.height

                        anchors.left: parent.left
                        verticalAlignment: Qt.AlignVCenter
                        horizontalAlignment: Qt.AlignHCenter

                        text: Icons.chevron_up
                        font.family: webfont.name
                        font.pixelSize: Qt.application.font.pixelSize * 2
                        font.bold: true

                        color: "#ffffff"
                    }

                    ItemDelegate{
                        anchors.fill: parent
                        onClicked: {
                            console.log(lbl_testsList.text)
                            showList = !showList

                            if(showList){
                                console.log("showList = " + showList)
                                f_height300.restart()
                            }
                            else{
                                f_height40.restart()
                            }
                        }
                    }

                }

            }

        }

        //-- List Number of Tests --//
        Rectangle{
            Layout.fillWidth: true
            Layout.fillHeight: true

            //            color: "#55ff0000"

            RowLayout{
                anchors.fill: parent
                spacing: 0

                //-- Section 1 Question's Number --//
                Rectangle{
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    color: "#5b75a7"

                    //-- right Separator --//
                    Rectangle{
                        width: 1
                        height: parent.height * 0.85

                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    //-- Label of Section 1 --//
                    Label{
                        id: lbl_Section1
                        text: "Section 1"
                        font.pixelSize: Qt.application.font.pixelSize
                        font.family: segoeUI.name
                        color: "#ffffff"

                        anchors.left: parent.left
                        anchors.leftMargin: 10 * ratio
                    }

                    //-- list of Questions in Section 1 --//
                    Flickable{
                        id: flick_S1
                        width: parent.width
                        height: parent.height - lbl_Section1.implicitHeight
                        contentHeight: s1Flow.height
                        anchors.bottom: parent.bottom
                        leftMargin: 8 * ratio
                        rightMargin: 8 * ratio
                        clip: true

                        //                            anchors.margins: 20 * ratio

                        ScrollBar.vertical: ScrollBar {
                            width: 8 * ratio
                            policy: ScrollBar.AsNeeded
                            parent: flick_S1.parent
                            anchors.top: flick_S1.top
                            anchors.right: flick_S1.right
                            anchors.bottom: flick_S1.bottom
                        }

                        Flow {
                            id: s1Flow
                            width: parent.width
                            height: implicitHeight
                            spacing: 6 * ratio
                            rightPadding: 20 * ratio

                            Repeater {
                                //                                model: section1_Count
                                model: questionCount_1

                                Rectangle{
                                    width: 30
                                    height: width

                                    visible: true

                                    radius: width / 2
                                    color: (model_ans.get(index)["answer"] === "") ? "#5b75a7" : "#006400"

                                    //                                    border.color: model.answer !== "" ? "#55FF0000" : "#ffffff"
                                    border.color: "#ffffff"
                                    border.width: 2

                                    Label{
                                        text: (index+1 === start_1) ? (start_1+"/"+end_1) : (index + 1) //index + 1
                                        anchors.centerIn: parent
                                        font.pixelSize: (index+1 === start_1) ? 10 : 15
                                        color: "#ffffff"
                                    }

                                    ItemDelegate{
                                        anchors.fill: parent
                                        onClicked: {
                                            testSection1.checkSection1()
                                            if (model_section1.get(index+model_section1.get(index)["factor"])["type"] === "completing summary paragraph" ){
                                                lst_Answer_sec1.positionViewAtIndex(model_section1.get(index+model_section1.get(index)["factor"])["firstindex"]+1 , ListView.Center)
                                            }else if (model_section1.get(index+model_section1.get(index)["factor"])["type"] === "map and chart"){
                                                lst_Answer_sec1.positionViewAtIndex(model_section1.get(index+model_section1.get(index)["factor"])["firstindex"]+1 , ListView.Center)
                                            }else{
                                                lst_Answer_sec1.positionViewAtIndex(index+model_section1.get(index)["factor"] , ListView.Center)
                                            }
                                            //                                            console.log((index) + "  " + model_questions.get(index).name)

                                        }
                                    }

                                }

                            }
                        }
                    }

                }

                //-- Section 2 Question's Number --//
                Rectangle{
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    color: "#5b75a7"

                    //-- right Separrator --//
                    Rectangle{
                        width: 1
                        height: parent.height * 0.85

                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    //-- Label of Section 1 --//
                    Label{
                        id: lbl_Section2
                        text: "Section 2"
                        font.pixelSize: Qt.application.font.pixelSize
                        font.family: segoeUI.name
                        color: "#ffffff"

                        anchors.left: parent.left
                        anchors.leftMargin: 10 * ratio
                    }

                    //-- list of Questions in Section 1 --//
                    Flickable{
                        id: flick_S2
                        width: parent.width
                        height: parent.height - lbl_Section1.implicitHeight
                        contentHeight: s2Flow.height
                        anchors.bottom: parent.bottom
                        leftMargin: 8 * ratio
                        rightMargin: 8 * ratio
                        clip: true

                        //                            anchors.margins: 20 * ratio

                        ScrollBar.vertical: ScrollBar {
                            width: 8 * ratio
                            policy: ScrollBar.AsNeeded
                            parent: flick_S2.parent
                            anchors.top: flick_S2.top
                            anchors.right: flick_S2.right
                            anchors.bottom: flick_S2.bottom
                        }

                        Flow {
                            id: s2Flow
                            width: parent.width
                            height: implicitHeight
                            spacing: 6 * ratio
                            rightPadding: 20 * ratio

                            Repeater {
                                model: questionCount_2

                                //-- Circle of number --//
                                Rectangle{
                                    width: 30
                                    height: width
                                    //                                    visible: model.s === "Section2" ? true : false
                                    visible: true

                                    radius: width / 2
                                    //                                    color: "#5b75a7"
                                    color: (model_ans.get(questionCount_1 + index)["answer"] === "") ? "#5b75a7" : "#006400"

                                    //                                    border.color: model.answer !== "" ? "#55FF0000" : "#ffffff"
                                    border.color: "#ffffff"
                                    border.width: 2

                                    //-- Number --//
                                    Label{
                                        text: (questionCount_1+index+1 === start_2) ? (start_2+"/"+end_2) : (questionCount_1+index + 1)
                                        anchors.centerIn: parent
                                        font.pixelSize: (questionCount_1+index+1 === start_2) ? 10 : 15
                                        color: "#ffffff"
                                    }

                                    ItemDelegate{
                                        anchors.fill: parent
                                        onClicked: {
                                            testSection2.checkSection2()
                                            if (model_section2.get(index+model_section2.get(index)["factor"])["type"] === "completing summary paragraph" ){
                                                lst_Answer_sec2.positionViewAtIndex(model_section2.get(index+model_section2.get(index)["factor"])["firstindex"]+1 , ListView.Center)
                                            }else if (model_section2.get(index+model_section2.get(index)["factor"])["type"] === "map and chart"){
                                                lst_Answer_sec2.positionViewAtIndex(model_section2.get(index+model_section2.get(index)["factor"])["firstindex"]+1 , ListView.Center)
                                            }else{
                                                lst_Answer_sec2.positionViewAtIndex(index+model_section2.get(index)["factor"] , ListView.Center)
                                            }

                                            //                                            console.log((index) + "  " + model_questions.get(index).name)

                                        }
                                    }

                                }

                            }
                        }
                    }


                }

                //-- Section 3 Question's Number --//
                Rectangle{
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    color: "#5b75a7"

                    //-- right Separator --//
                    Rectangle{
                        width: 1
                        height: parent.height * 0.85

                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                    }


                    //-- Label of Section 1 --//
                    Label{
                        id: lbl_Section3
                        text: "Section 3"
                        font.pixelSize: Qt.application.font.pixelSize
                        font.family: segoeUI.name
                        color: "#ffffff"

                        anchors.left: parent.left
                        anchors.leftMargin: 10 * ratio
                    }

                    //-- list of Questions in Section 1 --//
                    Flickable{
                        id: flick_S3
                        width: parent.width
                        height: parent.height - lbl_Section1.implicitHeight
                        contentHeight: s3Flow.height
                        anchors.bottom: parent.bottom
                        leftMargin: 8 * ratio
                        rightMargin: 8 * ratio
                        clip: true

                        //                            anchors.margins: 20 * ratio

                        ScrollBar.vertical: ScrollBar {
                            width: 8 * ratio
                            policy: ScrollBar.AsNeeded
                            parent: flick_S3.parent
                            anchors.top: flick_S3.top
                            anchors.right: flick_S3.right
                            anchors.bottom: flick_S3.bottom
                        }

                        Flow {
                            id: s3Flow
                            width: parent.width
                            height: implicitHeight
                            spacing: 6 * ratio
                            rightPadding: 20 * ratio

                            Repeater {
                                model: questionCount_3

                                Rectangle{
                                    width: 30
                                    height: width
                                    //                                    visible: model.s === "Section3" ? true : false
                                    visible: true

                                    radius: width / 2
                                    //                                    color: "#5b75a7"
                                    color: (model_ans.get(questionCount_1 + questionCount_2 +index)["answer"] === "") ? "#5b75a7" : "#006400"

                                    //                                    border.color: model.answer !== "" ? "#55FF0000" : "#ffffff"
                                    border.color: "#ffffff"
                                    border.width: 2

                                    Label{
                                        text: (questionCount_1+questionCount_2+index+1 === start_3) ? (start_3+"/"+end_3) : (questionCount_1+questionCount_2+index + 1)
                                        anchors.centerIn: parent
                                        font.pixelSize: (questionCount_1+questionCount_2+index+1 === start_3) ? 10 : 15
                                        color: "#ffffff"
                                    }

                                    ItemDelegate{
                                        anchors.fill: parent
                                        onClicked: {
                                            testSection3.checkSection3()
                                            if (model_section3.get(index+model_section3.get(index)["factor"])["type"] === "completing summary paragraph" ){
                                                lst_Answer_sec3.positionViewAtIndex(model_section3.get(index+model_section3.get(index)["factor"])["firstindex"]+1 , ListView.Center)
                                            }else if (model_section3.get(index+model_section3.get(index)["factor"])["type"] === "map and chart"){
                                                lst_Answer_sec3.positionViewAtIndex(model_section3.get(index+model_section3.get(index)["factor"])["firstindex"]+1 , ListView.Center)
                                            }else{
                                                lst_Answer_sec3.positionViewAtIndex(index+model_section3.get(index)["factor"] , ListView.Center)
                                            }
                                            //                                            console.log((index) + "  " + model_questions.get(index).name)
                                        }
                                    }

                                }

                            }
                        }
                    }



                }

                //-- Buttons and Countdown Timer --//
                Rectangle{
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    color: "#5b75a7"

                    RowLayout{
                        anchors.fill: parent
                        spacing: 0

                        //-- Timer --//
                        Rectangle{

                            Layout.fillWidth: true
                            Layout.fillHeight: true

                            color: "transparent"

                            ColumnLayout{
                                anchors.fill: parent
                                spacing: 7

                                Item {
                                    Layout.fillHeight: true
                                }

                                //-- Timer icon --//
                                Label{
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: implicitHeight
                                    horizontalAlignment: Qt.AlignHCenter
                                    //verticalAlignment: Qt.AlignVCenter

                                    text: Icons.timer
                                    font.family: webfont.name
                                    font.pixelSize: Qt.application.font.pixelSize * 3
                                    color: "#ffffff"

                                }

                                //-- Timer --//
                                Label{

                                    Layout.preferredWidth: implicitWidth
                                    Layout.fillHeight: true
                                    Layout.alignment: Qt.AlignHCenter
                                    verticalAlignment: Qt.AlignVCenter

                                    text: cTimer.timerLabel
                                    font.family: iranSansMedium.name
                                    font.pixelSize: Qt.application.font.pixelSize * 1.4 * 1.5
                                    //font.bold: true

                                    color: "#ffffff"

                                }

                                Item {
                                    Layout.fillHeight: true
                                }
                            }


                        }

                        //-- Buttons --//
                        Rectangle{
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            color: "transparent"

                            ColumnLayout{
                                anchors.fill: parent
                                spacing: 0

                                //-- Send Button --//
                                ReadingFooter_Buttons{
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    visible: showList

                                    centerFlag: true

                                    lblText: "ارسال"

                                    iconSource: "qrc:/Content/Images/Reading_Footer/footer_Send.png"

                                    onClickRFB: {
                                        stopTimer()

                                        sView.push(pagesubmitcomponent)
                                    }

                                    labelRightMargin: 20 * ratio

                                    Rectangle{
                                        width: parent.width
                                        height: 1
                                        anchors.bottom: parent.bottom
                                    }

                                }

                                //-- Review Button --//
                                ReadingFooter_Buttons{
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    visible: showList

                                    centerFlag: true

                                    lblText: "بازبینی"

                                    iconSource: "qrc:/Content/Images/Reading_Footer/footer_Review.png"

                                    onClickRFB: {
                                        reviewTest.open()
                                    }

                                    Rectangle{
                                        width: parent.width
                                        height: 1
                                        anchors.bottom: parent.bottom
                                    }

                                }

                                //-- Solution Button --//
                                ReadingFooter_Buttons{
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    visible: showList

                                    centerFlag: true

                                    lblText: "پاسخ سوالات"

                                    iconSource: "qrc:/Content/Images/Reading_Footer/footer_Light.png"

                                    onClickRFB: {
                                        console.log(lblText)
                                        stopTimer()

                                        sView.push(pageanswercomponent)

                                    }

                                }

                            }

                        }
                    }

                }
            }


        }

    }


}
