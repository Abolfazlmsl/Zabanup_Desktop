import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Window 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0


import "./../../Fonts/Icon.js" as Icons


//-- Total Practice  --//
Rectangle{


    property alias headerTitle: headerLabel.text
    property real leftMTakeTest: (btnListeningTakeTest.width - (lbl_ListeningTakeTest2.implicitWidth + checkIconListening2.implicitWidth)) / 2
    property real leftMSolution: (btnListeningSolution.width - (lbl_Solution2.implicitWidth + puzzleIconListening2.implicitWidth)) / 2

    signal l_TakeTest_Clicked
    signal l_Solution_Clicked
    signal r_TakeTest_Clicked
    signal r_Solution_Clicked

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
            radius: 10

            Label{
                id: headerLabel
                width: parent.width
                height: parent.height * 0.7
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
            //            layer.enabled: true
            //            layer.effect: DropShadow {
            //                transparentBorder: true
            //                horizontalOffset: 1//8
            //                verticalOffset: 8
            //                color: "#80000000"
            //                spread: 0.0
            //                samples: 17
            //                radius: 12
            //            }
        }

        //-- Reading and Listening Section --//
        Rectangle{
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "transparent"
            RowLayout{
                anchors.fill: parent
                //anchors.margins: 5
                spacing: 10

                //-- Listening --//
                Rectangle{
                    Layout.preferredWidth: (parent.width / 2) - (parent.spacing / 2)
                    Layout.fillHeight: true
                    color: "transparent"

                    ColumnLayout{
                        anchors.fill: parent
                        spacing: 5

                        //-- Listening Image --//
                        Image {
                            id: imgListening
                            source: "qrc:/Content/Images/Practice_Test/listening.png"
                            sourceSize.width: parent.width
                            sourceSize.height: parent.height * 0.6
                            Layout.fillWidth: true
                            Layout.preferredHeight: width * 0.6
                            Layout.topMargin: 10
                            fillMode: Image.PreserveAspectFit

                        }


                        //-- Take Test Button 2 visible: false --//
                        Rectangle{
                            id: btnListeningTakeTest2
                            visible: false
                            Layout.fillWidth: true
                            Layout.preferredHeight: 40
                            color: "#0066b3"
                            Layout.topMargin: 10

                            //-- CheckBox Icon --//
                            Label{
                                id:checkIconListening2
                                width: implicitWidth
                                height: parent.height * 0.7

                                anchors.verticalCenter: parent.verticalCenter
                                verticalAlignment: Qt.AlignVCenter

                                minimumPointSize: 10
                                fontSizeMode: Text.Fit
                                text: Icons.checkbox_marked_outline
                                font.family: webfont.name
                                font.pixelSize: Qt.application.font.pixelSize * 1.6
                                color: "#ffffff"
                            }

                            //-- "Take Test" Label --//
                            Label{
                                id: lbl_ListeningTakeTest2
                                width: parent.width - checkIconListening2.width
                                height: parent.height * 0.7
                                anchors.verticalCenter: parent.verticalCenter

                                anchors.left: checkIconListening2.right
                                anchors.leftMargin: 5
                                verticalAlignment: Qt.AlignVCenter
                                horizontalAlignment: Qt.AlignLeft

                                text: "Take Test"
                                font.family: segoeUI.name
                                minimumPointSize: 10
                                fontSizeMode: Text.Fit
                                font.pixelSize: Qt.application.font.pixelSize * 1.2
                                font.weight: Font.DemiBold
                            }

                        }

                        //-- Solution Button 2 visible: false --//
                        Rectangle{
                            id:btnListeningSolution2
                            visible: false
                            Layout.fillWidth: true
                            Layout.preferredHeight: 40
                            color: "#3f8dcc"

                            //-- Puzzle Icon --//
                            Label{
                                id:puzzleIconListening2
                                width: implicitWidth
                                height: parent.height * 0.7

                                anchors.verticalCenter: parent.verticalCenter
                                verticalAlignment: Qt.AlignVCenter

                                minimumPointSize: 10
                                fontSizeMode: Text.Fit
                                text: Icons.puzzle
                                font.family: webfont.name
                                font.pixelSize: Qt.application.font.pixelSize * 1.6
                            }

                            //-- "Solution" Label --//
                            Label{
                                id:lbl_Solution2
                                width: parent.width - puzzleIconListening2.width
                                height: parent.height * 0.7
                                anchors.verticalCenter: parent.verticalCenter

                                anchors.left: puzzleIconListening2.right
                                anchors.leftMargin: 5
                                verticalAlignment: Qt.AlignVCenter
                                horizontalAlignment: Qt.AlignLeft


                                text: "Solution"
                                font.family: segoeUI.name
                                minimumPointSize: 10
                                fontSizeMode: Text.Fit
                                font.pixelSize: Qt.application.font.pixelSize * 1.2
                                font.weight: Font.DemiBold
                            }



                        }



                        //-- Take Test Button --//
                        Rectangle{
                            id: btnListeningTakeTest
                            Layout.fillWidth: true
                            Layout.preferredHeight: 40
                            color: "#0066b3"
                            Layout.topMargin: 10

                            //-- CheckBox Icon --//
                            Label{
                                id:checkIconListening
                                width: implicitWidth
                                height: parent.height * 0.7

                                anchors.verticalCenter: parent.verticalCenter
                                leftPadding: (leftMTakeTest <= 0) ? 0 : leftMTakeTest
                                verticalAlignment: Qt.AlignVCenter
                                horizontalAlignment: Qt.AlignRight

                                minimumPixelSize: 1
                                fontSizeMode: Text.Fit
                                text: Icons.checkbox_marked_outline
                                font.family: webfont.name
                                font.pixelSize: Qt.application.font.pixelSize * 1.6
                                color: "#ffffff"
                            }

                            //-- "Take Test" Label --//
                            Label{
                                id: lbl_ListeningTakeTest
                                width: parent.width - checkIconListening.width
                                height: parent.height * 0.7
                                anchors.verticalCenter: parent.verticalCenter

                                anchors.left: checkIconListening.right
                                anchors.leftMargin: 5
                                verticalAlignment: Qt.AlignVCenter
                                horizontalAlignment: Qt.AlignLeft

                                text: "Take Test"
                                font.family: segoeUI.name
                                minimumPointSize: 10
                                fontSizeMode: Text.Fit
                                font.pixelSize: Qt.application.font.pixelSize * 1.2
                                font.weight: Font.DemiBold
                                color: "#ffffff"
                            }

                            ToolTip{
                                id: tt_ListeningTT
                                anchors.centerIn: parent
                                visible: false
                                text: "به زودی"
                            }

                            MouseArea{
                                id: ma_LTT
                                anchors.fill: parent
                                hoverEnabled: true

                                onClicked: {
                                    l_TakeTest_Clicked()
                                }

                                onEntered: {
                                    tt_ListeningTT.visible = true
                                }

                                onExited: {
                                    tt_ListeningTT.visible = false
                                }
                            }

                        }

                        //-- Solution Button --//
                        Rectangle{
                            id:btnListeningSolution
                            Layout.fillWidth: true
                            Layout.preferredHeight: 40
                            color: "#3f8dcc"

                            //-- Puzzle Icon --//
                            Label{
                                id:puzzleIconListening
                                width: implicitWidth
                                height: parent.height * 0.7

                                anchors.verticalCenter: parent.verticalCenter
                                leftPadding: (leftMSolution <= 0) ? 0 : leftMSolution
                                verticalAlignment: Qt.AlignVCenter
                                horizontalAlignment: Qt.AlignHCenter

                                minimumPointSize: 10
                                fontSizeMode: Text.Fit
                                text: Icons.puzzle
                                font.family: webfont.name
                                font.pixelSize: Qt.application.font.pixelSize * 1.6
                                color: "#ffffff"
                            }

                            //-- "Solution" Label --//
                            Label{
                                id: lbl_ListeningSolution
                                width: parent.width - puzzleIconListening.width
                                height: parent.height * 0.7
                                anchors.verticalCenter: parent.verticalCenter

                                anchors.left: puzzleIconListening.right
                                anchors.leftMargin: 5
                                verticalAlignment: Qt.AlignVCenter
                                horizontalAlignment: Qt.AlignLeft


                                text: "Solution"
                                font.family: segoeUI.name
                                minimumPointSize: 10
                                fontSizeMode: Text.Fit
                                font.pixelSize: Qt.application.font.pixelSize * 1.2
                                font.weight: Font.DemiBold
                                color: "#ffffff"
                            }

                            ToolTip{
                                id: tt_ListeningS
                                anchors.centerIn: parent
                                visible: false
                                text: "به زودی"
                            }

                            MouseArea{
                                id: ma_LS
                                anchors.fill: parent
                                hoverEnabled: true

                                onClicked: {
                                    l_Solution_Clicked()
                                }

                                onEntered: {
                                    tt_ListeningS.visible = true
                                }

                                onExited: {
                                    tt_ListeningS.visible = false
                                }

                            }

                        }

                        Item {
                            Layout.fillHeight: true
                        }
                    }

                }

                //-- Reading --//
                Rectangle{
                    Layout.preferredWidth: (parent.width / 2) - (parent.spacing / 2)
                    Layout.fillHeight: true
                    color: "transparent"

                    ColumnLayout{
                        anchors.fill: parent
                        spacing: 5

                        //-- Reading Image --//
                        Image {
                            source: "qrc:/Content/Images/Practice_Test/reading.png"
                            sourceSize.width: parent.width
                            sourceSize.height: parent.height * 0.6
                            Layout.fillWidth: true
                            Layout.preferredHeight: width * 0.6
                            Layout.topMargin: 10
                            fillMode: Image.PreserveAspectFit
                        }

                        //-- Take Test Button --//
                        Rectangle{
                            Layout.fillWidth: true
                            Layout.preferredHeight: 40
                            Layout.topMargin: 10
                            color: "#008cb3"

                            //-- CheckBox Icon --//
                            Label{
                                id:checkIconReading
                                width: implicitWidth
                                height: parent.height * 0.7

                                anchors.verticalCenter: parent.verticalCenter
                                leftPadding: (leftMTakeTest <= 0) ? 0 : leftMTakeTest
                                verticalAlignment: Qt.AlignVCenter
                                horizontalAlignment: Qt.AlignHCenter

                                minimumPointSize: 10
                                fontSizeMode: Text.Fit
                                text: Icons.checkbox_marked_outline
                                font.family: webfont.name
                                font.pixelSize: Qt.application.font.pixelSize * 1.6
                                color: "#ffffff"
                            }

                            //-- "Take Test" Label --//
                            Label{
                                width: parent.width - checkIconReading.width
                                height: parent.height * 0.7
                                anchors.verticalCenter: parent.verticalCenter

                                anchors.left: checkIconReading.right
                                anchors.leftMargin: 5
                                verticalAlignment: Qt.AlignVCenter
                                horizontalAlignment: Qt.AlignLeft

                                text: "Take Test"
                                font.family: segoeUI.name
                                minimumPointSize: 10
                                fontSizeMode: Text.Fit
                                font.pixelSize: Qt.application.font.pixelSize * 1.2
                                font.weight: Font.DemiBold
                                color: "#ffffff"
                            }

                            ItemDelegate{
                                anchors.fill: parent
                                onClicked: {
                                    r_TakeTest_Clicked()
                                }
                            }

                        }

                        //-- Solution Button --//
                        Rectangle{
                            Layout.fillWidth: true
                            Layout.preferredHeight: 40
                            color: "#2bb6c9"

                            //-- Puzzle Icon --//
                            Label{
                                id:puzzleIconReading
                                width: implicitWidth
                                height: parent.height * 0.7

                                anchors.verticalCenter: parent.verticalCenter
                                leftPadding: (leftMSolution <= 0) ? 0 : leftMSolution
                                verticalAlignment: Qt.AlignVCenter
                                horizontalAlignment: Qt.AlignHCenter

                                minimumPointSize: 10
                                fontSizeMode: Text.Fit
                                text: Icons.puzzle
                                font.family: webfont.name
                                font.pixelSize: Qt.application.font.pixelSize * 1.6
                                color: "#ffffff"
                            }

                            //-- "Solution" Label --//
                            Label{
                                width: parent.width - puzzleIconReading.width
                                height: parent.height * 0.7
                                anchors.verticalCenter: parent.verticalCenter

                                anchors.left: puzzleIconReading.right
                                anchors.leftMargin: 5
                                verticalAlignment: Qt.AlignVCenter
                                horizontalAlignment: Qt.AlignLeft


                                text: "Solution"
                                font.family: segoeUI.name
                                minimumPointSize: 10
                                fontSizeMode: Text.Fit
                                font.pixelSize: Qt.application.font.pixelSize * 1.2
                                font.weight: Font.DemiBold
                                color: "#ffffff"
                            }


                            ItemDelegate{
                                anchors.fill: parent
                                onClicked: {
                                    r_Solution_Clicked()
                                }
                            }
                        }

                        Item {
                            Layout.fillHeight: true
                        }
                    }


                }

            }

        }

    }

}
