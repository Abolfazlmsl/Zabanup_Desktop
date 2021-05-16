import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.13

import "./../../Utils/Utils.js" as Utils

import "./../../Modules"

Item {
    id: rootQ
    width: parent.width
    height: 100

    property var sourceObj
    property var ques_range
    property var ques_num
    property var mainObj: []
    property var mainDescription: ""
    property var choices: []
    onSourceObjChanged: {
        mainObj.push(JSON.parse(sourceObj))

        var tempText = mainObj[0].text

        tempText = mainObj[0].text.slice(mainObj[0].text.indexOf('_YESNONOTGIVEN') , mainObj[0].text.length)
        tempText = tempText.slice(tempText.indexOf('</p>') + 4 , tempText.length)

        mainDescription = mainObj[0].text.slice(0 , mainObj[0].text.indexOf('_YESNONOTGIVEN'))
        mainDescription = mainDescription.slice(0 , mainDescription.lastIndexOf('<p>'))

        var counter = 0
        while(tempText.indexOf('<p>') !== -1){
            choices.push(tempText.slice(tempText.indexOf('<p>') , tempText.indexOf('</p>') + 4))
            tempText = tempText.replace(choices[counter] , "")
            counter++;
        }

        for(var j = 0 ; j < choices.length ; j++){
            console.log(j + "     " + choices[j])
        }


        //log("-=-=-=-data: " + JSON.stringify(sourceObj))
        //log(sourceObj.questions.length)
    }

    property alias sizeR: slider_size.value
    property var qFont: nunito_italic.name
    property int qHeight: lbl_head.implicitHeight*2 + mdl_Notepad.height + lbl_description.implicitHeight
                          + lv_table.contentHeight
    property real sizeRatio: 2.0

    signal pressedb()

    //-- back color test --//
    Rectangle{
        visible: false
        anchors.fill: parent
        color: "red"
    }

    //-- size porpos --//
    Label{id: lbl_size; visible: false; text: "Not Given"; font.pixelSize: Qt.application.font.pixelSize*sizeRatio}

    //-- body --//
    ColumnLayout{
        id: colbody

        anchors.fill: parent

        //-- question lable --//
        Label{
            id: lbl_head

            text: "Questions " + ques_num + " - " + ques_range
            font.pixelSize: lbl_size.font.pixelSize * 1.2
            font.bold: true
            font.family: qFont
            renderType: Text.NativeRendering
        }

        Notepad{
            id: mdl_Notepad
        }

        //-- description --//
        Label{
            id: lbl_description

            text: mainDescription
            font.pixelSize: lbl_size.font.pixelSize * 1.0
            font.family: qFont
            renderType: Text.NativeRendering
            wrapMode: Text.WordWrap
            Layout.fillWidth: true
            textFormat: Text.RichText
        }

        //-- table --//
        ListView{
            id: lv_table

            Layout.fillWidth: true
            Layout.margins: 5
            Layout.preferredHeight: lv_table.contentHeight //lbl_size.implicitHeight * 2 * sourceObj.Table.length

            model: choices.length
            interactive: false
            //-- descriptions --//
            delegate: Label{
                    id: lbl_table_descript
                    width: parent.width
                    height: implicitHeight + 20
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                    anchors.right: parent.right
                    anchors.rightMargin: 5
                    leftPadding: 20
                    verticalAlignment: Qt.AlignBottom
                    horizontalAlignment: Qt.AlignLeft

                    text: choices[index]

                    font.pixelSize: lbl_size.font.pixelSize * 1.0
                    font.family: qFont
                    renderType: Text.NativeRendering
                    wrapMode: Text.WordWrap

                    background: Rectangle{
                        width: parent.width
                        height: parent.height
                        color: index%2 ? "transparent" : "#556C88B7"
                    }

                }

        }

    }

    //-- (unchange) chabge size fo test --//
    Slider{
        visible: false
        id: slider_size
        anchors.right: parent.right
        from: 1
        to: 4
        stepSize: 0.5
        Label{ text: parent.value }
        onValueChanged: { sizeRatio = value }
    }

}
