import QtQuick 2.12
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.0

Item {
    property alias subjText: lbl_Subj.text
    property alias btnColor: btnSubject.color
    property alias lblColor: lbl_Subj.color
    signal clickSubjectFilter
    onClickSubjectFilter: {
        console.log(subjText)
    }

    DropShadow {
        anchors.fill: btnSubject
        transparentBorder: true
        horizontalOffset: 2
        verticalOffset: 2
        spread: 0.0
        radius: 10
        samples: 40
        color: "#cccccc"
        source: btnSubject
    }

    Rectangle {
        id: btnSubject

        width: parent.width
        height: parent.height

        border.color: "#cccccc"
        border.width: 1

        color: "#ffffff"

        /*layer.enabled: true
        layer.effect: DropShadow {
            verticalOffset: 3
            horizontalOffset: 3
            color: "#cccccc"
            radius: 10
            samples: 40
        }*/

        Label{
            id: lbl_Subj
            width: parent.width - 20
            height: parent.height
            anchors.horizontalCenter: parent.horizontalCenter
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "TEST"
            font.family: iranSans.name
            fontSizeMode: Text.Fit
            minimumPixelSize: 1
            font.pixelSize: Qt.application.font.pixelSize * 1
            font.bold: true
        }


        ItemDelegate{
            anchors.fill: parent
            onClicked: {
                clickSubjectFilter()

            }

        }



    }
}

