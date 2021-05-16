import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Window 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

import "./../../../Fonts/Icon.js" as Icons

Item {
    objectName: "SettingsPage"

    //-- Background --//
    Rectangle{
        anchors.fill: parent
        color: "#ffffff"
    }

    Rectangle{
        width: parent.width / 2
        height: parent.height / 2
        anchors.centerIn: parent

        color: "#5500ff00"

        Label{
            anchors.centerIn: parent
            text: "تنظیمات"
            font.family: iranSans.name
            font.pixelSize: 30
        }
    }
}
