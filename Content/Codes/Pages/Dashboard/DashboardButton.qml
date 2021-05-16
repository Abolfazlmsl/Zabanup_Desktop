import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Window 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

import "./../../../Fonts/Icon.js" as Icons


//-- Practice Square --//
Rectangle{

    property real btn_ShadowSpread: 0.0
    property real btn_ShadowRadius: 9

    property alias picSource: dashboard_img.source
    property alias title: lbl_Title.text
    property alias bgColor: innerRect.color

    signal dashboard_btnClicked

    width: 280 * widthRatio
    height: width

    radius: 20 * widthRatio

    color: "transparent"

    //-- Shadow of dashboard_btnPractice --//
    DropShadow {
        anchors.fill: dashboard_btn
        transparentBorder: true
        horizontalOffset: 0
        verticalOffset: 3
        spread: btn_ShadowSpread
        radius: btn_ShadowRadius
        samples: 14
        color: "#40000000"
        source: dashboard_btn
    }
    //-- Practice Square --//
    Rectangle{
        id: dashboard_btn

        width: parent.width
        height: width

        radius: 20 * widthRatio

        color: "transparent"

        //-- Added this for "Shadow" --//
        Rectangle{
            anchors.fill: parent
            radius: dashboard_btn.radius

            gradient: Gradient {
                GradientStop { position: 0.0; color: "#ffffff" }
                GradientStop { position: 1.0; color: "#e9eaea" }
            }

            //-- Shadow of innerRect --//
            DropShadow {
                anchors.fill: innerRect
                transparentBorder: true
                horizontalOffset: 0
                verticalOffset: 3
                spread: 0.0
                radius: 9
                samples: 14
                color: "#40000000"
                source: innerRect
            }

            //-- Inner Rect --//
            Rectangle{
                id: innerRect
                width: 249 * widthRatio
                height: width

                anchors.centerIn: parent

                radius: dashboard_btn.radius

                border.width: 1
                border.color: "#ffffff"

                color: "#6c88b7"

                //-- Inner Items (image , separator , Title) --//
                ColumnLayout{
                    anchors.fill: parent
                    spacing: 0

                    //-- Image Rect --//
                    Rectangle{

                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        color: "transparent"

                        radius: dashboard_btn.radius

                        Image {
                            id: dashboard_img
                            source: "qrc:/Content/Images/Dashborad_Image/Book.png"

                            sourceSize.width: parent.width * 0.8
//                            sourceSize.height: parent.height

                            anchors.centerIn: parent

                            fillMode: Image.PreserveAspectFit

                        }

                    }

                    //-- Separator --//
                    Rectangle{
                        Layout.fillWidth: true
                        Layout.preferredHeight: 1
                    }

                    //-- Bottom Title Rect --//
                    Rectangle{
                        Layout.fillWidth: true
                        Layout.preferredHeight: parent.height / 4  //-- 62 in 1080 or 249(Inner Rect) / 62 = 4 --//

                        color: "transparent"

                        radius: dashboard_btn.radius

                        //-- Title of Square --//
                        Label{
                            id:lbl_Title
                            anchors.centerIn: parent
                            text: "تمرین"
                            font.family: iranSans.name
                            font.pixelSize: 23 * widthRatio
                            font.bold: true

                            color: "#ffffff"

                        }





                    }

                }

            }

        }

        MouseArea{
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor

            onEntered: {
                btn_ShadowSpread = 0.5
                btn_ShadowRadius = 12
            }

            onExited: {
                btn_ShadowSpread = 0.0
                btn_ShadowRadius = 9
            }

            onClicked: {
                dashboard_btnClicked()
            }
        }


    }
}
