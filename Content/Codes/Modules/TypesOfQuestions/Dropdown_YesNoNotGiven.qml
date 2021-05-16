import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.13

import "./../../Utils/Utils.js" as Utils

import "./../../Modules"

Item {
    id: rootQ
    width: parent.width
    height: 100

    property var question
    property var ques_num
    property var qnumber
    property var sourceObj
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
    property int qHeight: lv_options.contentHeight

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

        //-- options --//
        ListView{
            id: lv_options

            Layout.fillWidth: true
            Layout.margins: 5
            Layout.preferredHeight: 500//lv_options.contentHeigh
            spacing: 0

            model: 1
            interactive: false

            delegate: Rectangle{
                width: parent.width
                height: mdrop.qHeight

                color: "transparent"

                MdropDown{
                    id: mdrop
                    qNumber: qnumber-1//sourceObj.questions[index].number
                    sizeR: slider_size.value
                    qText: mainObj[0]['questions'][ques_num-2]['text']//sourceObj.questions[index].lable
                    qModel: ["", "YES", "NO", "NOT GIVEN"]
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
