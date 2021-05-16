import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

import "./../../Fonts/Icon.js" as Icons

import "./../Pages/ListModels"

Item {

    property int selectedRate: 0
    property bool selectable: true

    Rectangle{
        width: parent.width
        height: 2
        color: "#dddddd"
        anchors.top: parent.top

        visible: selectable
    }

    RowLayout{
        anchors.fill: parent
        spacing: 0

        Item {
            Layout.fillWidth: true
            visible: selectable
        }

        //-- 1 star --//
        Label{
            id: star1
            Layout.preferredWidth: implicitWidth
            Layout.preferredHeight: implicitHeight
            Layout.leftMargin: 20 * ratio
            Layout.alignment: Qt.AlignVCenter
            text: Icons.star_outline
            font.family: webfont.name
            font.pixelSize: Qt.application.font.pixelSize * 1.8
            color: "#1777c4"

            MouseArea{
                anchors.fill: parent
                cursorShape: (selectable) ? Qt.PointingHandCursor : Qt.ArrowCursor

                enabled: selectable

                onClicked: {
                    star1.text = Icons.star
                    star2.text = Icons.star_outline
                    star3.text = Icons.star_outline
                    star4.text = Icons.star_outline
                    star5.text = Icons.star_outline
                    selectedRate = 1
                }
            }

        }

        //-- 2 star --//
        Label{
            id: star2
            Layout.preferredWidth: implicitWidth
            Layout.preferredHeight: implicitHeight
            Layout.alignment: Qt.AlignVCenter
            text: Icons.star_outline
            font.family: webfont.name
            font.pixelSize: Qt.application.font.pixelSize * 1.8
            color: "#1777c4"

            MouseArea{
                anchors.fill: parent
                cursorShape: (selectable) ? Qt.PointingHandCursor : Qt.ArrowCursor

                 enabled: selectable

                onClicked: {
                    star1.text = Icons.star
                    star2.text = Icons.star
                    star3.text = Icons.star_outline
                    star4.text = Icons.star_outline
                    star5.text = Icons.star_outline
                    selectedRate = 2
                }
            }

        }

        //-- 3 star --//
        Label{
            id: star3
            Layout.preferredWidth: implicitWidth
            Layout.preferredHeight: implicitHeight
            Layout.alignment: Qt.AlignVCenter
            text: Icons.star_outline
            font.family: webfont.name
            font.pixelSize: Qt.application.font.pixelSize * 1.8
            color: "#1777c4"

            MouseArea{
                anchors.fill: parent
                cursorShape: (selectable) ? Qt.PointingHandCursor : Qt.ArrowCursor

                 enabled: selectable

                onClicked: {
                    star1.text = Icons.star
                    star2.text = Icons.star
                    star3.text = Icons.star
                    star4.text = Icons.star_outline
                    star5.text = Icons.star_outline
                    selectedRate = 3
                }
            }

        }

        //-- 4 star --//
        Label{
            id: star4
            Layout.preferredWidth: implicitWidth
            Layout.preferredHeight: implicitHeight
            Layout.alignment: Qt.AlignVCenter
            text: Icons.star_outline
            font.family: webfont.name
            font.pixelSize: Qt.application.font.pixelSize * 1.8
            color: "#1777c4"

            MouseArea{
                anchors.fill: parent
                cursorShape: (selectable) ? Qt.PointingHandCursor : Qt.ArrowCursor

                 enabled: selectable

                onClicked: {
                    star1.text = Icons.star
                    star2.text = Icons.star
                    star3.text = Icons.star
                    star4.text = Icons.star
                    star5.text = Icons.star_outline
                    selectedRate = 4
                }
            }

        }

        //-- 5 star --//
        Label{
            id: star5
            Layout.preferredWidth: implicitWidth
            Layout.preferredHeight: implicitHeight
            Layout.alignment: Qt.AlignVCenter
            text: Icons.star_outline
            font.family: webfont.name
            font.pixelSize: Qt.application.font.pixelSize * 1.8
            color: "#1777c4"

            MouseArea{
                anchors.fill: parent
                cursorShape: (selectable) ? Qt.PointingHandCursor : Qt.ArrowCursor

                 enabled: selectable

                onClicked: {

                    star1.text = Icons.star
                    star2.text = Icons.star
                    star3.text = Icons.star
                    star4.text = Icons.star
                    star5.text = Icons.star
                    selectedRate = 5
                }
            }

        }

        Rectangle{
            Layout.preferredWidth: 2
            Layout.preferredHeight: parent.height - (parent.height * 0.2)
            Layout.leftMargin: 20 * ratio
            color: "#dddddd"

            visible: !selectable
        }

        //-- Average Rate --//
        Label{
            id: lbl_AverageRate
            Layout.preferredWidth: implicitWidth
            Layout.preferredHeight: implicitHeight
            Layout.leftMargin: 20 * ratio
            Layout.alignment: Qt.AlignVCenter

            visible: !selectable

            text: selectedRate
            font.family: segoeUI.name
            font.pixelSize: Qt.application.font.pixelSize * 1.3
            font.bold: true
            color: "#1777c4"
        }

        //-- Averages star --//
        Label{
            Layout.preferredWidth: implicitWidth
            Layout.preferredHeight: implicitHeight
            Layout.leftMargin: 10 * ratio
            Layout.alignment: Qt.AlignVCenter

            visible: !selectable

            text: Icons.star
            font.family: webfont.name
            font.pixelSize: Qt.application.font.pixelSize * 1.8
            color: "#1777c4"
        }

        Item {
            Layout.fillWidth: true
            visible: !selectable
        }

    }

}
