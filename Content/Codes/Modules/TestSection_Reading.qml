import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Window 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

import "./../../Fonts/Icon.js" as Icons
import "./../Utils/Enum.js" as Enum

Item {
    id: section_1
    anchors.fill: parent

    property alias textFontSize : mainTextPSG1.font

    property int passage1_Height: passage1.contentHeight
    property int passage2_Height: passage2.contentHeight
    property int passage3_Height: passage3.contentHeight

    signal selectPassage(bool pass1_Visible , bool pass2_Visible , bool pass3_Visible)
    onSelectPassage: {
        passage1.visible = pass1_Visible
        passage2.visible = pass2_Visible
        passage3.visible = pass3_Visible
    }

    Flickable{
        id: passage1
        anchors.fill: parent
        contentWidth: width
        contentHeight: headerPSG1.height + descriptSection1.height + img_Sec1.height + headingBI1.height + mainTextPSG1.height

        Column{
            width: parent.width
            spacing: 2
            //-- PASSAGE --//
            Label{
                id: headerPSG1
                width: parent.width
                height: implicitHeight + 20 * ratio

                horizontalAlignment: Qt.AlignLeft
                verticalAlignment: Qt.AlignVCenter

                clip: true
                wrapMode: Text.WordWrap

                text: "READING PASSAGE 1"
                font.pixelSize: Qt.application.font.pixelSize * 2
                font.family: iranSans.name
                anchors.margins: 10 * ratio
            }

            //-- DESCRIPTION OF THIS SECTION --//
            Label{
                id: descriptSection1
                width: parent.width
                height: implicitHeight + 20 * ratio

                text: "You should spend about 20 minutes on Questions 1-13, which are based on Reading Passage 1 below."
                clip: true
                wrapMode: Text.WordWrap
                font.pixelSize: Qt.application.font.pixelSize * 0.9
                font.family: iranSans.name
                anchors.margins: 10 * ratio
            }

            //-- Image --//
            Image {
                id: img_Sec1
                width: parent.width - (20 * ratio)
                height: sourceSize.height / (sourceSize.width / width)

                horizontalAlignment: Qt.AlignHCenter

                fillMode: Image.PreserveAspectFit

                source: "qrc:/Content/Images/Other/section 1_1.png"
            }

            //-- Heading in Below Image --//
            Label{
                id: headingBI1
                width: parent.width
                height: implicitHeight + 20 * ratio

                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter

                text: "The Concept of Childhood in Western Countries"
                clip: true
                wrapMode: Text.WordWrap
                font.pixelSize: Qt.application.font.pixelSize * 1.8
                font.family: iranSans.name
                font.bold: true
                anchors.margins: 10 * ratio
            }

            //-- Main Text Passage_1 --//
            TextArea{
                id:mainTextPSG1
                width: parent.width
                height: implicitHeight

                readOnly: true
                selectByMouse: true
                text: Enum._SAMPLE_TEXT_PASSAGE_1
                clip: true
                wrapMode: Text.WordWrap
                font.pixelSize: Qt.application.font.pixelSize * 0.9
                font.family: iranSans.name
                Layout.margins: 10 * ratio

                Material.accent: "transparent"

                background: Rectangle{
                    color: "#00ffffff"
                }
            }
        }

    }

    Flickable{
        id: passage2
        visible: false
        anchors.fill: parent
        contentWidth: width
        contentHeight: headerPSG2.height + descriptSection2.height + img_Sec2.height + headingBI2.height + mainTextPSG2.height

        Column{
            width: parent.width
            spacing: 2
            //-- PASSAGE --//
            Label{
                id: headerPSG2
                width: parent.width
                height: implicitHeight + 20 * ratio

                horizontalAlignment: Qt.AlignLeft
                verticalAlignment: Qt.AlignVCenter

                clip: true
                wrapMode: Text.WordWrap

                text: "READING PASSAGE 2"
                font.pixelSize: Qt.application.font.pixelSize * 2
                font.family: iranSans.name
                anchors.margins: 10 * ratio
            }

            //-- DESCRIPTION OF THIS SECTION --//
            Label{
                id: descriptSection2
                width: parent.width
                height: implicitHeight + 20 * ratio

                text: "You should spend about 20 minutes on Questions 14-26, which are based on Reading Passage 2 below."
                clip: true
                wrapMode: Text.WordWrap
                font.pixelSize: Qt.application.font.pixelSize * 0.9
                font.family: iranSans.name
                anchors.margins: 10 * ratio
            }

            //-- Image --//
            Image {
                id: img_Sec2
                width: parent.width - (20 * ratio)
                height: sourceSize.height / (sourceSize.width / width)

                horizontalAlignment: Qt.AlignHCenter

                fillMode: Image.PreserveAspectFit

                source: "qrc:/Content/Images/Other/section 2_2.png"
            }

            //-- Heading in Below Image --//
            Label{
                id: headingBI2
                width: parent.width
                height: implicitHeight + 20 * ratio

                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter

                text: "Bestcom—Considerate Computing"
                clip: true
                wrapMode: Text.WordWrap
                font.pixelSize: Qt.application.font.pixelSize * 1.8
                font.family: iranSans.name
                font.bold: true
                anchors.margins: 10 * ratio
            }

            //-- Main Text Passage_1 --//
            TextArea{
                id:mainTextPSG2
                width: parent.width
                height: implicitHeight

                readOnly: true
                selectByMouse: true
                text: Enum._SAMPLE_TEXT_PASSAGE_2
                clip: true
                wrapMode: Text.WordWrap
                font.pixelSize: Qt.application.font.pixelSize * 0.9
                font.family: iranSans.name
                Layout.margins: 10 * ratio

                Material.accent: "transparent"

                background: Rectangle{
                    color: "#ffffff"
                }
            }
        }

    }

    Flickable{
        id: passage3
        visible: false
        anchors.fill: parent
        contentWidth: width
        contentHeight: headerPSG3.height + descriptSection3.height + img_Sec3.height + headingBI3.height + mainTextPSG3.height

        Column{
            width: parent.width
            spacing: 2
            //-- PASSAGE --//
            Label{
                id: headerPSG3
                width: parent.width
                height: implicitHeight + 20 * ratio

                horizontalAlignment: Qt.AlignLeft
                verticalAlignment: Qt.AlignVCenter

                clip: true
                wrapMode: Text.WordWrap

                text: "READING PASSAGE 3"
                font.pixelSize: Qt.application.font.pixelSize * 2
                font.family: iranSans.name
                anchors.margins: 10 * ratio
            }

            //-- DESCRIPTION OF THIS SECTION --//
            Label{
                id: descriptSection3
                width: parent.width
                height: implicitHeight + 20 * ratio

                text: "You should spend about 20 minutes on Questions 27-40, which are based on Reading Passage 3 below."
                clip: true
                wrapMode: Text.WordWrap
                font.pixelSize: Qt.application.font.pixelSize * 0.9
                font.family: iranSans.name
                anchors.margins: 10 * ratio
            }

            //-- Image --//
            Image {
                id: img_Sec3
                width: parent.width - (20 * ratio)
                height: sourceSize.height / (sourceSize.width / width)

                horizontalAlignment: Qt.AlignHCenter

                fillMode: Image.PreserveAspectFit

                source: "qrc:/Content/Images/Other/section 3_0.png"
            }

            //-- Heading in Below Image --//
            Label{
                id: headingBI3
                width: parent.width
                height: implicitHeight + 20 * ratio

                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter

                text: "Can Hurricanes be Moderated or Diverted?"
                clip: true
                wrapMode: Text.WordWrap
                font.pixelSize: Qt.application.font.pixelSize * 1.8
                font.family: iranSans.name
                font.bold: true
                anchors.margins: 10 * ratio
            }

            //-- Main Text Passage_1 --//
            TextArea{
                id:mainTextPSG3
                width: parent.width
                height: implicitHeight

                readOnly: true
                selectByMouse: true
                text: Enum._SAMPLE_TEXT_PASSAGE_3
                clip: true
                wrapMode: Text.WordWrap
                font.pixelSize: Qt.application.font.pixelSize * 0.9
                font.family: iranSans.name
                Layout.margins: 10 * ratio

                Material.accent: "transparent"

                background: Rectangle{
                    color: "#ffffff"
                }
            }
        }

    }

}
