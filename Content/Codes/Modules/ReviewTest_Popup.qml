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

    property var questionsCount1
    property var questionsCount2
    property var questionsCount3
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
                contentHeight: lbl_Section1.height + lbl_Section2.height + lbl_Section3.height +
                               flow_AnswerS1.height + flow_AnswerS2.height + flow_AnswerS3.height + 30 // 15 + 15 = 30  => TopMargin + BottomMargin

                ScrollBar.vertical: ScrollBar {
                        parent: flick_Answers.parent
                        anchors.top: flick_Answers.top
                        anchors.right: flick_Answers.right
                        anchors.rightMargin: -8
                        anchors.bottom: flick_Answers.bottom
                    }

                //-- label "Sections 1" --//
                Label{
                    id: lbl_Section1
                    width: parent.width
                    height: implicitHeight

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
                        model: questionCount_1

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
                                text: (index+1 === start_1) ? (start_1+"/"+end_1) : (index + 1)

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

                                text: model_a.get(index)["answer"]
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

                    anchors.top: lbl_Section2.bottom

                    spacing: 0

                    Repeater {
                        id:rpt_AnswerS2
                        model: questionCount_2

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

                                text: model_a.get(questionCount_1 + index)["answer"]
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

                    anchors.top: lbl_Section3.bottom

                    spacing: 0

                    Repeater {
                        id:rpt_AnswerS3
                        model: questionCount_3

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

                                text: model_a.get(questionCount_1 + questionCount_2 + index)["answer"]
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

    Button{
        text: "test"
        onClicked: {
            print(JSON.stringify(model_a))
        }
    }

}
