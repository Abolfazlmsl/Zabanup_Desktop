import QtQuick 2.0
import QtQuick.Controls 2.2

Rectangle{
    id: btnCat

    property alias text: selectTest_btnCategory.text
    property alias btnColor: btnCat.color

    signal btnCatClicked

    width: selectTest_btnCategory.implicitWidth + (20 * ratio)
    height: 50
    color: "transparent"


    //-- Category Label --//
    Label{
        id: selectTest_btnCategory

        width: implicitWidth
        height: implicitHeight

        anchors.centerIn: parent

        text: "عنوان"
        font.family: iranSans.name
        font.pixelSize: Qt.application.font.pixelSize * 1.3
        font.bold: true


        color: "#ffffff"
        clip: true
    }

    //-- on Click Category --//
    ItemDelegate{
        anchors.fill: parent
        onPressed: {
            btnCatClicked()
        }

    }
}
