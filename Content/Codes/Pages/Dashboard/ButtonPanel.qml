import QtQuick 2.0
import QtQuick.Controls 2.2

Rectangle{
    id: root

    property alias icon: rightMenu_DashboardIcon.text
    property alias text: rightMenu_DashboardLabel.text
    property alias iconColor: rightMenu_DashboardIcon.color

    property real iconWidth: rightMenu_DashboardIcon.width + (24 * ratio)

    signal btnClicked

    width: 100
    height: 50
    color: "transparent"

    //-- Dashboard Icon --//
    Label{
        id:rightMenu_DashboardIcon

        width: parent.height - 15 * ratio
        height: parent.height

        anchors.right: parent.right
        anchors.rightMargin: 12 * ratio

        text: "/u1212" //Icons.home_outline

        font.family: webfont.name
        font.pixelSize: 72//Qt.application.font.pixelSize
        minimumPixelSize: 10
        fontSizeMode: Text.Fit

        horizontalAlignment: Qt.AlignHCenter
        verticalAlignment: Qt.AlignVCenter

        color: "#ffffff"
    }

    //-- Dashboard Label --//
    Label{
        id: rightMenu_DashboardLabel

        width: parent.width - rightMenu_DashboardIcon.width - (20 * ratio)
        height: parent.height * 0.7

        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter

        text: "عنوان"
        font.family: iranSans.name
        minimumPointSize: 10
        fontSizeMode: Text.Fit
        font.pixelSize: Qt.application.font.pixelSize * 1.3

        horizontalAlignment: Qt.AlignRight
        verticalAlignment: Qt.AlignVCenter

        color: rightMenu_DashboardIcon.color
        clip: true
        elide: Text.ElideRight
    }

    //-- on Click Dashboard --//
    ItemDelegate{
        anchors.fill: parent
        onPressed: {
            btnClicked()
        }

    }
}
