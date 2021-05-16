import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Window 2.14
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.14

import "./../../ListModels"
import "./../../../Modules"

import "./../../../../Fonts/Icon.js" as Icons
import "./../../../Utils/Enum.js" as Enum
import "./../../../Utils/Utils.js" as Util


Item {
    property var questionNumberSec1
    property var questionNumberSec2
    property var questionNumberSec3

    Rectangle{
        id: rootAnswerPage

        onHeightChanged: {
            if(mdl_Comment.height > 50){
                mdl_Comment.height = rootAnswerPage.height * 0.7
            }
        }

        anchors.fill: parent

        ColumnLayout{
            anchors.fill: parent
            spacing: 0

            //-- Top Section (EveryThing without Comments) --//
            Rectangle{
                Layout.fillWidth: true
                Layout.fillHeight: true

                //                color: "#55ff0000"

                RowLayout{
                    anchors.fill: parent
                    spacing: 0

                    //-- Left Section (Grade Board) --//
                    Rectangle{
                        Layout.fillHeight: true
                        Layout.preferredWidth: (root.width < 1200) ? parent.width * 0.3 : (root.width > 1600) ? parent.width * 0.2 :  parent.width * 0.25

                        //-- Border and Grade Board --//
                        Rectangle{
                            width: parent.width - (8 * ratio)
                            height: parent.height

                            anchors.right: parent.right
                            anchors.bottom: parent.bottom

                            border.width: 2
                            border.color: "#dddddd"

                            //-- header --//
                            Rectangle{
                                id: boardHeader
                                width: parent.width
                                height: parent.height * 0.1

                                color: Util.color_BaseBlue

                                Label{
                                    text: "تابلو نمرات"
                                    font.family: iranSans.name
                                    font.pixelSize: Qt.application.font.pixelSize * 1.6
                                    anchors.centerIn: parent
                                    color: "#ffffff"
                                }
                            }

                            ListView{
                                width: parent.width - 4
                                height: parent.height - boardHeader.height

                                anchors.horizontalCenter: parent.horizontalCenter

                                topMargin: 5

                                clip: true

                                anchors.top: boardHeader.bottom

                                //-- HEADER --//
                                header: Rectangle {
                                    width: parent.width
                                    height: 30
                                    z: 2

                                    Rectangle{
                                        width: parent.width
                                        height: 2
                                        anchors.bottom: parent.bottom
                                        color: "#000000"
                                    }

                                    RowLayout{

                                        width: parent.width
                                        height: parent.height - 2
                                        anchors.top: parent.top
                                        spacing: 0
                                        layoutDirection: Qt.RightToLeft

                                        //-- "ردیف" --//
                                        Rectangle {
                                            id: header_Row
                                            Layout.fillHeight: true
                                            Layout.preferredWidth: parent.width * 0.1
                                            color: "#ffffff"
                                            clip: true
                                            Label {
                                                visible: false
                                                text: "ردیف"
                                                font.family: iranSans.name
                                                font.pixelSize: Qt.application.font.pixelSize * 0.8
                                                anchors.centerIn: parent
                                            }

                                        }

                                        //-- "کاربر" --//
                                        Rectangle {
                                            id: header_User
                                            Layout.fillHeight: true
                                            Layout.preferredWidth: parent.width * 0.3
                                            color: "#ffffff"
                                            clip: true
                                            Label {
                                                text: "کاربر"
                                                font.family: iranSans.name
                                                font.pixelSize: Qt.application.font.pixelSize * 1.1
                                                anchors.centerIn: parent
                                            }
                                        }

                                        //-- "نمره" --//
                                        Rectangle {
                                            id: header_Grade
                                            Layout.fillHeight: true
                                            Layout.preferredWidth: parent.width * 0.3
                                            color: "#ffffff"
                                            clip: true
                                            Label {
                                                text: "نمره"
                                                font.family: iranSans.name
                                                font.pixelSize: Qt.application.font.pixelSize * 1.1
                                                anchors.centerIn: parent
                                            }
                                        }

                                        //-- "زمان" --//
                                        Rectangle {
                                            id: header_Time
                                            Layout.fillHeight: true
                                            Layout.preferredWidth: parent.width * 0.3
                                            color: "#ffffff"
                                            clip: true
                                            Label {
                                                text: "زمان"
                                                font.family: iranSans.name
                                                font.pixelSize: Qt.application.font.pixelSize * 1.1
                                                anchors.centerIn: parent
                                            }
                                        }


                                    }



                                }

                                model: AnswerPage_GradeBoardModel{id: gradeBoardModel}

                                headerPositioning: ListView.OverlayHeader

                                delegate: Rectangle{
                                    width: parent.width
                                    height: 30

                                    RowLayout{
                                        anchors.fill: parent
                                        spacing: 0
                                        layoutDirection: Qt.RightToLeft

                                        //-- "ردیف" --//
                                        Rectangle{
                                            id: lst_Row
                                            Layout.fillHeight: true
                                            Layout.preferredWidth: parent.width * 0.1

                                            Label{
                                                id: lbl_Row
                                                width: parent.width
                                                height: width

                                                verticalAlignment: Qt.AlignVCenter
                                                horizontalAlignment: Qt.AlignHCenter

                                                text: index + 1
                                                font.family: iranSansFAnum.name
                                                font.pixelSize: Qt.application.font.pixelSize * 0.8

                                                background: Rectangle{
                                                    width: lbl_Row.implicitHeight * 1.5
                                                    height: width
                                                    anchors.centerIn: parent
                                                    color: ((index + 1) === 1) ? "#FFDF00" : ((index + 1) === 2) ? "#c0c0c0" : ((index + 1) === 3) ? "#cd8032" : "transparent"
                                                    radius: width / 2
                                                }

                                            }
                                        }

                                        //-- "کاربر" --//
                                        Rectangle{
                                            id: lst_User
                                            Layout.fillHeight: true
                                            Layout.preferredWidth: parent.width * 0.3

                                            Label{
                                                width: parent.width
                                                height: parent.height

                                                verticalAlignment: Qt.AlignVCenter
                                                horizontalAlignment: Qt.AlignHCenter

                                                text: model.user
                                                font.family: iranSans.name
                                                font.pixelSize: Qt.application.font.pixelSize * 1
                                            }
                                        }

                                        //-- "نمره" --//
                                        Rectangle{
                                            id: lst_Grade
                                            Layout.fillHeight: true
                                            Layout.preferredWidth: parent.width * 0.3

                                            Label{
                                                width: parent.width
                                                height: parent.height

                                                verticalAlignment: Qt.AlignVCenter
                                                horizontalAlignment: Qt.AlignHCenter

                                                text: model.grade
                                                font.family: iranSansFAnum.name
                                                font.pixelSize: Qt.application.font.pixelSize * 1
                                            }
                                        }

                                        //-- "زمان" --//
                                        Rectangle{
                                            id: lst_Time
                                            Layout.fillHeight: true
                                            Layout.preferredWidth: parent.width * 0.3

                                            Label{
                                                width: parent.width
                                                height: parent.height

                                                verticalAlignment: Qt.AlignVCenter
                                                horizontalAlignment: Qt.AlignHCenter

                                                text: model.time
                                                font.family: iranSansFAnum.name
                                                font.pixelSize: Qt.application.font.pixelSize * 1
                                            }
                                        }


                                    }

                                }
                            }

                        }

                    }

                    //-- Right Section --//
                    Rectangle{
                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        //                        color: "#550000ff"

                        ColumnLayout{
                            anchors.fill: parent
                            spacing: 0

                            //-- Test Info And Test Title and ... --//
                            Rectangle{
                                id: root_TestInfo
                                Layout.fillWidth: true
                                Layout.preferredHeight: parent.height * 0.25

                                //                                color: "#55888888"

                                RowLayout{
                                    anchors.fill: parent
                                    layoutDirection: Qt.RightToLeft
                                    spacing: 0

                                    //-- Image Book --//
                                    Image {
                                        id: img_book
                                        Layout.preferredHeight: parent.height - (root_TestInfo.height * 0.2)
                                        Layout.preferredWidth: height
                                        Layout.rightMargin: root_TestInfo.height * 0.2


                                        horizontalAlignment: Qt.AlignRight

                                        fillMode: Image.PreserveAspectFit

                                        source: "qrc:/Content/Images/SelectTest_Image/book_7.png"
                                    }

                                    //-- Title , Rate , Share --//
                                    Rectangle{
                                        Layout.fillHeight: true
                                        Layout.fillWidth: true
                                        color: "transparent"

                                        ColumnLayout{
                                            anchors.fill: parent
                                            spacing: 0

                                            //-- Title --//
                                            Rectangle{
                                                Layout.fillWidth: true
                                                Layout.fillHeight: true

                                                color: "transparent"

                                                //-- Title --//
                                                Label{
                                                    width: implicitWidth
                                                    height: parent.height

                                                    anchors.right: parent.right

                                                    text: "IELTS EXAM Title"
                                                    font.family: segoeUI.name
                                                    font.pixelSize: Qt.application.font.pixelSize * 1.2

                                                    verticalAlignment: Qt.AlignVCenter
                                                    horizontalAlignment: Qt.AlignRight
                                                }

                                            }

                                            //-- Rating --//
                                            Rectangle{
                                                Layout.fillWidth: true
                                                Layout.fillHeight: true
                                                //                                                color: "yellow"

                                                Rating{
                                                    anchors.fill: parent
                                                    anchors.right: parent.right

                                                    selectable: true

                                                }

                                            }

                                            //-- Share and Answer Button Section --//
                                            Rectangle{
                                                Layout.fillWidth: true
                                                Layout.fillHeight: true

                                                //-- Share Label --//
                                                Label{
                                                    id: lbl_Share
                                                    width: implicitWidth
                                                    height: parent.height

                                                    anchors.right: parent.right

                                                    text: "اشتراک گذاری : "
                                                    font.family: iranSans.name
                                                    font.pixelSize: Qt.application.font.pixelSize * 1.2

                                                    verticalAlignment: Qt.AlignVCenter
                                                    horizontalAlignment: Qt.AlignRight
                                                }

                                                //-- Web Icon --//
                                                Label{
                                                    id: lbl_WebIcon
                                                    width: implicitWidth
                                                    height: parent.height

                                                    anchors.right: lbl_Share.left
                                                    anchors.rightMargin: implicitWidth
                                                    verticalAlignment: Qt.AlignVCenter

                                                    text: Icons.web
                                                    font.family: webfont.name
                                                    font.pixelSize: Qt.application.font.pixelSize * 1.8
                                                    color: "#444444"

                                                    MouseArea{
                                                        anchors.fill: parent
                                                        cursorShape: Qt.PointingHandCursor

                                                        onClicked: {
                                                            log("WEB")
                                                        }
                                                    }

                                                }

                                                //-- Telegram Icon --//
                                                Label{
                                                    id: lbl_TelegramIcon
                                                    width: implicitWidth
                                                    height: parent.height

                                                    anchors.right: lbl_WebIcon.left
                                                    anchors.rightMargin: 5 * ratio
                                                    verticalAlignment: Qt.AlignVCenter

                                                    text: Icons.telegram
                                                    font.family: webfont.name
                                                    font.pixelSize: Qt.application.font.pixelSize * 1.8
                                                    color: "#444444"

                                                    MouseArea{
                                                        anchors.fill: parent
                                                        cursorShape: Qt.PointingHandCursor

                                                        onClicked: {
                                                            log("TELEGRAM")
                                                        }
                                                    }

                                                }

                                                //-- Instagram Icon --//
                                                Label{
                                                    id: lbl_InstagramIcon
                                                    width: implicitWidth
                                                    height: parent.height

                                                    anchors.right: lbl_TelegramIcon.left
                                                    anchors.rightMargin: 5 * ratio
                                                    verticalAlignment: Qt.AlignVCenter

                                                    text: Icons.instagram
                                                    font.family: webfont.name
                                                    font.pixelSize: Qt.application.font.pixelSize * 1.8
                                                    color: "#444444"

                                                    MouseArea{
                                                        anchors.fill: parent
                                                        cursorShape: Qt.PointingHandCursor

                                                        onClicked: {
                                                            log("INSTAGRAM")
                                                        }
                                                    }

                                                }

                                                //-- Whatsapp Icon --//
                                                Label{
                                                    id: lbl_WhatsappIcon
                                                    width: implicitWidth
                                                    height: parent.height

                                                    anchors.right: lbl_InstagramIcon.left
                                                    anchors.rightMargin: 5 * ratio
                                                    verticalAlignment: Qt.AlignVCenter

                                                    text: Icons.whatsapp
                                                    font.family: webfont.name
                                                    font.pixelSize: Qt.application.font.pixelSize * 1.8
                                                    color: "#444444"

                                                    MouseArea{
                                                        anchors.fill: parent
                                                        cursorShape: Qt.PointingHandCursor

                                                        onClicked: {
                                                            log("WHATSAPP")
                                                        }
                                                    }

                                                }

                                                //-- vertical Line (Separator) --//
                                                Rectangle{
                                                    id: separator
                                                    width: 2
                                                    height: parent.height * 0.7

                                                    anchors.verticalCenter: parent.verticalCenter
                                                    anchors.right: lbl_WhatsappIcon.left
                                                    anchors.rightMargin: lbl_WebIcon.implicitWidth

                                                    color: "#666666"
                                                }

                                                //-- describe Answer Button --//
                                                Rectangle{
                                                    id: btn_DescribeAnswer
                                                    width: lbl_DescribeAnswer.implicitWidth + (30 * ratio)
                                                    height: parent.height * 0.6
                                                    anchors.verticalCenter: parent.verticalCenter
                                                    anchors.right: separator.left
                                                    anchors.rightMargin: lbl_WebIcon.implicitWidth

                                                    color: "#0e90e1"
                                                    radius: 5 * ratio

                                                    Label{
                                                        id: lbl_DescribeAnswer
                                                        anchors.centerIn: parent

                                                        text: "پاسخ تشریحی"
                                                        font.family: iranSans.name
                                                        font.pixelSize: Qt.application.font.pixelSize

                                                        color: "#ffffff"

                                                    }
                                                }
                                            }


                                        }
                                    }
                                }

                            }

                            //-- "پاسخ کلیدی" Title and Icon --//
                            Rectangle{
                                Layout.fillWidth: true
                                Layout.preferredHeight: parent.height * 0.1
                                z: 2
                                //                                color: "#ebebeb"

                                DropShadow {
                                    anchors.fill: shadowRect
                                    verticalOffset: 3
                                    horizontalOffset: 2
                                    radius: 6.0
                                    samples: 9
                                    color: "#50000000"
                                    source: shadowRect
                                }

                                //-- For Shadow --//
                                Rectangle{
                                    id: shadowRect
                                    anchors.fill: parent

                                    color: "#ebebeb"

                                    //-- Puzzle Icon --//
                                    Label{
                                        id: lbl_PuzzleIcon
                                        width: implicitWidth
                                        height: parent.height

                                        anchors.right: parent.right
                                        anchors.rightMargin: root_TestInfo.height * 0.2
                                        verticalAlignment: Qt.AlignVCenter

                                        text: Icons.lightbulb_on_outline

                                        font.family: webfont.name
                                        font.pixelSize: Qt.application.font.pixelSize * 1.8
                                        color: "#444444"

                                    }


                                    //-- "پاسخ کلیدی" Label --//
                                    Label{
                                        id: lbl_KeyAnswer
                                        width: implicitWidth
                                        height: parent.height

                                        anchors.right: lbl_PuzzleIcon.left
                                        anchors.rightMargin: 10 * ratio

                                        text: "پاسخنامه : "
                                        font.family: iranSans.name
                                        font.pixelSize: Qt.application.font.pixelSize * 1.2

                                        verticalAlignment: Qt.AlignVCenter
                                        horizontalAlignment: Qt.AlignRight
                                    }


                                }



                            }

                            //-- Answers Section --//
                            Rectangle{
                                Layout.fillWidth: true
                                Layout.fillHeight: true

                                color: "#f6f6f6"

                                Flickable{
                                    id: flick_Answers
                                    width: parent.width - 15
                                    height: parent.height
                                    anchors.right: parent.right
                                    clip: true
                                    boundsBehavior: Flickable.StopAtBounds
                                    flickableDirection: Flickable.VerticalFlick

                                    contentWidth: parent.width
                                    contentHeight: lbl_Section1.height + lbl_Section2.height + lbl_Section3.height +
                                                   flow_AnswerS1.height + flow_AnswerS2.height + flow_AnswerS3.height + 30 // 15 + 15 = 30  => TopMargin + BottomMargin

                                    //-- label "Sections 1" --//
                                    Label{
                                        id: lbl_Section1

                                        width: parent.width
                                        height: implicitHeight
                                        visible: passage ? false:true
                                        anchors.top: parent.top
                                        anchors.topMargin: 15

                                        horizontalAlignment: Qt.AlignLeft

                                        text: "Section 1 : "
                                        font.family: iranSans.name
                                        font.pixelSize: Qt.application.font.pixelSize * 1.6
                                        color: Util.color_BaseBlue
                                    }

                                    //-- Q_Number and Answers of User in Section 1 --//
                                    Flow{
                                        id:flow_AnswerS1
                                        width: parent.width
                                        height: implicitHeight

                                        anchors.top: lbl_Section1.bottom

                                        spacing: 0

                                        Repeater {
                                            id:rpt_AnswerS1
                                            model: passage? questionsCheckCount:questionNumberSec1

                                            //-- Q_Number and Answers of User --//
                                            Rectangle {
                                                width: (flow_AnswerS1.width % 220 === 0) ? 220 : flow_AnswerS1.width / Math.floor(flow_AnswerS1.width / 220)
                                                height: 40
                                                color: "transparent"
                                                //                                                    border.width: 1
                                                //                                                    border.color: "#999999"

                                                //-- Question Number S1 --//
                                                Label{
                                                    id:lbl_QNumberS1

                                                    width: parent.height
                                                    height: parent.height
                                                    anchors.leftMargin: 5 * ratio
                                                    anchors.left: parent.left
                                                    verticalAlignment: Qt.AlignVCenter
                                                    horizontalAlignment: Qt.AlignHCenter
                                                    text: {
                                                        if (passage){
                                                            if (questionsCheckCount === questionCount) {(index + 1)}else{ ("1/"+questionCount)}
                                                        }else{
                                                            (index+1 === start_1) ? (start_1+"/"+end_1) : (index + 1)
                                                        }
                                                    }
                                                    font.family: segoeUI.name
                                                    font.pixelSize: Qt.application.font.pixelSize * 1.3
                                                    color: "#ffffff"

                                                    clip: true

                                                    background: Rectangle{
                                                        width: parent.width * 0.8
                                                        height: width

                                                        anchors.horizontalCenter: parent.horizontalCenter
                                                        anchors.verticalCenter: parent.verticalCenter

                                                        radius: width / 2

                                                        color: Util.color_BaseBlue
                                                    }

                                                }

                                                //-- Question Answer S1 --//
                                                Label{
                                                    id:lbl_QAnswerS1

                                                    width: implicitWidth
                                                    height: parent.height
                                                    anchors.rightMargin: 5 * ratio
                                                    anchors.left: lbl_QNumberS1.right
                                                    verticalAlignment: Qt.AlignVCenter

                                                    text: model_answer.get(index)["answer"]
                                                    font.family: segoeUI.name
                                                    font.pixelSize: Qt.application.font.pixelSize * 1

                                                    clip: true

                                                }
                                            }
                                        }
                                    }


                                    //-- label "Sections 2" --//
                                    Label{
                                        id: lbl_Section2
                                        width: parent.width
                                        height: implicitHeight
                                        visible: passage ? false:true
                                        anchors.top: flow_AnswerS1.bottom
                                        anchors.topMargin: 5

                                        horizontalAlignment: Qt.AlignLeft

                                        text: "Section 2 : "
                                        font.family: iranSans.name
                                        font.pixelSize: Qt.application.font.pixelSize * 1.6
                                        color: Util.color_BaseBlue

                                    }

                                    //-- Q_Number and Answers of User in Section 2 --//
                                    Flow{
                                        id:flow_AnswerS2
                                        width: parent.width
                                        height: implicitHeight
                                        visible: passage ? false:true

                                        anchors.top: lbl_Section2.bottom

                                        spacing: 0

                                        Repeater {
                                            id:rpt_AnswerS2
                                            model: questionNumberSec2

                                            //-- Q_Number and Answers of User in Section 2 --//
                                            Rectangle {
                                                width: (flow_AnswerS2.width % 220 === 0) ? 220 : flow_AnswerS2.width / Math.floor(flow_AnswerS2.width / 220)
                                                height: 40
                                                color: "transparent"
                                                //                                                    border.width: 1
                                                //                                                    border.color: "#999999"

                                                //-- Question Number S2 --//
                                                Label{
                                                    id:lbl_QNumberS2

                                                    width: parent.height
                                                    height: parent.height
                                                    anchors.leftMargin: 5 * ratio
                                                    anchors.left: parent.left
                                                    verticalAlignment: Qt.AlignVCenter
                                                    horizontalAlignment: Qt.AlignHCenter
                                                    text: (questionCount_1+index+1 === start_2) ? (start_2+"/"+end_2) : (questionCount_1+index + 1)

                                                    font.family: segoeUI.name
                                                    font.pixelSize: Qt.application.font.pixelSize * 1.3
                                                    color: "#ffffff"

                                                    clip: true

                                                    background: Rectangle{
                                                        width: parent.width * 0.8
                                                        height: width

                                                        anchors.horizontalCenter: parent.horizontalCenter
                                                        anchors.verticalCenter: parent.verticalCenter

                                                        radius: width / 2

                                                        color: Util.color_BaseBlue
                                                    }

                                                }

                                                //-- Question Answer S2 --//
                                                Label{
                                                    id:lbl_QAnswerS2

                                                    width: implicitWidth
                                                    height: parent.height
                                                    anchors.rightMargin: 5 * ratio
                                                    anchors.left: lbl_QNumberS2.right
                                                    verticalAlignment: Qt.AlignVCenter

                                                    text: model_answer.get(questionNumberSec1+index)["answer"]
                                                    font.family: segoeUI.name
                                                    font.pixelSize: Qt.application.font.pixelSize * 1

                                                    clip: true

                                                }
                                            }
                                        }
                                    }


                                    //-- label "Sections 3" --//
                                    Label{
                                        id: lbl_Section3
                                        width: parent.width
                                        height: implicitHeight
                                        visible: passage ? false:true
                                        anchors.top: flow_AnswerS2.bottom
                                        anchors.topMargin: 5

                                        horizontalAlignment: Qt.AlignLeft

                                        text: "Section 3 : "
                                        font.family: iranSans.name
                                        font.pixelSize: Qt.application.font.pixelSize * 1.6
                                        color: Util.color_BaseBlue

                                    }
                                    //-- Q_Number and Answers of User in Section 3 --//
                                    Flow{
                                        id:flow_AnswerS3
                                        width: parent.width
                                        height: implicitHeight
                                        visible: passage ? false:true
                                        anchors.top: lbl_Section3.bottom

                                        spacing: 0

                                        Repeater {
                                            id:rpt_AnswerS3
                                            model: questionNumberSec3

                                            //-- Q_Number and Answers of User in Section 2 --//
                                            Rectangle {
                                                width: (flow_AnswerS3.width % 220 === 0) ? 220 : flow_AnswerS3.width / Math.floor(flow_AnswerS3.width / 220)
                                                height: 40
                                                color: "transparent"
                                                //                                                    border.width: 1
                                                //                                                    border.color: "#999999"

                                                //-- Question Number S1 --//
                                                Label{
                                                    id:lbl_QNumberS3

                                                    width: parent.height
                                                    height: parent.height
                                                    anchors.leftMargin: 5 * ratio
                                                    anchors.left: parent.left
                                                    verticalAlignment: Qt.AlignVCenter
                                                    horizontalAlignment: Qt.AlignHCenter
                                                    text: (questionCount_1+questionCount_2+index+1 === start_3) ? (start_3+"/"+end_3) : (questionCount_1+questionCount_2+index + 1)

                                                    font.family: segoeUI.name
                                                    font.pixelSize: Qt.application.font.pixelSize * 1.3
                                                    color: "#ffffff"

                                                    clip: true

                                                    background: Rectangle{
                                                        width: parent.width * 0.8
                                                        height: width

                                                        anchors.horizontalCenter: parent.horizontalCenter
                                                        anchors.verticalCenter: parent.verticalCenter

                                                        radius: width / 2

                                                        color: Util.color_BaseBlue
                                                    }

                                                }

                                                //-- Question Answer S3 --//
                                                Label{
                                                    id:lbl_QAnswerS3

                                                    width: implicitWidth
                                                    height: parent.height
                                                    anchors.rightMargin: 5 * ratio
                                                    anchors.left: lbl_QNumberS3.right
                                                    verticalAlignment: Qt.AlignVCenter

                                                    text: model_answer.get(questionNumberSec1+questionNumberSec2+index)["answer"]
                                                    font.family: segoeUI.name
                                                    font.pixelSize: Qt.application.font.pixelSize * 1

                                                    clip: true

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

            //-- Comments space in layout--//
            Rectangle{
                Layout.fillWidth: true
                Layout.preferredHeight: 40

                color: "gray"

            }

        }


        Comment{
            id: mdl_Comment
            width: parent.width
            height: 40
            z: 2

            anchors.bottom: parent.bottom
        }

        //-- when open Comments , gray Back --//
        Rectangle{
            id: g_Blur
            width: parent.width
            height: parent.height - mdl_Comment.height

            color: "#80555555"
            opacity: 0

            MouseArea{
                visible: (g_Blur.opacity > 0) ? true : false
                anchors.fill: parent
                onClicked: {
                    mdl_Comment.expand = !mdl_Comment.expand
                }
            }
        }



    }

}
