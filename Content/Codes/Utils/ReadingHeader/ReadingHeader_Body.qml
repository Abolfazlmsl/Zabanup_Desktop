import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import QtQuick.Dialogs 1.3

import "./../../../Fonts/Icon.js" as Icons

import "./../../Modules"
import "./../../Pages/Test"



Rectangle{

    property alias fontResize: fontSizeSlider.value
    property color highlightColor
    property alias highlightDialog: colorDialogHighlight

    property bool isMainTest: true  // for mainTest(3 passages) and passageTest (1 passage)

    signal changeFontSize(var size)
    signal click_Eraser
    signal click_FontColor
    signal click_Share
    signal click_Exit


    width: parent.width
    height: 50 * ratio


    color: "transparent"

    //-- down Animation --//
    ParallelAnimation{
        id: downHeader
        PropertyAnimation { target: readingTest_Header ; properties: "height"; to: 200 * ratio ; duration: 500 }
        PropertyAnimation { target: lbl_ShowInfoTestIcon ; properties: "rotation"; to: 180; duration: 500 }
    }

    //-- Up Animation --//
    ParallelAnimation{
        id: upHeader
        PropertyAnimation { target: readingTest_Header ; properties: "height"; to: 60 * ratio ; duration: 500 }
        PropertyAnimation { target: lbl_ShowInfoTestIcon ; properties: "rotation"; to: 0; duration: 500 }
    }

    //-- Body --//
    ColumnLayout{
        anchors.fill: parent
        spacing: 0

        //-- Top Section (Buttons) --//
        Rectangle{
            Layout.fillWidth: true
            Layout.preferredHeight: 60 * ratio

            //-- "Show Info of Test" Button--//
            Rectangle{
                id: showTestInfo
                visible: isMainTest

                width: lbl_ShowInfoTest.implicitWidth + lbl_ShowInfoTestIcon.width + (20 * ratio)
                height: parent.height
                color: "#ffffff"


                Label{
                    id: lbl_ShowInfoTest
                    text: "نمایش اطلاعات آزمون"
                    anchors.right: parent.right
                    anchors.rightMargin: 10 * ratio
                    anchors.verticalCenter: parent.verticalCenter
                }

                Label{
                    id: lbl_ShowInfoTestIcon
                    width: implicitWidth + (10 * ratio)
                    height: parent.height

                    verticalAlignment: Qt.AlignVCenter
                    horizontalAlignment: Qt.AlignHCenter

                    text: Icons.chevron_down
                    font.family: webfont.name
                    font.pixelSize: Qt.application.font.pixelSize * 2
                    anchors.right: lbl_ShowInfoTest.left

                }

                ItemDelegate{
                    anchors.fill: parent

                    property bool expand: false

                    onClicked: {
                        if(expand === false){
                            downHeader.restart()
                            expand = !expand
                        }
                        else {
                            upHeader.restart()
                            expand = !expand
                        }
                    }
                }
            }

            //-- Header Test Buttons --//
            RowLayout{
                width: parent.width
                height: parent.height
                spacing: 0

                //-- Filler --//
                Item {
                    Layout.fillWidth: true
                }

                //-- Share Button --//
                ReadingHeader_Buttons{
                    id: btnShare
                    Layout.fillHeight: true
                    Layout.preferredWidth: height

                    icon: Icons.share_variant

                    onBtnClick: {
                        console.log("Share")

                        click_Share()
                    }
                }

                //-- problem Report Button --//
                ReadingHeader_Buttons{
                    id: btnProblemReport
                    Layout.fillHeight: true
                    Layout.preferredWidth: height

                    icon: Icons.alert_outline

                    onBtnClick: {
                        console.log("Problem Report")
                        problemReport.open()
                    }
                }

                //-- Erase Highlight Button --//
                ReadingHeader_Buttons{
                    id: btnEraser
                    Layout.fillHeight: true
                    Layout.preferredWidth: height

                    icon: Icons.eraser

                    onBtnClick: {
                        console.log("Erase Highlight Button")

                        click_Eraser()
                    }
                }

                //-- Change font Size Button --//
                ReadingHeader_Buttons{
                    id: btnChangeFontSize
                    Layout.fillHeight: true
                    Layout.preferredWidth: height

                    icon: Icons.format_size

                    onBtnClick: {
                        console.log("Font Size")
                        slider_ChangeFontSize.visible = !slider_ChangeFontSize.visible
                    }
                }

                //-- Change Highlight Button --//
                ReadingHeader_Buttons{
                    id: btnSetTextHighlight
                    Layout.fillHeight: true
                    Layout.preferredWidth: height

                    icon: Icons.format_color_highlight

                    onBtnClick: {
                        console.log("Highlight")
                        colorDialogHighlight.open()
                    }
                }

                //-- Exit Button --//
                ReadingHeader_Buttons{
                    id: btnExit
                    Layout.fillHeight: true
                    Layout.preferredWidth: height

                    icon: Icons.exit_to_app

                    onBtnClick: {
                        console.log("Exit")
                    }
                }

                //-- Filler --//
                Item {
                    Layout.fillWidth: true
                }


            }

            //-- Line --//
            Rectangle{
                width: parent.width
                height: 1
                color: "#eeeeee"
                anchors.bottom: parent.bottom
            }

        }

        //-- info Section --//
        Rectangle{

            visible: isMainTest

            clip: true
            Layout.preferredWidth: 500
            Layout.fillHeight: true

            color: "transparent"

            RowLayout{
                anchors.fill: parent
                spacing: 0
//                anchors.leftMargin: 10 * ratio
                anchors.rightMargin: 10 * ratio

                Rectangle{
                    Layout.preferredWidth: 100 * ratio
                    Layout.preferredHeight:  parent.height

                    //-- Book Image --//
                    Image {
                        id: img_testInfo

                        width: parent.width
                        height: parent.height - (20 * ratio)
                        anchors.centerIn: parent
                        fillMode: Image.PreserveAspectFit

                        source: "qrc:/Content/Images/SelectTest_Image/book_7.png"


                    }
                }



                //-- Title and Rating --//
                Rectangle{
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    ColumnLayout{
                        anchors.fill: parent
                        spacing: 0

                        //-- IELTS Title --//
                        Label{
//                            visible: false
                            Layout.preferredWidth: implicitWidth
                            Layout.preferredHeight: parent.height / 2
                            Layout.leftMargin: 20 * ratio
                            verticalAlignment: Qt.AlignVCenter
                            text: "IELTS Exam Test"
                            font.family: segoeUI.name
                            font.pixelSize: Qt.application.font.pixelSize * 1.2
//                            font.bold: true
                            color: "#000000"

                        }

                        //-- Rating --//
                        Rating{
                            Layout.fillWidth: true
                            Layout.fillHeight: true

                            selectable: false
                        }
                    }
                }
            }



        }


    }




    //-- Highlight ColorDialog --//
    ColorDialog{
        id: colorDialogHighlight
        title: "Please choose a color : "
        color: "#ffff00"
        onAccepted: {
            click_FontColor()
        }
        onRejected: {
            console.log("Canceled")
        }
    }

    //-- Slider of change font --//
    Rectangle{
        id: slider_ChangeFontSize
        width: 200
        height: 50

        visible: false

        //        color: "#80ff0000"

        x: btnChangeFontSize.x - (width/2) + (btnChangeFontSize.width/2)
        y: btnChangeFontSize.height



        MouseArea{
            anchors.fill: parent
            propagateComposedEvents: true
            hoverEnabled: true
            onExited: {
                log("EXITED !!!!")
                slider_ChangeFontSize.visible = !slider_ChangeFontSize.visible
            }

            Slider{
                id: fontSizeSlider
                width: parent.width
                height: parent.height
                visible: true
                from: -4
                value: -2
                to: 8

                stepSize: 2.0
                snapMode: Slider.NoSnap

                onPositionChanged: {
                    console.log(value)
                    changeFontSize((value+4)/12)

                }
            }
        }







    }

}

