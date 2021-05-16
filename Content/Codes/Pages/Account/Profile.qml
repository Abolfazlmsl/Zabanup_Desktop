import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Window 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

import "./../../../Fonts/Icon.js" as Icons
import "./../../Utils/Enum.js" as Enum
import "./../../Utils/Utils.js" as Util
import "./../../REST/apiService.js" as Service
import "./../Dashboard"

Item {

    objectName: "Profile"

    property real dashboard_ShadowPracticeSpread: 0.0
    property real dashboard_ShadowPracticeRadius: 9

    property real dashboard_ShadowLearnSpread: 0.0
    property real dashboard_ShadowLearnRadius: 9

    property real dashboard_ShadowActivitiesSpread: 0.0
    property real dashboard_ShadowActivitiesRadius: 9

    property real dashboard_ShadowHelpSpread: 0.0
    property real dashboard_ShadowHelpRadius: 9


    signal visitProfile()
    onVisitProfile: {
        console.log("Visit Profile Page")

        checkToken(function(res){

            if(res === true){
                Service.get_data(_token_access , Service.url_userInfo , null , function(res2){
                    console.log("MY DATA : " , JSON.stringify(res2))

                    userInfo = res2

                    fillUserInformation(res2.name , res2.email , _userName)

                })

            }
            else{
                console.log("Please Login !")
            }


        })

    }

    signal fillUserInformation(var name , var email ,var tel)
    onFillUserInformation: {
        console.log("Fill : ", name , email , tel)

        lbl_fullname.text = name
        lbl_emailAddress.text = email
        lbl_cellphone.text = tel

        console.log("after Fill : ", lbl_fullname.text , lbl_emailAddress.text , lbl_cellphone.text)
    }

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
                    width: parent.width * 0.8
                    height: parent.height * 0.8
                    anchors.centerIn: parent

                    color: Util.color_white

                    layer.enabled: true
                    layer.effect: DropShadow {
                        verticalOffset: 3
                        horizontalOffset: 3
                        color: Util.color_StatusBar
                        samples: 70
                    }

                    //-- logo and intro -//
                    Rectangle{
                        id: rec_head_activity

                        height: parent.height * 0.25
                        width: parent.width + (20 * ratio)
                        color: "#00000000"

                        //-- red background --//
                        Canvas{
                            id: mycanvas
                            anchors.fill: parent

                            layer.enabled: true
                            layer.effect: DropShadow {
                                verticalOffset: 3
                                horizontalOffset: 0
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
                                var y3 = height * 0.5;

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
                            source: "qrc:/Content/Images/Utils/activity_big.png"

                            anchors.right: parent.right
                            anchors.rightMargin: 20 * ratio
                            anchors.top: parent.top
                            anchors.topMargin: 20 * ratio
                            sourceSize.height: mycanvas.height * 0.6
                            fillMode: Image.PreserveAspectFit

                        }

                        //-- title --//
                        Label{
                            text: "فعالیت ها"
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
                        width: parent.width * 0.8
                        height: parent.height - rec_head_activity.height
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: parent.bottom

                        color: "#00ff0000"

                        Row{
                            anchors.centerIn: parent
                            spacing: 20 * ratio


                            //-- Activities Square --//
                            DashboardButton{
                                Layout.preferredWidth: 280 * widthRatio
                                Layout.preferredHeight: width

                                picSource: "qrc:/Content/Images/Dashborad_Image/Activity.png"
                                title: "مقایسه با سایرین"
                                bgColor: "#1584a7"

                                onDashboard_btnClicked: {
//                                    console.log(title)
                                    //mainPage.state = _BTN_ACTIVITY
//                                    sView.push(Enum._PAGE_Activity)
                                }
                            }


                            //-- Activities Square --//
                            DashboardButton{
                                Layout.preferredWidth: 280 * widthRatio
                                Layout.preferredHeight: width

                                picSource: "qrc:/Content/Images/Dashborad_Image/Activity.png"
                                title: "گزارش ها"
                                bgColor: "#1584a7"

                                onDashboard_btnClicked: {
//                                    console.log(title)
                                    //mainPage.state = _BTN_ACTIVITY
//                                    sView.push(Enum._PAGE_Activity)
                                }
                            }
                        }

                    }
                }
            }

            //-- right section --//
            Rectangle{
                Layout.fillHeight: true
                Layout.fillWidth: true

                color: "#0000ff00"

                //-- container --//
                Rectangle{
                    width: parent.width * 0.8
                    height: parent.height * 0.8
                    anchors.centerIn: parent

                    color: Util.color_white

                    layer.enabled: true
                    layer.effect: DropShadow {
                        verticalOffset: 3
                        horizontalOffset: 3
                        color: Util.color_StatusBar
                        samples: 70
                    }

                    //-- logo and intro -//
                    Rectangle{
                        id: rec_head_accountInfo

                        height: parent.height * 0.25
                        width: parent.width + (20 * ratio)
                        color: "#00000000"

                        //-- red background --//
                        Canvas{
                            id: mycanvas_info
                            anchors.fill: parent

                            layer.enabled: true
                            layer.effect: DropShadow {
                                verticalOffset: 3
                                horizontalOffset: 0
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
                                var y3 = height * 0.5;

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
                            id: img_account
                            source: "qrc:/Content/Images/Utils/account.png"

                            anchors.right: parent.right
                            anchors.rightMargin: 20 * ratio
                            anchors.top: parent.top
                            anchors.topMargin: 20 * ratio
                            sourceSize.height: mycanvas_info.height * 0.6
                            fillMode: Image.PreserveAspectFit

                        }

                        //-- title --//
                        Label{
                            text: "اطلاعات کاربری"
                            color: Util.color_white
                            font.family: font_iransMedium.name
                            font.pixelSize: Qt.application.font.pixelSize * 2
                            renderType: Text.NativeRendering

                            anchors.right: img_account.left
                            anchors.rightMargin: 8 * ratio
                            anchors.verticalCenter: img_account.verticalCenter
                        }
                    }

                    //-- account info -//
                    Rectangle{
                        width: parent.width * 0.6
                        height: parent.height - rec_head_accountInfo.height
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: parent.bottom

                        color: "#00ff0000"

                        ColumnLayout{
                            anchors.fill: parent

                            //-- filler --//
                            Item{Layout.column: 1; Layout.row: 6; Layout.fillHeight: true}

                            //-- fullname --//
                            Item {
                                Layout.fillWidth: true
                                Layout.preferredHeight: lbl_fullname.implicitHeight * 2

                                RowLayout{
                                    anchors.fill: parent

                                    Item{Layout.column: 2; Layout.row: 0; Layout.fillWidth: true} //-- filler --//

                                    //-- full name --//
                                    Label{
                                        id: lbl_fullname
                                        text: userInfo['name'] === '' ? "نامی برای شما ثبت نشده است" : userInfo['name']
                                        font.family: font_irans.name
                                        font.pixelSize: Qt.application.font.pixelSize * 1.5
                                        color: Util.color_RightMenu
                                    }

                                    //-- Account Icon --//
                                    Label{
                                        text: Icons.account_circle
                                        font.family: webfont.name
                                        font.pixelSize: Qt.application.font.pixelSize * 2.0
                                        color: Util.color_RightMenu
                                    }

                                    Item{Layout.column: 2; Layout.row: 0; Layout.fillWidth: true} //-- filler --//
                                }
                            }

                            //-- email --//
                            Item {
                                Layout.fillWidth: true
                                Layout.preferredHeight: lbl_fullname.implicitHeight * 2

                                RowLayout{
                                    anchors.fill: parent

                                    Item{Layout.column: 2; Layout.row: 0; Layout.fillWidth: true} //-- filler --//

                                    //-- email --//
                                    Label{
                                        id: lbl_emailAddress
                                        text: userInfo['email'] === ''? "ایمیلی برای شما ثبت نشده است" : userInfo['email']
                                        font.family: font_irans.name
                                        font.pixelSize: Qt.application.font.pixelSize * 1.5
                                        color: Util.color_RightMenu
                                    }

                                    //-- email Icon --//
                                    Label{
                                        text: Icons.email
                                        font.family: webfont.name
                                        font.pixelSize: Qt.application.font.pixelSize * 2.0
                                        color: Util.color_RightMenu
                                    }

                                    Item{Layout.column: 2; Layout.row: 0; Layout.fillWidth: true} //-- filler --//
                                }
                            }

                            //-- phone --//
                            Item {
                                Layout.fillWidth: true
                                Layout.preferredHeight: lbl_fullname.implicitHeight * 2

                                RowLayout{
                                    anchors.fill: parent

                                    Item{Layout.column: 2; Layout.row: 0; Layout.fillWidth: true} //-- filler --//

                                    //-- phone --//
                                    Label{
                                        id: lbl_cellphone
                                        text: _userName
                                        font.family: font_irans.name
                                        font.pixelSize: Qt.application.font.pixelSize * 1.5
                                        color: Util.color_RightMenu
                                    }

                                    //-- phone Icon --//
                                    Label{
                                        text: Icons.cellphone_android
                                        font.family: webfont.name
                                        font.pixelSize: Qt.application.font.pixelSize * 2.0
                                        color: Util.color_RightMenu
                                    }

                                    Item{Layout.column: 2; Layout.row: 0; Layout.fillWidth: true} //-- filler --//
                                }
                            }

                            //-- spacer --//
                            Item {
                                Layout.fillWidth: true
                                Layout.preferredHeight: lbl_fullname.implicitHeight
                            }

                            Button{
                                text: "ویرایش اطلاعات"
                                Layout.alignment: Qt.AlignHCenter

                                Material.background: Util.color_Material_Blue
                                Material.foreground: Util.color_white

                                onClicked: {
                                    win_accountInfoEdit.show()
                                }
                            }


                            //-- pass change --//
                            Label{
                                text: "ویرایش رمز عبور"
                                font.family: font_irans.name
                                font.pixelSize: Qt.application.font.pixelSize * 1.0
                                color: Util.color_Material_Blue
                                Layout.alignment: Qt.AlignHCenter
                            }


                            //-- filler --//
                            Item{Layout.column: 1; Layout.row: 6; Layout.fillHeight: true}

                        }
                    }

                }


            }
        }
    }

}
