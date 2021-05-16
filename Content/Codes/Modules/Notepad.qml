import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.13

import "./../../Fonts/Icon.js" as Icon
import "./../Utils/Utils.js" as Utils


//-- notepad --//
Rectangle{
    id: rect_Notepad
    Layout.fillWidth: true
    Layout.preferredHeight: 40

    property alias noteText: txa_Note.text
    property alias noteheight: rect_Notepad.height

    clip: true

    property bool expand: false
    onExpandChanged: {
        if(expand === false){
            hideNotepad.restart()
        }
        else {
            showNotepad.restart()
        }
    }

    PropertyAnimation { id: showNotepad ; target: rect_Notepad ; properties: "Layout.preferredHeight"; to: 250 ; duration: 500 }

    PropertyAnimation { id: hideNotepad ; target: rect_Notepad ; properties: "Layout.preferredHeight"; to: 40 ; duration: 500 }

    //-- Button notepad --//
    Rectangle{
        id: btn_Notepad
        width: notePad_Icon.width + notePad_label.width + 16
        height: 40

        anchors.left: parent.left
        anchors.leftMargin: 15

        color: "#eeeeee"
        radius: 5

        //-- icon --//
        Label{
            id: notePad_Icon
            width: implicitWidth
            height: parent.height * 0.9

            anchors.left: parent.left
            anchors.leftMargin: 8
            anchors.verticalCenter: parent.verticalCenter

            verticalAlignment: Qt.AlignVCenter
            color: "#555555"

            text: (rect_Notepad.expand) ? Icon.file_document_box_minus_outline : Icon.file_document_box_plus_outline
            font.family: webfont.name
            minimumPixelSize: 10
            fontSizeMode: Text.Fit
            font.pixelSize: Qt.application.font.pixelSize * 2
        }

        //-- text --//
        Label{
            id: notePad_label
            width: implicitWidth
            height: parent.height * 0.6

            anchors.left: notePad_Icon.right
            anchors.verticalCenter: parent.verticalCenter

            verticalAlignment: Qt.AlignVCenter
            color: "#555555"

            text: (rect_Notepad.expand) ? "Hide Notepad" : "Show Notepad"
            font.family: qFont
            minimumPixelSize: 10
            fontSizeMode: Text.Fit
            font.pixelSize: Qt.application.font.pixelSize
        }


        MouseArea{
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                rect_Notepad.expand = !rect_Notepad.expand
            }
        }

    }

    //-- Text Area --//
    Rectangle{
        width: parent.width
        height: 250 - btn_Notepad.height

        anchors.top: btn_Notepad.bottom

        //                color: "#8000ff00"

        Flickable {
            id: flick_Notepad
            width: parent.width - 30
            height: parent.height - 30

            anchors.centerIn: parent
            interactive: false

            TextArea.flickable: TextArea {
                id: txa_Note

                padding: 20
//                        topPadding: 20

                wrapMode: TextArea.Wrap

                background: Rectangle{
                    color: "transparent"
                    border.width: 1
                    border.color: "#444444"
                    radius: 10
                }

            }

            ScrollBar.vertical: ScrollBar {
                width: 10
                anchors.right: parent.right
                anchors.rightMargin: 10
            }

        }


    }

}
