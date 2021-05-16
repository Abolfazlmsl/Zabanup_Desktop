import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

import "./../../Fonts/Icon.js" as Icons
import "./../Utils/Utils.js" as Util

import "./../Pages/ListModels"

Dialog{
    id:reviewTest_Popup

    //-- answer model list --//
    property ListModel model_a

    //-- Test Model --//

    width: 600
    height: 600

    padding: 0
    topPadding: 0

    modal: true

    //-- Close Icon on TopRight --//
    header: Rectangle{
        width: parent.width
        height: 40 * ratio

        color: "transparent"

        //-- Close Icon --//
        Label{
            id: lbl_CloseRT

            anchors.right: parent.right
            height: parent.height
            width: height

            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter

            text: Icons.close

            font.family: webfont.name
            font.pixelSize: Qt.application.font.pixelSize * 1.7

            color: "#aaaaaa"

            ItemDelegate{
                anchors.fill: parent
                onClicked: {
                    reviewTest_Popup.close()
                }
            }

        }
    }


    ColumnLayout{
        anchors.fill: parent
        spacing: 5 * ratio

        //-- Title --//
        Rectangle{
            id:titleRect

            Layout.preferredWidth: parent.width - (lbl_CloseRT.width * 2)
            Layout.preferredHeight: 50 * ratio
            Layout.alignment: Qt.AlignHCenter

            color: "#5b75a7"

            radius: 5 * ratio

            //-- Title Text --//
            Label{
                anchors.centerIn: parent

                text: "بازبینی پاسخ ها"

                font.family: iranSans.name
                font.pixelSize: Qt.application.font.pixelSize * 1.3

                color: "#ffffff"

            }

        }
        /*
        //-- Answers --//
        Rectangle{
            id: answerRect
            Layout.preferredHeight: answerFlow.implicitHeight
            Layout.preferredWidth: titleRect.width
            Layout.alignment: Qt.AlignHCenter

            color: "transparent"

            //-- Q_Number and Answers of User --//
            Flow{
                id:answerFlow
                anchors.fill: parent
                spacing: 0

                Repeater {
                    id:answerRepeater
//                    model: questionCount //model_questions
                    model: model_a

                    //-- Q_Number and Answers of User --//
                    Rectangle {
                        width: answerRect.width / 4
                        height: 40
                        border.width: 1
                        border.color: "#999999"

                        //-- Question Number --//
                        Label{
                            id:qNumber

                            width: implicitWidth
                            height: parent.height
                            anchors.leftMargin: 5 * ratio
                            anchors.left: parent.left
                            verticalAlignment: Qt.AlignVCenter
                            text: "Q"+ (index + 1) + ": "
//                                {
//                                if(model.s === "Section1"){
//                                    return "Q"+ (index + 1) + ": ";
//                                }
//                                else if(model.s === "Section2"){
//                                    return "Q"+ ((index + 1) - section1_Count) + ": ";
//                                }
//                                else if(model.s === "Section3"){
//                                    return "Q"+ ((index + 1) - section1_Count - section2_Count) + ": ";
//                                }
//                                else{
//                                    return "Has Problem"
//                                }
//                            }

                            font.family: segoeUI.name
                            font.pixelSize: Qt.application.font.pixelSize * 1.3

                            clip: true

                        }

                        //-- Question Answer --//
                        Label{
                            id:qAnswer

                            width: implicitWidth
                            height: parent.height
                            anchors.rightMargin: 5 * ratio
                            anchors.left: qNumber.right
                            verticalAlignment: Qt.AlignVCenter

//                            text: model_questions.get(index).answer
                            text: answer
                            font.family: segoeUI.name
                            font.pixelSize: Qt.application.font.pixelSize * 1

                            clip: true

                        }
                    }
                }
            }

        }
*/


        //-- Answers Section --//
        Rectangle{
            Layout.preferredWidth: parent.width - (lbl_CloseRT.width * 2)
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignHCenter

            color: "#ffffff"

            border.color: "#bbbbbb"
            border.width: 1

            Flickable{
                id: flick_Answers
                width: parent.width - 16
                height: parent.height
                anchors.horizontalCenter: parent.horizontalCenter
                clip: true
                boundsBehavior: Flickable.StopAtBounds
                flickableDirection: Flickable.VerticalFlick

                contentWidth: width
                contentHeight: lbl_Section1.height +
                               flow_AnswerS1.height + 30 // 15 + 15 = 30  => TopMargin + BottomMargin

                ScrollBar.vertical: ScrollBar {
                        parent: flick_Answers.parent
                        anchors.top: flick_Answers.top
                        anchors.right: flick_Answers.right
                        anchors.rightMargin: -8
                        anchors.bottom: flick_Answers.bottom
                    }

                //-- label "Questions" --//
                Label{
                    id: lbl_Section1
                    width: parent.width
                    height: implicitHeight

                    anchors.top: parent.top
                    anchors.topMargin: 15

                    horizontalAlignment: Qt.AlignLeft

                    text: "Questions : "
                    font.family: iranSans.name
                    font.pixelSize: Qt.application.font.pixelSize * 1.6
                    color: Util.color_BaseBlue
                }

                //-- Q_Number and Answers of User --//
                Flow{
                    id:flow_AnswerS1
                    width: parent.width
                    height: implicitHeight

                    anchors.top: lbl_Section1.bottom

                    spacing: 0

                    Repeater {
                        id:rpt_AnswerS1
                        model: questionsCheckCount

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
                                text: (questionsCheckCount === questionCount) ? (index + 1) : ("1/"+questionCount)

                                font.family: segoeUI.name
                                font.pixelSize: (questionsCheckCount === questionCount) ? Qt.application.font.pixelSize * 1.3 : 10
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

                                text: model_a.get(index)["answer"]
                                font.family: segoeUI.name
                                font.pixelSize: Qt.application.font.pixelSize * 1

                                clip: true

                            }
                        }
                    }
                }

            }


        }





        //-- Close Button Area --//
        Rectangle{
            id: closeRect
            Layout.preferredHeight: 80
            Layout.fillWidth: true

            color: "transparent"

            //-- Close Button --//
            Rectangle{
                width: 120 * ratio
                height: titleRect.height

                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter

                radius: titleRect.radius

                color: titleRect.color

                //-- Close Label --//
                Label{
                    anchors.centerIn: parent

                    text: "بستن"

                    font.family: iranSans.name
                    font.pixelSize: Qt.application.font.pixelSize * 1.3

                    color: "#ffffff"

                }


                ItemDelegate{
                    anchors.fill: parent
                    onClicked: {
                        reviewTest_Popup.close()
                    }
                }

            }

        }

    }

//    Button{
//        text: "test"
//        onClicked: {
//            print(JSON.stringify(model_a))
//        }
//    }

}
