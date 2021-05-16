import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.13
import "./../../Utils/Utils.js" as Utils
import "./../../Utils"

Item {
    id: rootQ
    width: parent.width
    height: qHeight

    property int qHeight: flw.implicitHeight + 10 //-- content height of text area module --//
    property alias sizeR: slider_size.value
    property int qNumber: 0//: lbl_QNumber.text
    property real sizeRatio: 2.0
    property var textList : []
    property var inputsArray: []
    property var answerArray: []
    property var wordsList: []

    onTextListChanged: {
        for(var i=0; i< textList.length; i++){
            if(textList[i] !== "_BLANK")
                wordsList.push({"word": textList[i]})
            else
               wordsList.push({"word": textList[i] , "number": ++qNumber})
        }
    }

    signal getAnswer // جهت پاس دادن جواب ها به جای مدنظر
    onGetAnswer: {
        for(var i=0; i< inputsArray.length; i++){
            answerArray.push(inputsArray[i].text)
        }

        for(var j=0; j< answerArray.length; j++){
            print(answerArray[j])
        }
    }

    signal pressedb()

    //-- size porpos --//
    Label{id: lbl_size; visible: false; text: "Not Given"; font.pixelSize: Qt.application.font.pixelSize*sizeRatio}

    Rectangle{
        anchors.fill: parent
        color: "#00FF0000"
    }


    Flow {
        id: flw
        width: parent.width
        height: parent.height

        anchors.margins: 4
        spacing: 5

        Repeater{

            model: wordsList.length
            Rectangle{
                width: txt.implicitWidth + txt_inp.width + lbl_QNumber.width
                height: txt.implicitHeight * 1.5
                color: "transparent"
                Text {
                    id: txt
                    anchors.left: parent.left ;
                    anchors.leftMargin: 10 ;
                    text: (wordsList[index]['word'] === "_BLANK") ? " " : wordsList[index]['word'];
                    font.pixelSize: lbl_size.font.pixelSize
                    anchors.verticalCenter: parent.verticalCenter
                }

                //-- Number --//
                QstNumber{
                    id: lbl_QNumber
                    text:wordsList[index]['number']
                    anchors.left: txt.right
                    visible: (wordsList[index]['word'] === "_BLANK") ? true : false
                    width: (wordsList[index]['word'] === "_BLANK") ? lbl_size.implicitHeight * 1.4 : 0
                    font.pixelSize: lbl_size.font.pixelSize
                }

                //-- options --//
                TextInput{
                    id: txt_inp
                    visible: (wordsList[index]['word'] === "_BLANK") ? true : false
                    Component.onCompleted: {
                        if(wordsList[index]['word'] === "_BLANK"){
                             //print('valid input, ')
                            inputsArray.push(txt_inp)   
                        }
                    }

                    onTextEdited: {
                        fillAnswer(wordsList[index]['number'], txt_inp.text)
                    }

                    anchors.left: lbl_QNumber.right
                    anchors.verticalCenter: parent.verticalCenter
                    horizontalAlignment: Qt.AlignHCenter
                    font.pixelSize: lbl_size.font.pixelSize
                    width: (wordsList[index]['word'] === "_BLANK") ? Math.max((contentWidth /*+ lbl_QNumber.width*/ + 8), 100) : 0
                    selectByMouse: true
                    maximumLength: 45
                    //leftPadding: lbl_QNumber.width + 8

                    //-- underline --//
                    Rectangle{
                        anchors.fill: parent
                        anchors.margins: -5
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

