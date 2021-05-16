import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

import "./../../../Fonts/Icon.js" as Icons


Rectangle{

    property alias icon: headerIcon.text
    signal btnClick()

    height: parent.height
    width: height

    color: "transparent"

    Label{
        id: headerIcon
        anchors.centerIn: parent

        text: Icons.close
        font.family: webfont.name
        font.pixelSize: Qt.application.font.pixelSize * 2

    }

    ItemDelegate{
        anchors.fill: parent

        onClicked: {
            btnClick()
        }
    }
}
