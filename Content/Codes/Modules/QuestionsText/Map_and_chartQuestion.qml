import QtQuick 2.14
import QtQuick.Window 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.12
import QtQml.Models 2.14

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
    property var mainObj: []
    property var questionTextWords: []
    property var trArray: []
    property var tdArray: []
    property var temp: []
    property int num: 0
    property var questionText: ""
    property var inputsArray: []
    property var answerArray : []

    signal getAnswer // جهت پاس دادن جواب ها به جای مدنظر
    onGetAnswer: {
        answerArray = []

        for(var i=0; i< inputsArray.length; i++){
            answerArray.push({"number" : inputsArray[i]['number'] , "answer" : inputsArray[i]['answerText']['text']})
        }

        //-- sort array --//
        answerArray.sort(function(a, b){return a.number - b.number})

        console.log("ANSWER ARRAY = " , JSON.stringify(answerArray))

    }

    //-- model for save rows --//
    ListModel{ id: model_1}

    onSourceObjChanged: {
        mainObj.push(JSON.parse(sourceObj))
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
