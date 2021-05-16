import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Window 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

import "./../../../../Fonts/Icon.js" as Icons
import "./../../../Utils/Enum.js" as Enum

import "./../../../Modules"

Item {

    objectName: "CambridgeBookTest"

    property alias _ImgSource: testIMG.source
    property alias _Volume: lbl_Volume.text
    property alias _CambridgeTest: lbl_CambridgeTest.text
    property alias _Published: lbl_PublishedOn.text


    ColumnLayout{
        anchors.fill: parent
        spacing: 0

        //-- Book Image and Info --//
        Rectangle{
            Layout.fillWidth: true
            Layout.preferredHeight: 250 * ratio
            color: "transparent"
            RowLayout{
                anchors.fill: parent
                anchors.leftMargin: 15 * ratio
                spacing: 15 * ratio

                //-- Book Image --//
                Rectangle{
                    Layout.preferredHeight: testIMG.sourceSize.height * 0.6  * (widthRatio + ((1 - widthRatio) / 2))
                    Layout.preferredWidth: testIMG.sourceSize.width * 0.6  * (widthRatio + ((1 - widthRatio) / 2))

                    //-- Shadow of loaded_Images --//
                    DropShadow {
                        anchors.fill: testIMG
                        transparentBorder: true
                        horizontalOffset: -2
                        verticalOffset: 6
                        spread: 0.2
                        radius: 8.0
                        samples: 14
                        color: "#40000000"
                        source: testIMG
                    }

                    color: "transparent"
                    //-- Image of Selected Test in CambridgeBook --//
                    Image {
                        id: testIMG
                        width: parent.width

                        source: "qrc:/Content/Images/SelectTest_Image/book_7.png"

                        fillMode: Image.PreserveAspectFit

                    }

                }


                //-- Image Info --//
                Rectangle{
                    Layout.preferredHeight: testIMG.height
                    Layout.preferredWidth: parent.width / 2
                    ColumnLayout{
                        anchors.fill: parent
                        spacing: 0

                        //-- Volume --//
                        Label{
                            id: lbl_Volume
                            Layout.topMargin: -10
                            text: "Volume 7"
                            font.family: segoeUI.name
                            font.pixelSize: Qt.application.font.pixelSize * 3.5  * (widthRatio + ((1 - widthRatio) / 2))
                            font.bold: true
                            color: "#408ecc"
                            lineHeight: 0.9
                        }

                        //-- CAMBRIDGE TESTS --//
                        Label{
                            id:lbl_CambridgeTest
                            text: "CAMBRIDGE TESTS"
                            font.family: segoeUI.name
                            font.pixelSize: Qt.application.font.pixelSize * 2  * (widthRatio + ((1 - widthRatio) / 2))
                            font.weight: Font.DemiBold
                            color: "#8c8c8c"
                            //lineHeight: 0.9
                        }

                        //-- Published on --//
                        Label{
                            id: lbl_PublishedOn
                            text: " Published on: 15 Nov 2018"
                            font.family: segoeUI.name
                            font.pixelSize: Qt.application.font.pixelSize * 0.9  * (widthRatio + ((1 - widthRatio) / 2))
                            font.weight: Font.DemiBold
                            color: "#00adb3"
                        }

                        //-- Filler --//
                        Item {
                            Layout.fillHeight: true
                        }
                    }
                }


                //-- Filler --//
                Item {
                    Layout.fillWidth: true
                }
            }
        }

        //-- Center Separator and Label of "شماره آزمون خود را ..." --//
        Rectangle{
            Layout.fillWidth: true
            Layout.preferredHeight: 30 * ratio
            color: "transparent"

            //-- Line --//
            Rectangle{
                width: parent.width
                height: 2 * ratio
                anchors.centerIn: parent
                color: "#00adb3"
            }

            //-- Label of "شماره آزمون خود زا ..." --//
            Label{
                width: implicitWidth + (20 * ratio * widthRatio)
                height: implicitHeight
                anchors.centerIn: parent
                horizontalAlignment: Qt.AlignHCenter

                text: "شماره آزمون مورد نظر خود را انتخاب نمایید"
                font.family: iranSansMedium.name
                font.pixelSize: (Qt.application.font.pixelSize * 1.4) * (widthRatio + ((1 - widthRatio) / 2))
                color: "#757575"

                background: Rectangle{

                    //-- Right Label Line --//
                    Rectangle{
                        width: 2 * ratio
                        height: parent.height
                        anchors.right: parent.right
                        color: "#00adb3"
                    }
                    //-- Left Label Line --//
                    Rectangle{
                        width: 2 * ratio
                        height: parent.height
                        anchors.left: parent.left
                        color: "#00adb3"
                    }
                }

            }
        }

        //-- Tests Section --//
        Rectangle{
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "transparent"

            Row{
                //width: parent.width - (35  * widthRatio)
                anchors.centerIn: parent
                spacing: 35  * widthRatio

                //-- Practice Test 1 --//
                PracticeTest{
                    headerTitle: "Practice Test 1"

                    //-- Reading Take Test Click --//
                    onR_TakeTest_Clicked: {
                        console.log("Reading Take Test on " + headerTitle)
                        sView.push(Enum._PAGE_ReadingTest)
                    }

                    //-- Reading Solution Click --//
                    onR_Solution_Clicked: {
                        console.log("Reading Solution on " + headerTitle)
                    }

                    //-- Listening Take Test Click --//
                    onL_TakeTest_Clicked: {
                        console.log("Listening Take Test on " + headerTitle)
                    }

                    //-- Listening Solution Click --//
                    onL_Solution_Clicked: {
                        console.log("Listening Solution on " + headerTitle)
                    }
                }

                //-- Practice Test 2 --//
                PracticeTest{
                    headerTitle: "Practice Test 2"

                    //-- Reading Take Test Click --//
                    onR_TakeTest_Clicked: {
                        console.log("Reading Take Test on " + headerTitle)
                    }

                    //-- Reading Solution Click --//
                    onR_Solution_Clicked: {
                        console.log("Reading Solution on " + headerTitle)
                    }

                    //-- Listening Take Test Click --//
                    onL_TakeTest_Clicked: {
                        console.log("Listening Take Test on " + headerTitle)
                    }

                    //-- Listening Solution Click --//
                    onL_Solution_Clicked: {
                        console.log("Listening Solution on " + headerTitle)
                    }
                }

                //-- Practice Test 3 --//
                PracticeTest{
                    headerTitle: "Practice Test 3"

                    //-- Reading Take Test Click --//
                    onR_TakeTest_Clicked: {
                        console.log("Reading Take Test on " + headerTitle)
                    }

                    //-- Reading Solution Click --//
                    onR_Solution_Clicked: {
                        console.log("Reading Solution on " + headerTitle)
                    }

                    //-- Listening Take Test Click --//
                    onL_TakeTest_Clicked: {
                        console.log("Listening Take Test on " + headerTitle)
                    }

                    //-- Listening Solution Click --//
                    onL_Solution_Clicked: {
                        console.log("Listening Solution on " + headerTitle)
                    }
                }

                //-- Practice Test 4 --//
                PracticeTest{
                    headerTitle: "Practice Test 4"

                    //-- Reading Take Test Click --//
                    onR_TakeTest_Clicked: {
                        console.log("Reading Take Test on " + headerTitle)
                    }

                    //-- Reading Solution Click --//
                    onR_Solution_Clicked: {
                        console.log("Reading Solution on " + headerTitle)
                    }

                    //-- Listening Take Test Click --//
                    onL_TakeTest_Clicked: {
                        console.log("Listening Take Test on " + headerTitle)
                    }

                    //-- Listening Solution Click --//
                    onL_Solution_Clicked: {
                        console.log("Listening Solution on " + headerTitle)
                    }
                }

            }


        }


    }



}
