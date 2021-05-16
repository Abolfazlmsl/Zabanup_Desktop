import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Window 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

import "./../../../Fonts/Icon.js" as Icons
import "./../../Utils/Enum.js" as Enum
import "./../../Utils/Utils.js" as Util
import "./../Dashboard"
import "./../../Utils"

Item {

    objectName: "Dictionary"

    property real dashboard_ShadowPracticeSpread: 0.0
    property real dashboard_ShadowPracticeRadius: 9

    property real dashboard_ShadowLearnSpread: 0.0
    property real dashboard_ShadowLearnRadius: 9

    property real dashboard_ShadowActivitiesSpread: 0.0
    property real dashboard_ShadowActivitiesRadius: 9

    property real dashboard_ShadowHelpSpread: 0.0
    property real dashboard_ShadowHelpRadius: 9


    Page{
        anchors.fill: parent

        RowLayout{
            anchors.fill: parent

            //-- left section --//
            Rectangle{
                Layout.fillHeight: true
                Layout.fillWidth: true

                color: "#00ff0000"

                //-- container --//
                Rectangle{
                    width: parent.width * 0.96
                    height: parent.height * 0.98
                    anchors.centerIn: parent

                    color: Util.color_white

                    //-- logo and intro -//
                    Rectangle{
                        id: rec_head_activity

                        height: parent.height * 0.16
                        width: parent.width + (20 * ratio)
                        color: "#00000000"

                        //-- red background --//
                        Canvas{
                            id: mycanvas
                            anchors.fill: parent

                            layer.enabled: true
                            layer.effect: DropShadow {
                                verticalOffset: 3
                                horizontalOffset: 3
                                color: Util.color_StatusBar
                                samples: 40
                            }


                            onPaint: {
                                var ctx = getContext("2d");

                                //-- set red color --//
                                ctx.fillStyle = Util.color_Tile_activity

                                //-- shadow --//
//                                ctx.shadowBlur = 10;
//                                ctx.shadowOffsetX = 3;
//                                ctx.shadowOffsetY = 3;
//                                ctx.shadowColor = Util.color_StatusBar;

                                var margin = 5;
                                var x1 = 0 + margin;
                                var x2 = width - margin;
                                var y1 = 0 + margin;
                                var y2 = height - ctx.shadowOffsetY*2;
                                var y3 = height * 0.8;

                                //-- draw polygon path --//
                                // x1, y1
                                //  _________ x2,y1
                                // |        |
                                // |        |
                                // |________|
                                // x1,y3   x2,y2
                                //
                                ctx.beginPath();
                                ctx.moveTo(x1, y1);
                                ctx.lineTo(x2, y1);
                                ctx.lineTo(x2, y2);
                                ctx.lineTo(x1, y3);
                                ctx.lineTo(x1, y1);
                                ctx.closePath();
                                ctx.fill();
                            }

                        }

                        //-- account section --//
                        Image {
                            id: img_account2
                            source: "qrc:/Content/Images/Utils/Dictionary.png"

                            anchors.right: parent.right
                            anchors.rightMargin: 20 * ratio
                            anchors.top: parent.top
                            anchors.topMargin: 20 * ratio
                            sourceSize.height: mycanvas.height * 0.6
                            fillMode: Image.PreserveAspectFit

                        }

                        //-- title --//
                        Label{
                            text: "متن لغت انتخاب شده"
                            color: Util.color_white
                            font.family: font_iransMedium.name
                            font.pixelSize: Qt.application.font.pixelSize * 2
                            renderType: Text.NativeRendering

                            anchors.right: img_account2.left
                            anchors.rightMargin: 8 * ratio
                            anchors.verticalCenter: img_account2.verticalCenter
                        }
                    }

                    //-- activity buttons -//
                    Rectangle{
                        width: parent.width * 1.0
                        height: parent.height - rec_head_activity.height
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: parent.bottom

                        color: "#00ff0000"

                        ScrollView {
                            id: viewtext
                            anchors.fill: parent

                            TextArea {
                                text: ",mzxdncvb,mznxbvczx,fghnvalksjdfghvkxjzncbvm,bxzncvm,.bxzcvmz,.mfbnv,.amfdsngl;kjsandgkjncgv,.mzxncv,.n"
                                font.pixelSize: Qt.application.font.pixelSize * 1.5
                                wrapMode: TextEdit.Wrap
                            }
                        }


                    }
                }
            }

            //-- right section --//
            Rectangle{
                Layout.fillHeight: true
                Layout.preferredWidth: parent.width * 0.3

                color: "#0000ff00"

                //-- container --//
                Rectangle{
                    anchors.fill: parent
                    anchors.margins: 10

                    color: Util.color_white

                    layer.enabled: true
                    layer.effect: DropShadow {
                        verticalOffset: 3
                        horizontalOffset: 3
                        color: Util.color_StatusBar
                        samples: 70
                    }

                    ColumnLayout{
                        anchors.fill: parent
                        anchors.margins: 10


                        M_inputText{

                            label: ""
                            icon: Icons.magnify
                            placeholder: "جست و جو"
                            iconColor: Util.color_Tile_activity
                            borderColor: Util.color_Tile_activity

                            onAccepted:{

                            }
                        }

                        Item { Layout.preferredHeight: 8 } //-- spacer --//

                        Label{
                            text: "نتایج:"
                            Layout.alignment: Qt.AlignRight
                            Layout.rightMargin: 6
                            font.pixelSize: Qt.application.font.pixelSize * 1.5
                        }

                        Item { Layout.preferredHeight: 8 } //-- spacer --//

                        ListView{
                            id: lv_dictionaryResualt

                            Layout.fillHeight: true
                            Layout.fillWidth: true

                            //-- back of ScrollBar --//
                            Rectangle{
                                id: itm_scroll
                                height: parent.height
                                width: 6
                                color: "#00a0a0a0"
                                anchors.right: parent.right
                                anchors.rightMargin: -4

                            }

                            ScrollBar.vertical: ScrollBar {
                                id: scrollBarVertical
                                parent: lv_dictionaryResualt
                                anchors.fill: itm_scroll
                            }

                            model: 40

                            delegate: ItemDelegate{
                                width: parent.width
                                height: lbl_resualt.implicitHeight * 1.6

                                Label{
                                    id: lbl_resualt
                                    text: "نتیجه 1"
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.right: parent.right
                                    anchors.rightMargin: 10
                                    font.pixelSize: Qt.application.font.pixelSize * 1.3
                                }

                                //-- sperator line --//
                                Rectangle{
                                    width: parent.width
                                    height: 1
                                    anchors.bottom: parent.bottom
                                    color: Util.color_TopBar
                                }
                            }

                        }

                    }

                }


            }
        }
    }

}
