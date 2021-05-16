import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Window 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

import "./../../../Fonts/Icon.js" as Icons
import "./../../Utils/Enum.js" as Enum
import "./../../Utils/Utils.js" as Util
import "./../../REST/apiService.js" as Service

Item {

    id: rootDashboard

    objectName: "Dashboard"

    signal loadSelectTestPage
    property bool isLoadedImages : false

    property real dashboard_ShadowPracticeSpread: 0.0
    property real dashboard_ShadowPracticeRadius: 9

    property real dashboard_ShadowLearnSpread: 0.0
    property real dashboard_ShadowLearnRadius: 9

    property real dashboard_ShadowActivitiesSpread: 0.0
    property real dashboard_ShadowActivitiesRadius: 9

    property real dashboard_ShadowHelpSpread: 0.0
    property real dashboard_ShadowHelpRadius: 9


    Page{
        anchors.fill: parent

        //-- Begin Rect (top Rect) --//
        Rectangle{
            id:dashboard_TopRect

            width: parent.width
            height: parent.height * 0.55

            color: "#ffffff"

            //-- Begin Rect Items --//
            ColumnLayout{
                anchors.fill: parent
                spacing: 18 * heightRatio

                //-- Filler --//
                Item { Layout.fillHeight: true }

                //-- Label of Begin Button (in Top of Button) --//
                Label{
                    Layout.preferredWidth: implicitWidth
                    Layout.preferredHeight: implicitHeight

                    Layout.alignment: Qt.AlignHCenter

                    text: "جهت ورود به مرحله آزمون کلیک نمایید"
                    font.family: iranSans.name
                    font.pixelSize: Qt.application.font.pixelSize * 2 * widthRatio

                    color: Util.color_RightMenu
                }

                //-- Button of Begin --//
                Rectangle{
                    id:dashboard_btnBegin

                    Layout.preferredWidth: ( lbl_start.implicitWidth + lbl_play.implicitWidth) * 1.8
                    Layout.preferredHeight: 45 * ratio * heightRatio

                    Layout.alignment: Qt.AlignHCenter

                    radius: 6 * ratio * widthRatio

                    color: "#009ffa"

                    RowLayout{
                        anchors.fill: parent
                        spacing: 10 * ratio * widthRatio
                        layoutDirection: Qt.RightToLeft

                        //-- Filler --//
                        Item {
                            Layout.fillWidth: true
                        }

                        //-- Label of "شروع" on Begin Button --//
                        Label{
                            id: lbl_start
                            Layout.preferredWidth: implicitWidth
                            Layout.fillHeight: true

                            verticalAlignment: Qt.AlignVCenter

                            text: "شروع"
                            font.family: iranSans.name
                            font.pixelSize: Qt.application.font.pixelSize * 2 * widthRatio
                            font.bold: true

                            color: Util.color_white
                        }

                        //-- Play Icon on Begin Button --//
                        Label{
                            id: lbl_play

                            Layout.preferredWidth: height / 6 * 5  // 75%
                            Layout.fillHeight: true

                            verticalAlignment: Qt.AlignVCenter

                            text: Icons.play_circle_outline
                            font.family: webfont.name
                            font.pixelSize: Qt.application.font.pixelSize * 2
                            minimumPixelSize: 10
                            fontSizeMode: Text.Fit

                            color: Util.color_white

                        }

                        //-- Filler --//
                        Item {
                            Layout.fillWidth: true
                        }

                    }


                    ItemDelegate{
                        anchors.fill: parent
                        onClicked: {

                            for(var i=0 ; i< model_Books.count ; i++) {model_Books.setProperty(i , "isSelected" , false);}
                            for(var j=0 ; j< model_FilterTopic.count ; j++) {model_FilterTopic.setProperty(j , "isSelected" , false);}
                            for(var k=0 ; k< model_FilterTypeofQuestion.count ; k++) {model_FilterTypeofQuestion.setProperty(k , "isSelected" , false);}
                            for(var l=0 ; l< model_FilterTypeofText.count ; l++) {model_FilterTypeofText.setProperty(l , "isSelected" , false);}


                            sView.push(Enum._PAGE_SelectTest)
                        }
                    }
                }

                //-- Filler --//
                Item {
                    Layout.fillHeight: true
                }
            }

        }

        //-- Items Rect (bottom Rect) --//
        Rectangle{
            id:dashboard_BottomRect
            width: parent.width
            height: parent.height * 0.45

            anchors.top: dashboard_TopRect.bottom

            color: "#e9eaea"

            RowLayout{
                anchors.fill: parent
                spacing: 30 * widthRatio
                layoutDirection: Qt.RightToLeft

                //-- Filler --//
                Item {
                    Layout.fillWidth: true
                }
                //-- Practice Square --//
                DashboardButton{
                    Layout.preferredWidth: 280 * widthRatio
                    Layout.preferredHeight: width

                    picSource: "qrc:/Content/Images/Dashborad_Image/Book.png"
                    title: "تمرین"
                    bgColor: "#6c88b7"

                    onDashboard_btnClicked: {
                        console.log(title)
                        mainPage.state = _BTN_PRACTICE
                        sView.push(Enum._PAGE_Practice)
                    }
                }

                //-- Learn Square --//
                DashboardButton{
                    Layout.preferredWidth: 280 * widthRatio
                    Layout.preferredHeight: width

                    picSource: "qrc:/Content/Images/Dashborad_Image/Hat.png"
                    title: "آموزش"
                    bgColor: "#2384b6"

                    onDashboard_btnClicked: {
                        console.log(title)
                        mainPage.state = _BTN_LEARN
                        sView.push(Enum._PAGE_Learn)
                    }
                }

                //-- Activities Square --//
                DashboardButton{
                    Layout.preferredWidth: 280 * widthRatio
                    Layout.preferredHeight: width

                    picSource: "qrc:/Content/Images/Dashborad_Image/Activity.png"
                    title: "فعالیت ها"
                    bgColor: "#1584a7"

                    onDashboard_btnClicked: {
                        console.log(title)
                        //mainPage.state = _BTN_ACTIVITY
                        sView.push(Enum._PAGE_Activity)
                    }
                }

                //-- Help Square --//
                DashboardButton{
                    Layout.preferredWidth: 280 * widthRatio
                    Layout.preferredHeight: width

                    picSource: "qrc:/Content/Images/Dashborad_Image/ZabanUp.png"
                    title: "راهنمای نرم افزار"
                    bgColor: "#00adb3"

                    onDashboard_btnClicked: {
                        console.log(title)
                        mainPage.state = _BTN_HELP
                        sView.push(Enum._PAGE_Help)
                    }
                }


                //-- Filler --//
                Item {
                    Layout.fillWidth: true
                }

            }

        }

    }
}
