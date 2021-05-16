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

    property var ques_num
    property var qnumber
    property var sourceObj
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
            spacing: 20

            model: 1
            interactive: false

            delegate: Flow{
                id: flw
                width: parent.width
                height: implicitHeight
                spacing: 5

                property int flw_indx: ques_num - 2

                QstNumber{
                    text: qnumber - 1
                }


                Repeater{
                    id: rpt
                    model: questionTextWords[flw.flw_indx]['words'].length

                    Rectangle{
                        width: txt.implicitWidth + txt_inp.width
                        height: (txt.implicitHeight >= txt_inp.height) ? txt.implicitHeight : txt_inp.height
                        color: "transparent"


                        Text {
                            id: txt
                            visible: (questionTextWords[flw.flw_indx]['words'][index] === "_BLANK") ? false : true
                            text: (questionTextWords[flw.flw_indx]['words'][index] === "_BLANK") ? "" : questionTextWords[flw.flw_indx]['words'][index]
                            font.pixelSize: lbl_size.font.pixelSize
                        }

                        //-- options --//
                        TextInput{
                            id: txt_inp
                            visible: (questionTextWords[flw.flw_indx]['words'][index] === "_BLANK") ? true : false
                            horizontalAlignment: Qt.AlignHCenter
                            font.pixelSize: lbl_size.font.pixelSize
                            width: (questionTextWords[flw.flw_indx]['words'][index] === "_BLANK") ? ((implicitWidth + 20) >= 100) ? (implicitWidth + 20) : 100 : 0
                            selectByMouse: true
                            maximumLength: 45
                            //leftPadding: lbl_QNumber.width + 8
                            clip: true
                            onTextEdited:{
                                fillAnswer(wordsList[index + listNumber[flw.flw_indx]["listnumber"]]['number'], txt_inp.text)
                            }

                            //-- underline --//
                            Rectangle{
                                anchors.fill: parent
                                //anchors.margins: -5
                                anchors.leftMargin: /*lbl_QNumber.width +*/ 3
                                color: "transparent"

                                Rectangle{
                                    width: parent.width; height: 1
                                    color: "#33000000"
                                    anchors.bottom: parent.bottom
                                }
                            }


                        }



                    }

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
