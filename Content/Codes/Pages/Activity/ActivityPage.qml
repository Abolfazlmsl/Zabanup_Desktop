import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Window 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import QtCharts 2.3

import "./../../../Fonts/Icon.js" as Icons
import "./../../Utils/"
import "./../../Utils/Utils.js" as Util

Item {
    objectName: "ActivityPage"

    property int view_Handler: view_Personal.currentIndex

    Rectangle{
        anchors.fill: parent
        color: "#ffffff"
    }

    Rectangle{
        id: bgcolorActivity
    }

    Rectangle{
        width: parent.width - (20 * ratio)
        height: parent.height - (20 * ratio)
        anchors.centerIn: parent

        border.color: "#034ea2"
        border.width: 2

        ColumnLayout{
            anchors.fill: parent
            spacing: 3 * ratio


            //-- Top Buttons ("Compare" and "Personal Report") --//
            Rectangle{
                Layout.preferredWidth: parent.width - 4
                Layout.preferredHeight: 70 * ratio

                Layout.leftMargin: 2
                Layout.topMargin: 2



                color: "transparent"

                //-- Compare Button --//
                Rectangle{
                    id: btn_compare_Other
                    width: parent.width / 2
                    height: parent.height

                    Rectangle{
                        width: 20
                        height: 20


                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: -6
                        anchors.horizontalCenter: parent.horizontalCenter
                        rotation: 45
                        color: "#034ea2"
                        visible:  (view_Handler === 0) ? true : false
                    }



                    color: (view_Handler === 0) ? "#034ea2" : "#0089e5"

                    Label{
                        text: "مقایسه با دیگران"
                        font.family: iranSans.name
                        font.pixelSize: Qt.application.font.pixelSize * 1.5
                        anchors.centerIn: parent
                        color: "#ffffff"
                    }

                    ItemDelegate{
                        anchors.fill: parent
                        visible: (view_Handler === 1) ? true : false
                        onClicked: {
                            log("مقایسه با دیگران")
                            view_Personal.currentIndex = 0
                        }
                    }

                }

                //-- Personal Report Button --//
                Rectangle{
                    id: btn_personal_Report
                    width: parent.width / 2
                    height: parent.height
                    anchors.right: parent.right

                    Rectangle{
                        width: 20
                        height: 20

                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: -6
                        anchors.horizontalCenter: parent.horizontalCenter
                        rotation: 45
                        color: "#034ea2"
                        visible:  (view_Handler === 1) ? true : false
                    }

                    color: (view_Handler === 1) ? "#034ea2" : "#0089e5"



                    Label{
                        text: "گزارش شخصی"
                        font.family: iranSans.name
                        font.pixelSize: Qt.application.font.pixelSize * 1.5
                        anchors.centerIn: parent
                        color: "#ffffff"
                    }

                    ItemDelegate{
                        anchors.fill: parent
                        visible:  (view_Handler === 0) ? true : false
                        onClicked: {
                            log("گزارش شخصی")
                            view_Personal.currentIndex = 1
                        }
                    }

                }

            }

            //-- Body --//
            Rectangle{
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.topMargin: 5

                SwipeView {
                    id: view_Personal

                    currentIndex: 1
                    anchors.fill: parent
                    interactive: false


                    //-- Compare Page --//
                    Compare_OtherPage {
                        id: compare_Page
                        Label{
                            visible: false
                            anchors.centerIn: parent
                            text: "مقایسه با دیگران"
                        }
                    }

                    //-- Personal_Report Page --//
                    Personal_ReportPage {
                        id: personalReport_Page
                        Label{
                            visible: false
                            anchors.centerIn: parent
                            text: "گزارش شخصی"
                        }
                    }
                }

                color: "transparent"
            }
        }

    }

}
