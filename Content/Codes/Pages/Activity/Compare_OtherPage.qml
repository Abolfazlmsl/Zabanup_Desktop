import QtQuick 2.12
import QtQuick.Controls 2.14
import QtQuick.Window 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import QtCharts 2.14

import "./../../../Fonts/Icon.js" as Icons
import "./../../Utils/"
import "./../../Utils/Utils.js" as Util
import "./../ListModels"
import "./../../Modules"
import "./../../Modules/SideFilterItems"
import "./../Activity/Models"

Item {

    ActivityFilter_ListModel{id: model_Filter}
    PresonalReport_Model{id: pReport_Model}


    //-- Left Filter Section --//
    Rectangle{
        id: leftSecton
        height: parent.height
        width: (root.width < 1200) ? parent.width * 0.3 : (root.width > 1600) ? parent.width * 0.2 :  parent.width * 0.25

        anchors.top: parent.top
        anchors.topMargin: 3 * ratio
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 3 * ratio
        anchors.left: parent.left
        anchors.leftMargin: 5 * ratio
        color: "transparent"

        //-- left Filter --//
        Rectangle{
            id: root_Filter

            width: parent.width - (16 * ratio)
            height: parent.height - (16 * ratio)
            anchors.centerIn: parent

            radius: 10 * ratio

            border.color: "#5d5d5d"
            border.width: 2
            clip: true

            //-- header --//
            Rectangle{
                id: header_Filter

                width: parent.width - (10 * ratio)
                height: 35 * ratio

                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 5 * ratio

                color: "#444444"
                radius: 5 * ratio

                //-- Text --//
                Label{
                    id:title_Filter
                    text: "فیلتر"
                    anchors.centerIn: parent
                    font.family: iranSans.name
                    font.pixelSize: Qt.application.font.pixelSize * 0.9
                    color: "#ffffff"
                }

            }

            //-- body of Date--//
            Rectangle{
                id: body_FilterDate

                //-- for get count of "Date" Type in Filter Model --//
                property real dateFilter_Count: {
                    var counter = 0;
                    for(var i=0; i<model_Filter.count; i++){
                        if(model_Filter.get(i).type === "Date"){
                            counter++;
                        }
                    }
                    log("Count Date Filter on Model : " + counter)
                    return counter;
                }

                //-- for get count of None "Date" Type in Filter Model --//
                property real noneDateFilter_Count: {
                    var counter = 0;
                    for(var i=0; i<model_Filter.count; i++){
                        if(model_Filter.get(i).type !== "Date"){
                            counter++;
                        }
                    }
                    log("Count Date Filter on Model : " + counter)
                    return counter;
                }


                Rectangle{
                    anchors.fill: parent

                    border.color: "#444444"
                    border.width: 2
                    radius: 8 * ratio
                }

                visible: true

                width: parent.width - (10 * ratio)
                height: (body_FilterDate.dateFilter_Count * (35 * ratio)) +
                        ((body_FilterDate.dateFilter_Count - 1) * lst_FilterDate.spacing) +
                        (lst_FilterDate.topMargin + lst_FilterDate.bottomMargin) /*+
                        (body_FilterDate.noneDateFilter_Count * lst_FilterDate.spacing)*/
                anchors.top: header_Filter.bottom
                anchors.topMargin: 5 * ratio
                anchors.horizontalCenter: parent.horizontalCenter

                color: "#e5e5e5"
                //                            radius: 5 * ratio
                clip: true

                ListView{
                    id: lst_FilterDate

                    anchors.fill: parent
                    topMargin: 14 * ratio
                    bottomMargin: 14 * ratio
                    clip: true
                    spacing: 4 * ratio

                    boundsBehavior: Flickable.StopAtBounds

                    ScrollBar.vertical: ScrollBar {
                        width: 10 * ratio
                        policy: ScrollBar.AsNeeded
                        parent: lst_FilterDate.parent
                        anchors.top: lst_FilterDate.top
                        anchors.left: lst_FilterDate.left
                        anchors.bottom: lst_FilterDate.bottom
                    }

                    model: model_Filter

                    delegate: FiltersButton{

                        width: parent.width - (16 * ratio) // (LeftMargin + rightMargin) - Left and Right Border
                        height: (model.type === "Date") ? 35 * ratio : -4 * ratio

                        visible: (model.type === "Date") ? true : false
                        anchors.horizontalCenter: parent.horizontalCenter
                        subjText: model.name

                        btnColor: (isSelected) ? "#00b300" : "#ffffff"
                        lblColor: (isSelected) ? "#ffffff" : "#444444"

                        onClickSubjectFilter: {

                            for(var i=0; model_Filter.count > i; i++){
                                if(model_Filter.get(i).type === "Date"){
                                    model_Filter.setProperty(i, 'isSelected', false)
                                }
                            }

                            model_Filter.setProperty(index, 'isSelected', true)

                        }
                    }
                }

            }

        }

    }



    //-- Right Section (All Parts Without Filter Section) --//
    Rectangle{
        height: parent.height - (16 * ratio) - (5 * ratio) // 5 * ratio => spacing
        width: parent.width - leftSecton.width  - (16 * ratio)

        anchors.left: leftSecton.right
        anchors.top: parent.top
        anchors.topMargin: 3 * ratio
        anchors.rightMargin: 10 * ratio

        ColumnLayout{
            anchors.fill: parent
            spacing: 5 * ratio

            //-- Test Info --//
            Rectangle{
                Layout.fillWidth: true
                Layout.fillHeight: true

                Rectangle{
                    id: root_TestList

                    width: parent.width - (16 * ratio)
                    height: parent.height - (16 * ratio)
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter

                    radius: 10 * ratio

                    border.color: "#5d5d5d"
                    border.width: 2
                    clip: true

                    //-- header --//
                    Rectangle{
                        id: header_TestList

                        width: parent.width - (10 * ratio)
                        height: 35 * ratio

                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                        anchors.topMargin: 5 * ratio

                        color: "#0089e5"
                        radius: 5 * ratio

                        //-- Text --//
                        Label{
                            id:title_TestList
                            text: "لیست آزمون ها"
                            anchors.centerIn: parent
                            font.family: iranSans.name
                            font.pixelSize: Qt.application.font.pixelSize * 0.9
                            color: "#ffffff"
                        }

                    }

                    //-- body of Test List--//
                    Rectangle{
                        id: body_TestList


                        width: parent.width - (10 * ratio)
                        height: parent.height - header_TestList.height - 20


                        anchors.top: header_TestList.bottom
                        anchors.topMargin: 5 * ratio
                        anchors.horizontalCenter: parent.horizontalCenter

                        color: "#ffffff"//"#e5e5e5"
                        //                            radius: 5 * ratio
                        clip: true

                        ListView{
                            id: lst_TestList

                            anchors.fill: parent
                            topMargin: (header_TestList.height + 5) * ratio
                            bottomMargin: 4 * ratio
                            clip: true
                            spacing: 4 * ratio

                            //-- List Headers --//
                            Rectangle{
                                id: listHeaders
                                z: 2
                                width: parent.width
                                height: header_TestList.height

//                                color: "#55ff0000"

                                RowLayout{
                                    anchors.fill: parent
                                    spacing: 0
                                    layoutDirection: Qt.RightToLeft

                                    //-- Test Name --//
                                    Rectangle{
                                        Layout.fillWidth: true
                                        Layout.fillHeight: true
                                        color: "transparent"

                                        //-- Test Name Label --//
                                        Label{
                                            text: "نام آزمون"
                                            anchors.centerIn: parent
                                            font.family: iranSans.name
                                            font.pixelSize: Qt.application.font.pixelSize * 0.9
                                            color: "#000000"
                                            clip: true
                                        }
                                    }

                                    //-- Separator --//
                                    Rectangle{
                                        Layout.preferredWidth: 1
                                        Layout.preferredHeight: parent.height * 0.7
                                        Layout.alignment: Qt.AlignVCenter
                                        color: "#444444"
                                    }

                                    //-- Date --//
                                    Rectangle{
                                        Layout.fillWidth: true
                                        Layout.fillHeight: true
                                        color: "transparent"

                                        //-- Date Label --//
                                        Label{
                                            text: "تاریخ"
                                            anchors.centerIn: parent
                                            font.family: iranSans.name
                                            font.pixelSize: Qt.application.font.pixelSize * 0.9
                                            color: "#000000"
                                            clip: true
                                        }
                                    }

                                    //-- Separator --//
                                    Rectangle{
                                        Layout.preferredWidth: 1
                                        Layout.preferredHeight: parent.height * 0.7
                                        Layout.alignment: Qt.AlignVCenter
                                        color: "#444444"
                                    }

                                    //-- Garde --//
                                    Rectangle{
                                        Layout.fillWidth: true
                                        Layout.fillHeight: true
                                        color: "transparent"

                                        //-- Grade Label --//
                                        Label{
                                            text: "نمره"
                                            anchors.centerIn: parent
                                            font.family: iranSans.name
                                            font.pixelSize: Qt.application.font.pixelSize * 0.9
                                            color: "#000000"
                                            clip: true
                                        }
                                    }

                                    //-- Separator --//
                                    Rectangle{
                                        Layout.preferredWidth: 1
                                        Layout.preferredHeight: parent.height * 0.7
                                        Layout.alignment: Qt.AlignVCenter
                                        color: "#444444"
                                    }

                                    //-- Compare with Other Tests --//
                                    Rectangle{
                                        Layout.fillWidth: true
                                        Layout.fillHeight: true
                                        color: "transparent"

                                        //-- Compare with Other Label --//
                                        Label{
                                            width: parent.width - 4
                                            height: parent.height - 4

                                            elide: Text.ElideRight
                                            verticalAlignment: Qt.AlignVCenter
                                            horizontalAlignment: Qt.AlignHCenter

                                            text: "مقایسه ی آزمون"
                                            anchors.centerIn: parent
                                            font.family: iranSans.name
                                            font.pixelSize: Qt.application.font.pixelSize * 0.9
                                            color: "#000000"
                                            clip: true
                                        }
                                    }

                                    //-- Separator --//
                                    Rectangle{
                                        Layout.preferredWidth: 1
                                        Layout.preferredHeight: parent.height * 0.7
                                        Layout.alignment: Qt.AlignVCenter
                                        color: "#444444"
                                    }

                                    //-- Traning --//
                                    Rectangle{
                                        Layout.fillWidth: true
                                        Layout.fillHeight: true
                                        color: "transparent"

                                        //-- Traning Label --//
                                        Label{
                                            text: "تمرین"
                                            anchors.centerIn: parent
                                            font.family: iranSans.name
                                            font.pixelSize: Qt.application.font.pixelSize * 0.9
                                            color: "#000000"
                                            clip: true
                                        }
                                    }

                                    //-- Separator --//
                                    Rectangle{
                                        Layout.preferredWidth: 1
                                        Layout.preferredHeight: parent.height * 0.7
                                        Layout.alignment: Qt.AlignVCenter
                                        color: "#444444"
                                    }

                                    //-- Learn --//
                                    Rectangle{
                                        Layout.fillWidth: true
                                        Layout.fillHeight: true
                                        color: "transparent"

                                        //-- Learn Label --//
                                        Label{
                                            text: "آموزش"
                                            anchors.centerIn: parent
                                            font.family: iranSans.name
                                            font.pixelSize: Qt.application.font.pixelSize * 0.9
                                            color: "#000000"
                                            clip: true
                                        }
                                    }

                                }

                            }

                            //-- Shadow under Headers --//
                            DropShadow {
                                anchors.fill: listHeaders
                                horizontalOffset: 0
                                verticalOffset: 3
                                radius: 6.0
                                samples: 17
                                color: "#30000000"
                                source: listHeaders
                            }

//                            boundsBehavior: Flickable.StopAtBounds

                            /*ScrollBar.vertical: ScrollBar {
                                width: 10 * ratio
                                policy: ScrollBar.AsNeeded
                                parent: lst_FilterDate.parent
                                anchors.top: lst_FilterDate.top
                                anchors.left: lst_FilterDate.left
                                anchors.bottom: lst_FilterDate.bottom
                            }*/

                            model: pReport_Model

                            delegate: Rectangle{
                                width: parent.width
                                height: 34

//                                color: "#55ff0000"

                                RowLayout{
                                    anchors.fill: parent
                                    spacing: 1
                                    layoutDirection: Qt.RightToLeft

                                    //-- Test Name --//
                                    Rectangle{
                                        Layout.fillWidth: true
                                        Layout.fillHeight: true
                                        color: "transparent"

                                        //-- Test Name Label --//
                                        Label{
                                            text: model.testName//"نام آزمون"
                                            anchors.centerIn: parent
                                            font.family: iranSans.name
                                            font.pixelSize: Qt.application.font.pixelSize * 0.9
                                            color: "#000000"
                                            clip: true
                                        }
                                    }


                                    //-- Date --//
                                    Rectangle{
                                        Layout.fillWidth: true
                                        Layout.fillHeight: true
                                        color: "transparent"

                                        //-- Date Label --//
                                        Label{
                                            text: model.testDate//"تاریخ"
                                            anchors.centerIn: parent
                                            font.family: iranSans.name
                                            font.pixelSize: Qt.application.font.pixelSize * 0.9
                                            color: "#000000"
                                            clip: true
                                        }
                                    }


                                    //-- Garde --//
                                    Rectangle{
                                        Layout.fillWidth: true
                                        Layout.fillHeight: true
                                        color: "transparent"

                                        //-- Grade Label --//
                                        Label{
                                            text: model.testGrade//"نمره"
                                            anchors.centerIn: parent
                                            font.family: iranSans.name
                                            font.pixelSize: Qt.application.font.pixelSize * 0.9
                                            color: "#000000"
                                            clip: true
                                        }
                                    }


                                    //-- Compare with Other Tests --//
                                    Rectangle{
                                        Layout.fillWidth: true
                                        Layout.fillHeight: true
                                        color: "transparent"

                                        //-- Compare with Other Label --//
                                        Label{
                                            width: parent.width - 4
                                            height: parent.height - 4

                                            elide: Text.ElideRight
                                            verticalAlignment: Qt.AlignVCenter
                                            horizontalAlignment: Qt.AlignHCenter

                                            text: model.compare//"مقایسه ی آزمون"
                                            anchors.centerIn: parent
                                            font.family: iranSans.name
                                            font.pixelSize: Qt.application.font.pixelSize * 0.9
                                            color: "#000000"
                                            clip: true
                                        }
                                    }


                                    //-- Traning --//
                                    Rectangle{
                                        Layout.fillWidth: true
                                        Layout.fillHeight: true
                                        color: "transparent"

                                        //-- Traning Label --//
                                        Label{
                                            text: model.traning//"لینک"
                                            anchors.centerIn: parent
                                            font.family: iranSans.name
                                            font.pixelSize: Qt.application.font.pixelSize * 0.9
                                            color: "#000000"
                                            clip: true
                                        }
                                    }


                                    //-- Learn --//
                                    Rectangle{
                                        Layout.fillWidth: true
                                        Layout.fillHeight: true
                                        color: "transparent"

                                        //-- Learn Label --//
                                        Label{
                                            text: model.learn//"لینک"
                                            anchors.centerIn: parent
                                            font.family: iranSans.name
                                            font.pixelSize: Qt.application.font.pixelSize * 0.9
                                            color: "#000000"
                                            clip: true
                                        }
                                    }

                                }

                                Rectangle{
                                    width: parent.width
                                    height: 1
                                    color: "#444444"

                                    anchors.bottom: parent.bottom

                                    visible: ((index + 1) !== pReport_Model.count) ? true : false
                                }
                            }
                        }

                    }

                }

//                color: "#55ff0000"
            }

            //-- Chart Section --//
            Rectangle{
                Layout.preferredWidth: parent.width - (16 * ratio)
                Layout.preferredHeight: parent.height * 0.3
                Layout.alignment: Qt.AlignHCenter

                radius: 10 * ratio

                border.color: "#5d5d5d"
                border.width: 2
                clip: true

                ChartView {
//                    title: "Bar series"
                    anchors.fill: parent
                    legend.visible: false
                    antialiasing: true

                    BarSeries {
                        id: mySeries
                        axisX: BarCategoryAxis { categories: ["2007", "2008", "2009", "2010", "2011", "2012" ] }
                        BarSet { label: "Bob"; values: [2, 2, 3, 9, 5, 6]}
                    }
                }
            }

        }
    }
}








