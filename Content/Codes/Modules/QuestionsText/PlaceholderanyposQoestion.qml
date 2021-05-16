import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.13

import "./../../Utils"
import "./../../Utils/Utils.js" as Utils
import "./../../Utils/ConvertRTFtoPlain.js" as ConvertRTFtoPlain
import "./../../Modules"

Item {
    id: rootQ
    width: parent.width
    height: qHeight

    property var sourceObj
    property var ques_range
    property var ques_num
    property int qNumber: 0
    property var mainObj: []
    property var questionCount
    property var questionTextWords: []
    property var wordsList: []
    property var listNumber: [{"listnumber": 0}]


    onSourceObjChanged: {
        mainObj.push(JSON.parse(sourceObj))
        //questionText = ConvertRTFtoPlain.rtfToPlain(mainObj[0]['questions'][0]['text'])

        questionCount = mainObj[0]['questions'].length

        for(var i=0; i < mainObj[0]['questions'].length; i++){
            mainObj[0]['questions'][i]['text']= ConvertRTFtoPlain.rtfToPlain(mainObj[0]['questions'][i]['text'])
            questionTextWords.push({"id": i , "words": mainObj[0]['questions'][i]['text'].split(" ")} )

            for(var j=0; j < mainObj[0]['questions'][i]['text'].split(" ").length; j++){
                if(mainObj[0]['questions'][i]['text'].split(" ")[j] !== "_BLANK")
                    wordsList.push({"word": mainObj[0]['questions'][i]['text'].split(" ")[j]})
                else
                    wordsList.push({"word": mainObj[0]['questions'][i]['text'].split(" ")[j] , "number": ++qNumber})

            }
            listNumber.push({"listnumber": mainObj[0]['questions'][i]['text'].split(" ").length + listNumber[i]["listnumber"]})
        }

        //console.log("questionCount = " , mainObj[0]['questions'][0]['text'])
        //log("-=-=-=-data: " + JSON.stringify(sourceObj))
        //log(sourceObj.questions.length)
    }

    property alias sizeR: slider_size.value
    property var qFont: nunito_italic.name
    property int qHeight: lbl_head.implicitHeight*2 + mdl_Notepad.height + lbl_description.implicitHeight

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

            text: mainObj[0]['text']//sourceObj.description
            font.pixelSize: lbl_size.font.pixelSize * 1.0
            font.family: qFont
            renderType: Text.NativeRendering
            wrapMode: Text.WordWrap
            Layout.fillWidth: true
            textFormat: Text.RichText
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
