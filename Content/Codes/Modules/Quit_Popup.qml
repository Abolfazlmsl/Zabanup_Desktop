import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

import "./../../Fonts/Icon.js" as Icons

Dialog{

    id:quitDialog

    property real sizeRatio: (widthRatio <= heightRatio) ? (widthRatio + ((1 - widthRatio) / 2)) : (heightRatio + ((1 - heightRatio) / 2))

    padding: 0
    topPadding: 0

    modal: true

    property string bodyText_Dialog: "آیا مایل به خروج هستید ؟"

    width: parent.width - (40 * ratio)
    height: 150 * ratio

    background: Rectangle{
        radius: 5 * ratio
        color: "#ffffff"
    }

    //-- Header (Title) --//
    header: Rectangle{
        width: parent.width
        height: 45 * ratio * sizeRatio
        radius: 5 * ratio * sizeRatio
        color: "#00adb3"
        Rectangle{
            width: parent.width
            height: 40 * ratio * sizeRatio
            color: parent.color
            anchors.bottom: parent.bottom
        }

        //-- Logo Image --//
        Image {
            source: "qrc:/Content/Images/White_Logo.png"

            sourceSize.width: width / 2
            sourceSize.height: height

            width: parent.width
            height: parent.height * 0.8

            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter

            fillMode: Image.PreserveAspectFit
        }

    }

    ColumnLayout{
        anchors.fill: parent
        spacing: 0

        //-- Question of Exit Label and Icon --//
        Rectangle{
            Layout.fillWidth: true
            Layout.preferredHeight: 78 * ratio * sizeRatio

            //color: "#55ff0000"

            //-- Exit Label and Icon --//
            RowLayout{
                anchors.fill: parent
                layoutDirection: Qt.RightToLeft

                //-- Filler --//
                Item {
                    Layout.fillWidth: true
                }

                //-- Exit Icon --//
                Label{
                    Layout.fillHeight: true
                    Layout.preferredWidth: implicitWidth * 1.1

                    text: Icons.logout

                    font.family: webfont.name
                    font.pixelSize: Qt.application.font.pixelSize * 2 * sizeRatio

                    verticalAlignment: Qt.AlignVCenter
                    horizontalAlignment: Qt.AlignHCenter

                }

                //-- Text of Exit Popup --//
                Label{

                    Layout.fillHeight: true
                    Layout.preferredWidth: implicitWidth * 1.1

                    text: bodyText_Dialog
                    font.family: iranSans.name
                    font.pixelSize: Qt.application.font.pixelSize * 1.2 * ratio * sizeRatio
                    wrapMode: Text.WordWrap
                    verticalAlignment: Qt.AlignVCenter
                    horizontalAlignment: Qt.AlignHCenter
                    color: "#000000"
                }

                //-- Filler --//
                Item {
                    Layout.fillWidth: true
                }

            }
        }

        //-- Yes No Button --//
        Rectangle{
            Layout.fillWidth: true
            Layout.fillHeight: true

            radius: 5 * ratio

            //color: "#5500ff00"

            RowLayout{
                anchors.fill: parent
                spacing: 10 * ratio
                layoutDirection: Qt.RightToLeft

                //-- Filler --//
                Item {
                    Layout.fillWidth: true
                }

                //-- "No" Button --//
                Rectangle{

                    Layout.preferredWidth: 100 * ratio * sizeRatio
                    Layout.preferredHeight: 40 * ratio * sizeRatio

                    Layout.alignment: Qt.AlignTop

                    radius: 5 * ratio

                    color: "#00adb3"
                    border{
                        color: noToExit.focus ? "#ffFF0000" : "#00FF0000"
                        width: 1
                    }

                    //-- "No" Label --//
                    Label{
                        anchors.centerIn: parent

                        text: "خیر"
                        font.family: iranSans.name
                        font.pixelSize: Qt.application.font.pixelSize * 1.2 * ratio * sizeRatio

                        color: "#ffffff"
                    }

                    //-- on No Clicked --//
                    ItemDelegate{
                        id:noToExit
                        anchors.fill: parent
                        onClicked: {
                            quitDialog.close()
                        }

                        Keys.onTabPressed: {
                            yesToExit.forceActiveFocus()
                        }

                        Keys.onPressed: {

                            console.log("key=" + event.key + ", k=" + Qt.Key_Enter);
                            if (event.key == Qt.Key_Enter
                                    || event.key == 16777220) {
                                quitDialog.close()
                                event.accepted = true;
                            }
                        }
                    }
                }

                //-- "Yes" Button --//
                Rectangle{
                    Layout.preferredWidth: 100 * ratio * sizeRatio
                    Layout.preferredHeight: 40 * ratio * sizeRatio

                    Layout.alignment: Qt.AlignTop

                    radius: 5 * ratio

                    color: "#c76478"

                    border{
                        color: yesToExit.focus ? "#ffFF0000" : "#00FF0000"
                        width: 1
                    }

                    //-- "Yes" Label --//
                    Label{
                        anchors.centerIn: parent

                        text: "بله"
                        font.family: iranSans.name
                        font.pixelSize: Qt.application.font.pixelSize * 1.2 * ratio * sizeRatio

                        color: "#ffffff"
                    }

                    //-- on Yes Clicked --//
                    ItemDelegate{
                        id:yesToExit
                        anchors.fill: parent

                        Keys.onTabPressed: {
                            noToExit.forceActiveFocus()
                        }

                        Keys.onPressed: {

                            console.log("key=" + event.key + ", kn=" + Qt.Key_Enter + ", kg=" + Qt.Key_Return);
                            if (event.key === Qt.Key_Enter
                                    || event.key === Qt.Key_Return) {
                                //                                console.log("move left");
                                Qt.quit()
                                event.accepted = true;
                            }
                        }

                        onClicked: {
                            Qt.quit()
                        }
                    }
                }

                //-- Filler --//
                Item {
                    Layout.fillWidth: true
                }
            }

        }
    }

    onOpened: {
        yesToExit.forceActiveFocus()
    }



}
