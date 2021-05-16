import QtQuick 2.0
import QtQuick.Controls 2.5
import "Utils.js" as Utils


Label{

    width: 20
    height: width
    text: "1"
    font.family: segoeUI.name
    font.bold: true
    font.pixelSize: lbl_size.font.pixelSize
    color: Utils.color_Question_number

    verticalAlignment: Qt.AlignVCenter
    horizontalAlignment: Qt.AlignHCenter

    background: Rectangle{
        radius: width / 2
       border.color: Utils.color_Question_number
       border.width: 1
    }

    ItemDelegate{
        anchors.fill: parent
    }
}
