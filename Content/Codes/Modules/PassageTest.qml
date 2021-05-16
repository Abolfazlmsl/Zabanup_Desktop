import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Window 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0


import "./../../Fonts/Icon.js" as Icons
import "./../Utils/Utils.js" as Utils
import "./../Utils/Enum.js" as Enum


//-- Total Passage --//
Rectangle{
    id: totalPassage

    property alias headerText: headerLabel.text
    property alias topicText: topicLabel.text
    property alias imageUrl: imgSelectPassage.source
    property var allToQ: []
    onAllToQChanged: {
        //console.log("AllToQ Changed = " + allToQ)

    }

    signal takeTest_Clicked
    signal whichToQ(bool vis)
    onWhichToQ: {
        toq_Select.visible = vis
    }


    width: 310
    height: 280
    color: "#ffffff"
    clip: true
    radius: 10


    //-- Header and Body --//
    ColumnLayout{
        anchors.fill: parent
        anchors.margins: 10
        spacing: 5

        //-- Header --//
        Rectangle{
            Layout.fillWidth: true
            Layout.preferredHeight: 40
            color: "#5674b9"
            //            radius: 10

            Label{
                id: headerLabel
                width: parent.width
                height: parent.height * 0.7
                padding: 3
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                text: "Practice Test"
                minimumPixelSize: 10
                fontSizeMode: Text.Fit
                font.family: segoeUI.name
                font.pixelSize: Qt.application.font.pixelSize * 1.5
                font.weight: Font.Bold
                color: "#ffffff"

            }
        }

        //-- Topic --//
        Rectangle{
            Layout.preferredWidth: parent.width
            Layout.preferredHeight: 34
            Layout.alignment: Qt.AlignHCenter
            color: Utils.color_BaseBlue
            //            radius: 10

            Label{
                id: topicLabel
                width: parent.width
                height: parent.height * 0.7
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                text: "Topic"
                minimumPixelSize: 10
                fontSizeMode: Text.Fit
                font.family: segoeUI.name
                font.pixelSize: Qt.application.font.pixelSize * 1.5
                color: "#ffffff"
            }
        }

        //-- passage Image --//
        Image {
            id: imgSelectPassage
            source: "qrc:/Content/Images/SelectTest_Image/Book_Hat.png"
            //            sourceSize.width: parent.width / 2
            //            sourceSize.height: parent.width / 2
            Layout.preferredWidth: parent.width * 0.75
            Layout.preferredHeight: width * 0.6
            //            Layout.topMargin: 10
            fillMode: Image.PreserveAspectFit
            Layout.alignment: Qt.AlignHCenter
        }

        //-- Take Test Button --//
        Rectangle{
            id: btnTT
            Layout.fillWidth: true
            Layout.preferredHeight: 40
            //            Layout.topMargin: 10
            color: "#008cb3"

            //-- "Take Test" Label --//
            Label{
                id: lbl_TakeTest
                width: implicitWidth
                height: parent.height * 0.7
                anchors.verticalCenter: parent.verticalCenter

                anchors.right: parent.right
                anchors.rightMargin: ((parent.width - width) - checkIconReading.width) / 2

                verticalAlignment: Qt.AlignVCenter

                text: "Take Test"
                font.family: segoeUI.name
                minimumPointSize: 10
                fontSizeMode: Text.Fit
                font.pixelSize: Qt.application.font.pixelSize * 1.2
                font.weight: Font.DemiBold
                color: "#ffffff"
            }

            //-- CheckBox Icon --//
            Label{
                id:checkIconReading
                width: implicitWidth
                height: parent.height * 0.7

                anchors.verticalCenter: parent.verticalCenter
                anchors.right: lbl_TakeTest.left
                anchors.rightMargin: 5
                verticalAlignment: Qt.AlignVCenter

                minimumPointSize: 10
                fontSizeMode: Text.Fit
                text: Icons.checkbox_marked_outline
                font.family: webfont.name
                font.pixelSize: Qt.application.font.pixelSize * 1.6
                color: "#ffffff"
            }
            ItemDelegate{
                anchors.fill: parent
                onClicked: {
                    takeTest_Clicked()
                }
            }

        }

        Item {
            Layout.fillHeight: true
        }


    }

    //-- Select QuestionType --//
    Rectangle{
        id: toq_Select
        visible: false
        anchors.fill: parent
        radius: parent.radius
        color: "#aa100d08"

        //-- Close Button --//
        Rectangle{
            width: 20
            height: width
            radius: width / 2
            color: "#bbbbbb"

            anchors{
                right: parent.right
                rightMargin: 15
                top: parent.top
                topMargin: 15
            }

            Label{
                text: "x"
                anchors.centerIn: parent
                color: "#ffffff"
            }

            MouseArea{
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor

                onClicked: {
                    toq_Select.visible = false
                }
            }
        }

        ListView{
            width: parent.width - 40
            height: allToQ.length * 40 + ((allToQ.length - 1) * spacing)
            anchors.centerIn: parent
            model: allToQ
            spacing: 8

            delegate: Rectangle{
                width: parent.width
                height: 40

                color: Utils.color_BaseBlue

                Label{
                    text: modelData['type'].name
                    anchors.centerIn: parent
                    color: "#ffffff"
                }

                ItemDelegate{
                    anchors.fill: parent

                    onClicked: {
                        root._PassageTestQuestions.clear()
                        root._PassageTestQuestions.append(modelData)
                        console.log("TEST = " + JSON.stringify(root._PassageTestQuestions.get(0)))

                        sView.push(Enum._PAGE_PassageTest)

                    }
                }

            }
        }
    }

}

