import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

import "./../../Fonts/Icon.js" as Icons
import "./../Utils/Enum.js" as Enum
import "./../Utils/ConvertRTFtoPlain.js" as ConvertRTFtoPlain

import "./../Utils/ReadingFooter"
import "./../Modules"
import "./../Pages/Test"


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

                    //-- Label --//
                    Label{
                        id: lbl_Section1
                        text: "Questions"
                        font.pixelSize: Qt.application.font.pixelSize
                        font.family: segoeUI.name
                        color: "#ffffff"

                        anchors.left: parent.left
                        anchors.leftMargin: 10 * ratio
                    }

                    //-- list of Questions --//
                    Flickable{
                        id: flick_S1
                        width: parent.width
                        height: parent.height - lbl_Section1.implicitHeight
                        contentHeight: s1Flow.height
                        anchors.bottom: parent.bottom
                        leftMargin: 8 * ratio
                        rightMargin: 8 * ratio
                        clip: true

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
                                model: questionsCheckCount

                                Rectangle{
                                    width: 30
                                    height: width

                                    visible: true

                                    radius: width / 2
                                    color: (model_ans.get(index)["answer"] === "") ? "#5b75a7" : "#006400"

                                    border.color: "#ffffff"
                                    border.width: 2

                                    Label{
                                        text: (questionsCheckCount === questionCount) ? (model.index + 1) : ("1/"+questionCount)
                                        font.pixelSize: (questionsCheckCount === questionCount) ? 15 : 10
                                        anchors.centerIn: parent
                                        color: "#ffffff"
                                    }

                                    ItemDelegate{
                                        anchors.fill: parent
                                        onClicked: {
                                            if (model_mv.get(index)["type"] === "completing summary paragraph" || model_mv.get(index)["type"] === "map and chart"){
                                                lst_Answer_sec1.positionViewAtIndex(1 , ListView.Center)
                                            }else{
                                                lst_Answer_sec1.positionViewAtIndex(index+1 , ListView.Center)
                                            }

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
                                ReadingFooter_Buttons2{
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
                                ReadingFooter_Buttons2{
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
                                ReadingFooter_Buttons2{
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

//import QtQuick 2.9
//import QtQuick.Controls 2.2
//import QtQuick.Layouts 1.3
//import QtGraphicalEffects 1.0

//import "./../../Fonts/Icon.js" as Icons

//import "./../Pages"
//import "./../Utils/ReadingFooter"


//Rectangle{
//    property int section1_num: 1
//    property int section2_num: 1
//    property int section3_num: 1

//    Layout.fillWidth: true
//    color: "#5b75a7"
//    clip: true

//    RowLayout{
//        Layout.fillWidth: true
//        spacing: 20

//        Flow {
//            id: s1Flow
//            width: parent.width
//            height: implicitHeight
//            leftPadding: 20

//            anchors.verticalCenter: parent.verticalCenter

//            spacing: 6

//            Label{
//                text: "Section 1"
//                color: "#ffffff"
//                font.pixelSize: 10

//            }
//            Grid {
//                id: grid
//                x: 5; y: 5
//                rows: 3; columns: 7; spacing: 10

//                Repeater {
//                    id: repeater
//                    model: section1_num

//                    Rectangle{
//                        width: 30
//                        height: width

//                        visible: true

//                        radius: width / 2
//                        color: (myquestion.get(index).answer !== "") ? "#006400" : "#5b75a7"

//                        border.color: "#ffffff"
//                        border.width: 2

//                        Label{
//                            text: model.index + 1
//                            anchors.centerIn: parent
//                            color: "#ffffff"
//                        }

//                        ItemDelegate{
//                            anchors.fill: parent
//                            onClicked: {
//                                lst_Answer_sec1.positionViewAtIndex(index , ListView.Center)
//                                //                                console.log((index) + "  " + myquestion.get(index).name)

//                            }
//                        }

//                    }
//                }
//            }

//        }
//        //-- Separator --//
//        Rectangle{
//            width: 1
//            height: 3 * 30
//            Layout.alignment: Qt.AlignVCenter
//            color: "#ffffff"
//        }
//        Flow {
//            id: s2Flow
//            width: parent.width
//            height: implicitHeight
//            //            leftPadding: 20

//            anchors.verticalCenter: parent.verticalCenter

//            spacing: 6

//            Label{
//                text: "Section 2"
//                color: "#ffffff"
//                font.pixelSize: 10
//            }
//            Grid {
//                id: grid2
//                x: 5; y: 5
//                rows: 3; columns: 7; spacing: 10

//                Repeater {
//                    id: repeater2
//                    model: section2_num

//                    Rectangle{
//                        width: 30
//                        height: width

//                        visible: true

//                        radius: width / 2
//                        color: (myquestion.get(index).answer !== "") ? "#006400" : "#5b75a7"

//                        border.color: "#ffffff"
//                        border.width: 2

//                        Label{
//                            text: model.index + 1
//                            anchors.centerIn: parent
//                            color: "#ffffff"
//                        }

//                        ItemDelegate{
//                            anchors.fill: parent
//                            onClicked: {
//                                lst_Answer_sec1.positionViewAtIndex(index , ListView.Center)
//                                //                                console.log((index) + "  " + model_questions.get(index).name)

//                            }
//                        }

//                    }
//                }
//            }
//        }
//        //-- Separator --//
//        Rectangle{
//            width: 1
//            height: 3 * 30
//            Layout.alignment: Qt.AlignVCenter
//            color: "#ffffff"
//        }
//        Flow {
//            id: s3Flow
//            width: parent.width
//            height: implicitHeight
//            //            leftPadding: 20

//            anchors.verticalCenter: parent.verticalCenter

//            spacing: 6

//            Label{
//                text: "Section 3"
//                color: "#ffffff"
//                font.pixelSize: 10
//            }
//            Grid {
//                id: grid3
//                x: 5; y: 5
//                rows: 3; columns: 7; spacing: 10

//                Repeater {
//                    id: repeater3
//                    model: section3_num

//                    Rectangle{
//                        width: 30
//                        height: width

//                        visible: true

//                        radius: width / 2
//                        color: (myquestion.get(index).answer !== "") ? "#006400" : "#5b75a7"

//                        border.color: "#ffffff"
//                        border.width: 2

//                        Label{
//                            text: model.index + 1
//                            anchors.centerIn: parent
//                            color: "#ffffff"
//                        }

//                        ItemDelegate{
//                            anchors.fill: parent
//                            onClicked: {
//                                lst_Answer_sec1.positionViewAtIndex(index , ListView.Center)
//                                //                                console.log((index))

//                            }
//                        }

//                    }
//                }
//            }

//        }
//        //-- Separator --//
//        Rectangle{
//            width: 1
//            height: 3 * 30
//            Layout.alignment: Qt.AlignVCenter
//            color: "#ffffff"
//        }
//        //        //-- Countdown Timer --//
//        //        Countdown_Timer2{
//        //            id: cTimer

//        //            scale: 2
//        //            iconVisible: false
//        //            height: 100
//        //            width: 100

//        //            anchors.right: parent.right

//        //        }
//        Rectangle{
//            Layout.fillWidth: true
//            Layout.fillHeight: true

//            color: "#ffffff"

//            RowLayout{
//                anchors.fill: parent
//                spacing: 0

//                //-- Timer --//
//                Rectangle{

//                    Layout.fillWidth: true
//                    Layout.fillHeight: true

//                    color: "transparent"

//                    ColumnLayout{
//                        anchors.fill: parent
//                        spacing: 7

//                        Item {
//                            Layout.fillHeight: true
//                        }

//                        //-- Timer icon --//
//                        Label{
//                            Layout.fillWidth: true
//                            Layout.preferredHeight: implicitHeight
//                            horizontalAlignment: Qt.AlignHCenter
//                            //verticalAlignment: Qt.AlignVCenter

//                            text: Icons.timer
//                            font.family: webfont.name
//                            font.pixelSize: Qt.application.font.pixelSize * 3
//                            color: "#ffffff"

//                        }

//                        //-- Timer --//
//                        Label{

//                            Layout.preferredWidth: implicitWidth
//                            Layout.fillHeight: true
//                            Layout.alignment: Qt.AlignHCenter
//                            verticalAlignment: Qt.AlignVCenter

//                            text: cTimer.timerLabel
//                            font.family: iranSansMedium.name
//                            font.pixelSize: Qt.application.font.pixelSize * 1.4 * 1.5
//                            //font.bold: true

//                            color: "#ffffff"

//                        }

//                        Item {
//                            Layout.fillHeight: true
//                        }
//                    }


//                }

//                //-- Buttons --//
//                Rectangle{
//                    Layout.fillWidth: true
//                    Layout.fillHeight: true
//                    color: "transparent"
//                    ColumnLayout{
//                        anchors.fill: parent
//                        spacing: 0

//                        //-- Send Button --//
//                        ReadingFooter_Buttons2{
//                            Layout.fillWidth: true
//                            Layout.fillHeight: true
//                            visible: showList

////                            centerFlag: true

//                            lblText: "ارسال"

//                            iconSource: "qrc:/Content/Images/Reading_Footer/footer_Send.png"

//                            onClickRFB: {
//                                stopTimer()

//                                sView.push(Enum._PAGE_Submit)
//                            }
//                            labelRightMargin: 20 * ratio
//                            Rectangle{
//                                width: parent.width
//                                height: 1
//                                anchors.right: parent.right
//                                anchors.bottom: parent.bottom
//                            }
//                        }

//                        //-- Review Button --//
//                        ReadingFooter_Buttons2{
//                            id: btn_ReviewRF             // RF => Reading Footer
//                            Layout.fillWidth: true
//                            Layout.fillHeight: true
//                            visible: showList

//                            lblText: "بازبینی"

//                            iconSource: "qrc:/Content/Images/Reading_Footer/footer_Review.png"

//                            onClickRFB: {
//                                reviewTest.open()
//                            }
//                            Rectangle{
//                                width: parent.width
//                                height: 1
//                                anchors.right: parent.right
//                                anchors.bottom: parent.bottom
//                            }
//                        }

//                        //-- Solution Button --//
//                        ReadingFooter_Buttons2{
//                            Layout.fillWidth: true
//                            Layout.fillHeight: true
//                            visible: showList

//                            lblText: "پاسخ سوالات"

//                            iconSource: "qrc:/Content/Images/Reading_Footer/footer_Light.png"

//                            onClickRFB: {
//                                stopTimer()

//                                sView.push(Enum._PAGE_Answer)

//                            }
//                            Rectangle{
//                                width: parent.width
//                                height: 1
//                                anchors.right: parent.right
//                                anchors.bottom: parent.bottom
//                            }
//                        }

//                    }

//                }

//            }

//        }
//    }


//    Rectangle{
//        width: parent.width
//        height: 2
//        anchors.bottom: parent.bottom
//        color: "#ffffff"
//    }
//}
