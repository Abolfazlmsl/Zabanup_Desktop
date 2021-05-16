import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.13

import "./../../Utils/Utils.js" as Utils
import "./../../Utils/ConvertRTFtoPlain.js" as ConvertRTFtoPlain
import "./../../Modules"

Item {
    id: rootQ
    width: parent.width
    height: qHeight

    property var sourceObj
    property var mainObj: []
    property var questionSplit : []
    property var questionText: ""
    property var questionCount
    property int qNumber: 0
    property int ques_num
    property var qnumber

    onSourceObjChanged: {
        mainObj.push(JSON.parse(sourceObj))

        questionText = ConvertRTFtoPlain.rtfToPlain(mainObj[0]['questions'][0]['text'])

        questionSplit = questionText.split(" ")

        questionCount = 0
        for(var i =  0 ; i < questionSplit.length ; i++) if(questionSplit[i] === "_BLANK") questionCount++;


        console.log("questionCount = " , questionCount)
        //log("-=-=-=-data: " + JSON.stringify(sourceObj))
        //log(sourceObj.questions.length)
    }

    property alias sizeR: slider_size.value
    property var qFont: nunito_italic.name
    property int qHeight: lv_options.contentHeight

    property real sizeRatio: 2.0

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
            Layout.rightMargin: 10
            Layout.preferredHeight: 500//lv_options.contentHeigh
            spacing: 0

            model: 1
            interactive: false

            delegate: Rectangle{
                width: parent.width
                height: mdrop.qHeight

                color: "transparent"

                BlankQuestion{
                    id: mdrop
                    qNumber: qnumber - 2//sourceObj.questions[index].number
                    sizeR: slider_size.value
                    textList: questionSplit//sourceObj.questions[index].lable
                    //text2: ""//sourceObj.questions[index].lable2

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
