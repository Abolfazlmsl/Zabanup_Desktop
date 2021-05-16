import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import QtQuick.Dialogs 1.3

import "./../../Fonts/Icon.js" as Icons
import "./../Utils/Utils.js" as Util

Rectangle{
    id:rootComment

    width: parent.width
    height: 40

    color: "#ffffff"

    property bool expand: true
    onExpandChanged: {
        if(expand === false){
            upCommetHeader.restart()
        }
        else {
            downCommentHeader.restart()
        }
    }



    //-- down Animation --//
    ParallelAnimation{
        id: downCommentHeader
        PropertyAnimation { target: rootComment ; properties: "height"; to: 40 ; duration: 700 }
        PropertyAnimation { target: lbl_ChevronUpIcon ; properties: "rotation"; to: 0; duration: 700 }
        PropertyAnimation { target: g_Blur ; properties: "opacity"; to: 0.0; duration: 500 }
    }

    //-- Up Animation --//
    ParallelAnimation{
        id: upCommetHeader
        PropertyAnimation { target: rootComment ; properties: "height"; to: rootAnswerPage.height * 0.7 ; duration: 700 }
        PropertyAnimation { target: lbl_ChevronUpIcon ; properties: "rotation"; to: 180; duration: 700 }
        PropertyAnimation { target: g_Blur ; properties: "opacity"; to: 1.0; duration: 500 }
    }

    //-- header --//
    Rectangle{
        id: commentHeader
        width: parent.width
        height: 40

        anchors.top: parent.top

        color: Util.color_BaseBlue

        //-- Comment Icon --//
        Label{
            id: lbl_CommentIcon

            anchors.verticalCenter: parent.verticalCenter

            text: Icons.comment_text_multiple_outline
            font.family: webfont.name
            font.pixelSize: Qt.application.font.pixelSize * 1.8
            anchors.right: parent.right
            anchors.leftMargin: 15
            anchors.rightMargin: 15
            color: "#ffffff"

        }

        //-- Comments Label "کامنت ها" --//
        Label{

            anchors.verticalCenter: parent.verticalCenter

            text: "کامنت ها"
            font.family: iranSans.name
            font.pixelSize: Qt.application.font.pixelSize * 1.6
            anchors.right: lbl_CommentIcon.left
            anchors.rightMargin: 10
            color: "#ffffff"
        }

        //-- Open Close Icon (ChevronUP) --//
        Label{
            id: lbl_ChevronUpIcon

            anchors.verticalCenter: parent.verticalCenter

            text: Icons.chevron_up_circle
            font.family: webfont.name
            font.pixelSize: Qt.application.font.pixelSize * 1.8
            anchors.left: parent.left
            anchors.leftMargin: 15
            color: "#ffffff"

            MouseArea{
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor

                onClicked: {
                    expand = !expand
                }
            }
        }
    }

    //-- Comment and Send Comment --//
    Rectangle{
        width: parent.width
        height: parent.height - commentHeader.height

        anchors.bottom: parent.bottom

        color: "#ffffff"

        ColumnLayout{
            anchors.fill: parent
            spacing: 0

            //-- Comments --//
            ListView{
                id: list_comment

                Layout.fillWidth: true
                Layout.fillHeight: true
                topMargin: 10
                spacing: 5
                clip: true

                model: ListModel{
                    id: comment_model
                }

                delegate: Rectangle{
                    id: delegate_rec
                    width: parent.width
                    height: lbl_Comment.implicitHeight + 80

                    color: (index % 2 === 1) ? "#f1f2f2" : "#ffffff"

                    RowLayout{
                        anchors.fill: parent
                        spacing: 0
                        layoutDirection: Qt.RightToLeft

                        //-- Account Icon --//
                        Label{
                            Layout.preferredWidth: 100
                            Layout.fillHeight: true

                            topPadding: 10

                            verticalAlignment: Qt.AlignTop
                            horizontalAlignment: Qt.AlignHCenter

                            text: Icons.account_circle_outline
                            font.family: webfont.name
                            font.pixelSize: Qt.application.font.pixelSize * 6
                            color: "#333333"
                        }


                        Rectangle{
                            Layout.fillWidth: true
                            Layout.fillHeight: true

                            color: "transparent"

                            ColumnLayout{
                                anchors.fill: parent
                                spacing: 0

                                //-- Top Section (UserName and Date) --//
                                Rectangle{
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 40

                                    color: "transparent"

                                    //-- UserName --//
                                    Label{
                                        id: lbl_UserName
                                        text: "UserName"
                                        font.family: segoeUI.name
                                        font.pixelSize: Qt.application.font.pixelSize * 1.1
                                        anchors.right: parent.right
                                        anchors.rightMargin: 15
                                        anchors.verticalCenter: parent.verticalCenter

                                        color: Util.color_BaseBlue
                                    }

                                    //-- Date --//
                                    Label{
                                        id:lbl_Date
//                                        text: "2020/08/08   12:03"
                                        text: Qt.formatDateTime(new Date(), "yyyy/MM/dd   h:mm")
                                        font.family: segoeUI.name
                                        font.pixelSize: Qt.application.font.pixelSize * 1.1
                                        anchors.left: parent.left
                                        anchors.leftMargin: 15
                                        anchors.verticalCenter: parent.verticalCenter
                                    }
                                }

                                //-- Middle Section (Comment) --//
                                Rectangle{
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: lbl_Comment.implicitHeight
                                    color: "transparent"

                                    //-- Comment Texts --//
                                    Label{
                                        id: lbl_Comment
                                        width: parent.width
                                        height: implicitHeight
                                        anchors.left: parent.left
                                        anchors.leftMargin: 15
                                        wrapMode: Text.WordWrap
                                        text: model.text

                                        font.family: iranSans.name
                                        font.pixelSize: Qt.application.font.pixelSize
                                    }

                                }

                                //-- Bottom Section (Reply and Like and DissLike) --//
                                Rectangle{
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 40

                                    color: "transparent"

                                    RowLayout{
                                        anchors.fill: parent
                                        spacing: 0
                                        layoutDirection: Qt.RightToLeft

                                        //-- Reply Icon --//
                                        Label{
                                            Layout.fillHeight: true
                                            Layout.preferredWidth: height

                                            verticalAlignment: Qt.AlignVCenter
                                            horizontalAlignment: Qt.AlignHCenter

                                            text: Icons.chevron_down
                                            font.family: webfont.name
                                            font.pixelSize: Qt.application.font.pixelSize * 1.7
                                            color: "#333333"

                                            MouseArea{
                                                anchors.fill: parent
                                                onClicked: {
                                                    if (!reply_rec.visible){
                                                        reply_sec.visible = !reply_sec.visible
                                                        if (reply_sec.visible){
                                                            delegate_rec.height += 100}
                                                        else{
                                                            delegate_rec.height -= 100}
                                                    }
                                                }
                                            }
                                        }

                                        //-- Reply --//
                                        Label{
                                            id: lbl_Reply

                                            Layout.fillHeight: true
                                            Layout.preferredWidth: implicitWidth + 20

                                            verticalAlignment: Qt.AlignVCenter
                                            horizontalAlignment: Qt.AlignHCenter


                                            text: "Reply"
                                            font.family: segoeUI.name
                                            font.pixelSize: Qt.application.font.pixelSize * 1.1

                                            color: "#333333"

                                            MouseArea{
                                                anchors.fill: parent
                                                onClicked: {
                                                    if (!reply_rec.visible){
                                                        reply_sec.visible = !reply_sec.visible
                                                        if (reply_sec.visible){
                                                            delegate_rec.height += 100}
                                                        else{
                                                            delegate_rec.height -= 100}
                                                    }
                                                }
                                            }
                                        }

                                        //-- Filler --//
                                        Item {
                                            Layout.fillWidth: true
                                        }

                                        //-- Like Icon --//
                                        Label{
                                            Layout.fillHeight: true
                                            Layout.preferredWidth: height

                                            verticalAlignment: Qt.AlignVCenter
                                            horizontalAlignment: Qt.AlignHCenter

                                            text: Icons.thumb_up_outline
                                            font.family: webfont.name
                                            font.pixelSize: Qt.application.font.pixelSize * 1.7
                                            color: "#333333"

                                            MouseArea{
                                                anchors.fill: parent
                                                cursorShape: Qt.PointingHandCursor

                                                onClicked: {

                                                }
                                            }
                                        }

                                        //-- Like Number --//
                                        Label{
                                            id: lbl_Like

                                            Layout.fillHeight: true
                                            Layout.preferredWidth: implicitWidth + 20
                                            Layout.leftMargin: 15

                                            verticalAlignment: Qt.AlignVCenter
                                            horizontalAlignment: Qt.AlignHCenter


                                            text: "0"
                                            font.family: segoeUI.name
                                            font.pixelSize: Qt.application.font.pixelSize * 1.1

                                            color: "#333333"
                                        }


                                    }
                                }

                                //-- Reply Section --//
                                Rectangle{
                                    id: reply_rec
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    visible: false

                                    color: "transparent"

                                    RowLayout{
                                        anchors.fill: parent
                                        spacing: 0

                                        //-- Spacer --//
                                        Item{
                                            width: 100
                                        }

                                        Rectangle{
                                            Layout.fillWidth: true
                                            Layout.fillHeight: true

                                            color: "transparent"
                                            ColumnLayout{
                                                anchors.fill: parent
                                                spacing: 0
                                                //-- Top Section of reply (UserName and Date) --//
                                                Rectangle{
                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 40

                                                    color: "transparent"

                                                    //-- UserName --//
                                                    Label{
                                                        id: lbl_UserName_reply
                                                        text: "UserName"
                                                        font.family: segoeUI.name
                                                        font.pixelSize: Qt.application.font.pixelSize * 1.1
                                                        anchors.right: parent.right
                                                        anchors.rightMargin: 15
                                                        anchors.verticalCenter: parent.verticalCenter

                                                        color: Util.color_BaseBlue
                                                    }

                                                    //-- Date --//
                                                    Label{
                                                        id:lbl_Date_reply
//                                                        text: "2020/08/08   12:03"
                                                        text: Qt.formatDateTime(new Date(), "yyyy/MM/dd   h:mm")
                                                        font.family: segoeUI.name
                                                        font.pixelSize: Qt.application.font.pixelSize * 1.1
                                                        anchors.left: parent.left
                                                        anchors.leftMargin: 15
                                                        anchors.verticalCenter: parent.verticalCenter
                                                    }

                                                }

                                                //-- Middle Section (Reply) --//
                                                Rectangle{
                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: lbl_Reply_text.implicitHeight
                                                    color: "transparent"

                                                    //-- Reply Texts --//
                                                    Label{
                                                        id: lbl_Reply_text
                                                        width: parent.width
                                                        height: implicitHeight
                                                        anchors.left: parent.left
                                                        anchors.leftMargin: 15
                                                        wrapMode: Text.WordWrap
                                                        text: model.reply_text

                                                        font.family: iranSans.name
                                                        font.pixelSize: Qt.application.font.pixelSize
                                                    }

                                                }

                                                //-- Bottom Section (Like and DissLike) --//
                                                Rectangle{
                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 40

                                                    color: "transparent"

                                                    RowLayout{
                                                        anchors.fill: parent
                                                        spacing: 0
                                                        layoutDirection: Qt.RightToLeft

                                                        //-- Filler --//
                                                        Item {
                                                            Layout.fillWidth: true
                                                        }

                                                        //-- Like Icon --//
                                                        Label{
                                                            Layout.fillHeight: true
                                                            Layout.preferredWidth: height

                                                            verticalAlignment: Qt.AlignVCenter
                                                            horizontalAlignment: Qt.AlignHCenter

                                                            text: Icons.thumb_up_outline
                                                            font.family: webfont.name
                                                            font.pixelSize: Qt.application.font.pixelSize * 1.7
                                                            color: "#333333"

                                                            MouseArea{
                                                                anchors.fill: parent
                                                                cursorShape: Qt.PointingHandCursor

                                                                onClicked: {

                                                                }
                                                            }
                                                        }

                                                        //-- Like Number --//
                                                        Label{
                                                            id: lbl_Like_Reply

                                                            Layout.fillHeight: true
                                                            Layout.preferredWidth: implicitWidth + 20
                                                            Layout.leftMargin: 15

                                                            verticalAlignment: Qt.AlignVCenter
                                                            horizontalAlignment: Qt.AlignHCenter


                                                            text: "0"
                                                            font.family: segoeUI.name
                                                            font.pixelSize: Qt.application.font.pixelSize * 1.1

                                                            color: "#333333"
                                                        }


                                                    }
                                                }
                                            }
                                        }

                                    }

                                }

                                //-- Send Reply --//
                                Rectangle{
                                    id: reply_sec
                                    Layout.fillWidth: parent.width
                                    Layout.preferredHeight: 100
                                    visible: false

                                    color: (index % 2 === 1) ? "#f1f2f2" : "#ffffff"

                                    Rectangle{
                                        id: rect_Reply
                                        width: parent.width - 150
                                        height: parent.height - 20

                                        border.width: 1
                                        border.color: "#bbbbbb"

                                        anchors.verticalCenter: parent.verticalCenter
                                        anchors.right: parent.right
                                        anchors.rightMargin: 10


                                        Flickable{
                                            id: flick_txaReply
                                            width: parent.width - 5
                                            height: parent.height - 5

                                            anchors.verticalCenter: parent.verticalCenter
                                            anchors.horizontalCenter: parent.horizontalCenter

                                            flickableDirection: Flickable.VerticalFlick
                                            interactive: false

                                            clip: true


                                            TextArea.flickable: TextArea{
                                                id: txa_Reply

                                                rightPadding: 20
                                                leftPadding: 20

                                                wrapMode: TextArea.Wrap
                                                clip: true

                                                placeholderText: "  متن پیام ..."
                                                horizontalAlignment: Qt.AlignRight

                                                font.family: iranSans.name
                                                font.pixelSize: Qt.application.font.pixelSize * 1.2

                                                background: Rectangle{
                                                    color: "#ffffff"
                                                }

                                            }

                                            ScrollBar.vertical: ScrollBar {}
                                        }



                                    }

                                    Rectangle{

                                        width: parent.width - rect_Reply.width - 40
                                        height: 40
                                        radius: 5
                                        color: Util.color_BaseBlue

                                        anchors.verticalCenter: parent.verticalCenter
                                        anchors.right: rect_Reply.left
                                        anchors.rightMargin: 15

                                        Label{
                                            text: "ارسال"
                                            font.family: iranSans.name
                                            font.pixelSize: Qt.application.font.pixelSize * 1.2

                                            anchors.centerIn: parent
                                            color: "#ffffff"
                                        }

                                        MouseArea{
                                            anchors.fill: parent
                                            onClicked: {
                                                comment_model.setProperty(index, "reply_text", txa_Reply.text)
                                                reply_rec.visible = true
                                                reply_sec.visible = false
                                            }
                                        }

                                    }
                                }
                            }
                        }

                    }


                }
            }

            //-- Line --//
            Rectangle{
                Layout.fillWidth: true
                Layout.preferredHeight: 2
                color: "gray"
            }

            //-- Send Comment --//
            Rectangle{
                Layout.fillWidth: parent.width
                Layout.preferredHeight: 100

                //                color: "#55ff0000"

                Rectangle{
                    id: rect_Comment
                    width: parent.width - 150
                    height: parent.height - 20

                    border.width: 1
                    border.color: "#bbbbbb"

                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 10


                    Flickable{
                        id: flick_txaComment
                        width: parent.width - 5
                        height: parent.height - 5

                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter

                        flickableDirection: Flickable.VerticalFlick
                        interactive: false

                        clip: true


                        TextArea.flickable: TextArea{
                            id: txa_Comment

                            rightPadding: 20
                            leftPadding: 20

                            wrapMode: TextArea.Wrap
                            clip: true

                            placeholderText: "  متن پیام ..."
                            horizontalAlignment: Qt.AlignRight

                            font.family: iranSans.name
                            font.pixelSize: Qt.application.font.pixelSize * 1.2

                            background: Rectangle{
                                color: "#ffffff"
                            }

                        }

                        ScrollBar.vertical: ScrollBar {}
                    }



                }

                Rectangle{

                    width: parent.width - rect_Comment.width - 40
                    height: 40
                    radius: 5
                    color: Util.color_BaseBlue

                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: rect_Comment.left
                    anchors.rightMargin: 15

                    Label{
                        text: "ارسال"
                        font.family: iranSans.name
                        font.pixelSize: Qt.application.font.pixelSize * 1.2

                        anchors.centerIn: parent
                        color: "#ffffff"
                    }

                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            comment_model.append({
                                                     "text": txa_Comment.text,
                                                     "reply_text": ""
                                                 })
                            txa_Comment.clear()

                        }
                    }

                }
            }
        }

    }

}
