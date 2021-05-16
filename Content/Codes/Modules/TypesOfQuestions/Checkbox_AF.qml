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

    property var ques_num
    property var qnumber
    property var totalnumber
    property var sourceObj
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
//        console.log(key + "  " + status)
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

        var answer = ""
        for(var k = 0 ; k < answerSend.length ; k++){
            if (k===0){
                answer = answer + answerSend[k]
            }else{
                answer = answer + "," + answerSend[k]
            }
        }


        fillAnswer(qnumber-ques_num+1, answer)
//        print(JSON.stringify(answerArray))


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

            property var answerCheck: ["","","","","",""]
            onAnswerCheckChanged: {

            }

            Component.onCompleted: {
                var temp = model_ans.get(parseInt(sourceObj.questions[0].number)-1).answer
                answerCheck[0] = temp.indexOf("A") > -1 ? "A" : ""
                answerCheck[1] = temp.indexOf("B") > -1 ? "B" : ""
                answerCheck[2] = temp.indexOf("C") > -1 ? "C" : ""
                answerCheck[3] = temp.indexOf("D") > -1 ? "D" : ""
                answerCheck[4] = temp.indexOf("E") > -1 ? "E" : ""
                answerCheck[5] = temp.indexOf("F") > -1 ? "F" : ""
                //                log("-- answerCheck change to " + answerCheck)
            }

            Layout.fillWidth: true
            Layout.margins: 5
            Layout.preferredHeight: 500//lv_options.contentHeigh
            spacing: 20
            cacheBuffer: 1000

            model: totalnumber
            interactive: false

            delegate: Flow{
                id: flw
                width: parent.width
                height: implicitHeight
                spacing: 5

                property int flw_indx: index

                QstNumber{
                    visible: false
                    id: qNumber
                    text: index + 1
                }

                Rectangle{
                    width: qNumber.height
                    height: qNumber.height
                    color: "transparent"


                    CheckBox {
                        id: control
                        anchors.centerIn: parent
                        checked: answerArray[index]['isSelected']

                        Component.onCompleted: {
                            checkBoxArray.push(control)
                        }

                        indicator: Rectangle {
                            implicitWidth: qNumber.height
                            implicitHeight: qNumber.height
                            x: control.leftPadding
                            y: parent.height / 2 - height / 2
                            radius: 3
                            border.color: control.down ? "#17a81a" : "#21be2b"

                            Label{
                                width: qNumber.height
                                height: qNumber.height
                                text: Icons.check
                                font.bold: true
                                minimumPixelSize: 5
                                font.pixelSize: Qt.application.font.pixelSize *2
                                fontSizeMode: Text.Fit
                                font.family: webfont.name
                                verticalAlignment: Qt.AlignVCenter
                                horizontalAlignment: Qt.AlignHCenter
                                //x: 3
                                //y: 3
                                color: control.down ? "#17a81a" : "#21be2b"
                                visible: control.checked
                            }
                        }

                        onCheckedChanged: {
                            triggerCheck(index , control.checked)
                        }

                        onClicked: {
                            return
                        }
                        onDoubleClicked: {
                            return
                        }
                    }

                }

                Repeater{
                    id: rpt
                    model: questionTextWords[flw.flw_indx]['words'].length

                    Text {
                        id: txt
                        text: questionTextWords[flw.flw_indx]['words'][index]
                        font.pixelSize: lbl_size.font.pixelSize
                    }
                }

            }
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
