import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.13

import "./../../Utils"
import "./../../Utils/Utils.js" as Utils
import "./../../Utils/ConvertRTFtoPlain.js" as ConvertRTFtoPlain
import "./../../Modules"
import "./../../../Fonts/Icon.js" as Icons

Item {
    id: rootQ
    width: parent.width
    height: qHeight

    property var sourceObj
    property var ques_range
    property var ques_num
    property var mainObj: []
    property var questionCount
    property var questionTextWords: []
    property var sampleAnswer: ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O']
    property var answerSend: [] // این آرایه برای ارسال جواب است
    property var checkBoxArray: []
    property var answerCount // برای ذخیره تعداد جواب هایی که می تواند انتخاب شود . مثلا بعضی اوقات ممکن است 2 جواب باشد و گاهی 3 جواب (db => choices)
    property var answerArray: []

    signal triggerCheck(var key, var status)
    onTriggerCheck: {
        console.log(key + "  " + status)
        answerArray[key]['isSelected'] = status
        //console.log("answerArray[key]['isSelected'] = " , answerArray[key]['isSelected'])
        var counter = 0
        for(var i=0; i < answerArray.length; i++){
             if(answerArray[i]['isSelected'] === true)
                 counter++
        }

        if(counter > answerCount){
            answerArray[key]['isSelected'] = false
            checkBoxArray[key].checked = false
            //console.log("IN IF" , JSON.stringify(answerArray) , "   " , checkBoxArray[key].checked)
        }
        answerSend = []
        for(var j=0; j < answerArray.length; j++){
             if(answerArray[j]['isSelected'] === true)
                 answerSend.push(sampleAnswer[j])

        }

        for(var k = 0 ; k < answerSend.length ; k++){
            console.log("answerSend[" + k + "] = " , answerSend[k])
        }


        print(JSON.stringify(answerArray))


    }

    onSourceObjChanged: {
        mainObj.push(JSON.parse(sourceObj))
        //questionText = ConvertRTFtoPlain.rtfToPlain(mainObj[0]['questions'][0]['text'])

        questionCount = mainObj[0]['questions'].length
        answerCount = mainObj[0]['number_of_choices']

        for(var i=0; i < mainObj[0]['questions'].length; i++){
            mainObj[0]['questions'][i]['text']= ConvertRTFtoPlain.rtfToPlain(mainObj[0]['questions'][i]['text'])
            questionTextWords.push({"id": i , "words": mainObj[0]['questions'][i]['text'].split(" ")})

            answerArray.push({"isSelected": false})

            //console.log(JSON.stringify(questionTextWords))
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

            text: "Questions " + ques_num + " - " + ques_range //sourceObj.question_lable
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

    //-- (unchange) chabge size for test --//
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
