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

    property var ques_num
    property var qnumber
    property var sourceObj
    property var mainObj: []
    property var questionTextWords: []
    property var trArray: []
    property var tdArray: []
    property var temp: []
    property int questionCount: 0
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
        questionText = ConvertRTFtoPlain.removeBackSlashT(mainObj[0]['questions'][0]['text'])

        var tableIndx = questionText.indexOf('<table')
        if(tableIndx !== -1){

            var indx = questionText.indexOf('<tr')
            while(indx !== -1){
                trArray.push({'row': questionText.substring(indx , questionText.indexOf('</tr>') + 5)})
                questionText = questionText.replace(questionText.substring(indx , questionText.indexOf('</tr>') + 5) , "")
                indx = questionText.indexOf('<tr');
            }


            console.log(JSON.stringify(trArray))

            var rowIndex = 0
            var indxTD = trArray[rowIndex]['row'].indexOf('<td')

            while(indxTD !== -1){



                temp.push({"col" : trArray[rowIndex]['row'].substring(indxTD , trArray[rowIndex]['row'].indexOf('</td>') + 5)})
                trArray[rowIndex]['row'] = trArray[rowIndex]['row'].replace(trArray[rowIndex]['row'].substring(indxTD , trArray[rowIndex]['row'].indexOf('</td>') + 5) , "")

                indxTD = trArray[rowIndex]['row'].indexOf('<td')

                if(indxTD === -1){
                    tdArray.push({"rows": temp})
                    temp = []
                    rowIndex++;
                    if(rowIndex === trArray.length){
                        break;
                    }
                    else{
                        indxTD = trArray[rowIndex]['row'].indexOf('<td')
                    }
                }

            }

        }


        print("----------------")
        //            print(JSON.stringify(tdArray))

        for(var i=0; i<tdArray.length; i++){
            model_1.append(tdArray[i])
            model_1.setProperty(model_1.count-1, 'max_height', 26)
        }


        //print(JSON.stringify(model_1))


        //console.log("questionTEXT = " , mainObj[0]['questions'][0]['text'])
        //log("-=-=-=-data: " + JSON.stringify(sourceObj))
        //log(sourceObj.questions.length)
    }

    property alias sizeR: slider_size.value
    property var qFont: nunito_italic.name
    property int qHeight: lv_1.contentHeight

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


        Rectangle{
           Layout.preferredWidth: parent.width -10 //width: parent.width - 10
           Layout.preferredHeight: lv_1.contentHeight //height: parent.height - 10
            clip: true


            color: "transparent"

            //-- show all rows --//
            ListView{
                id: lv_1
                anchors.fill: parent
                model: model_1
                interactive: false

                delegate: Item {
                    id: itm1

                    width: parent.width
                    height: max_height

                    //-- for access pparent listview index in childeren listview --//
                    property int itm1_index: index

                    //-- generate cols model for each rows --//
                    Component.onCompleted: {

                        for(var i=0; i< model.rows.count; i++){
                            lmd.append(model.rows.get(i))
                        }

                    }

                    //-- model for cols of each rows --//
                    ListModel{id: lmd}

                    ListView{
                        id: lv2
                        anchors.fill: parent
                        model: lmd
                        orientation: ListView.Horizontal
                        interactive: false
                        property int flw_indx: index + qnumber - 2

                        //-- trigger when windows maximize  and minimize --//
                        property bool triger: root.visibilityOfWinChanged
                        onTrigerChanged: {
                            timer_resizing.restart()
                        }

                        //-- save rows text items (sizing porpose) --//
                        property var list_text: []
                        //-- convert text to word array for handling blank --//



                        delegate: Rectangle{
                            id: innerData
                            height: parent.height
                            //-- width based of availble width of parent --//

                            width: lv2.width / lmd.count
                            border.width: 1

                            property var textSplit: []
                            Component.onCompleted: {
                                var a = ConvertRTFtoPlain.rtfToPlain(col)
                                var currentText = []
                                //var blankCount = 0

                                currentText = a.split(" ")
                                for(var i =  0 ; i < currentText.length ; i++){
                                    if(currentText[i] === "_BLANK" || currentText[i].indexOf("_BLANK") !== -1 ) {
                                        //console.log("textSplitIF = " , currentText)
                                        questionCount++;
                                        //blankCount++;
                                    }
                                }


                                for(var j=0; j< currentText.length; j++){
                                    if(currentText[j].indexOf("_BLANK") === -1)
                                        textSplit.push({"word": currentText[j]})
                                    else
                                       textSplit.push({"word": currentText[j]})
                                }

                                console.log(itm1.itm1_index , "    " , index , "    " , JSON.stringify(textSplit))
                                repeater1.model = innerData.textSplit.length

                                //console.log("BLANKCOUNT" , blankCount , "           " , txt1.text)

                            }

                            Flow {
                                id: flw
                                width: parent.width - 20
                                height: parent.height - 10
                                anchors.centerIn: parent

                                spacing: 3

                                //visible: false

                                Repeater{
                                    id: repeater1

                                    model: innerData.textSplit.length
                                    Rectangle{

                                        width: txt.implicitWidth + txt_inp.width + lbl_QNumber.width
                                        height: txt.implicitHeight * 1.5
                                        color: "transparent"
                                        Text {
                                            id: txt
                                            anchors.left: parent.left ;
                                            anchors.leftMargin: 5 ;
                                            text: (innerData.textSplit[index]['word'].indexOf("_BLANK") !== -1) ? " " : innerData.textSplit[index]['word'];
                                            font.pixelSize: lbl_size.font.pixelSize
                                            anchors.verticalCenter: parent.verticalCenter
                                        }

                                        //-- Number --//
                                        QstNumber{
                                            id: lbl_QNumber
                                            text:{
                                                var _words
                                                if(innerData.textSplit[index]['word'].indexOf("_BLANK") !== -1){
                                                    _words = innerData.textSplit[index]['word'].split("#")
                                                    //console.log("QNUMBER = " , parseInt(_words[1]))
                                                return (parseInt(_words[1]) + parseInt(qnumber - 2))//(innerData.textSplit[index]['word'])
                                                }
                                                else{
                                                   return 0
                                                }
                                            }
                                            anchors.left: txt.right
                                            visible: (innerData.textSplit[index]['word'].indexOf("_BLANK") !== -1) ? true : false
                                            width: (innerData.textSplit[index]['word'].indexOf("_BLANK") !== -1) ? lbl_size.implicitHeight * 1.4 : 0
                                            font.pixelSize: lbl_size.font.pixelSize
                                        }


                                        //-- options --//
                                        TextInput{
                                            id: txt_inp
                                            visible: (innerData.textSplit[index]['word'].indexOf("_BLANK") !== -1) ? true : false
                                            Component.onCompleted: {

                                                var _words
                                                if(innerData.textSplit[index]['word'].indexOf("_BLANK") !== -1){
                                                    //print('valid input, ')
                                                    _words = innerData.textSplit[index]['word'].split("#")
                                                    inputsArray.push({"answerText" : txt_inp , "number" : parseInt(_words[1])})
                                                }

                                            }
                                            onTextChanged: {
                                                fillAnswer(lv2.flw_indx, txt_inp.text)
                                            }

                                            anchors.left: lbl_QNumber.right
                                            anchors.verticalCenter: parent.verticalCenter
                                            horizontalAlignment: Qt.AlignHCenter
                                            font.pixelSize: lbl_size.font.pixelSize
                                            width: (innerData.textSplit[index]['word'].indexOf("_BLANK") !== -1) ? Math.max((contentWidth /*+ lbl_QNumber.width*/ + 8), 100) : 0
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

                                            onLengthChanged: {
                                                lv2.resizing()
                                            }

                                        }


                                    }

                                }

                                Component.onCompleted: {
                                    //-- add text item to list for handeling heig of rows --//
                                    lv2.list_text.push(flw)

                                    //-- resize in first time --//
                                    if(index === 0){
                                        print('apply resize in ', index)

                                        timer_resizing.restart()
                                    }
                                }

                            }

                            Text {
                                id: txt1
                                visible: false
                                anchors.fill: parent
                                anchors.margins: 2
                                text: col
                                wrapMode: Text.WordWrap
                                //textFormat: Text.PlainText
                                Component.onCompleted: {
                                    //-- add text item to list for handeling heig of rows --//
                                    //lv2.list_text.push(txt1)

                                    //-- resize in first time --//
                                    //lv2.resizing()
                                }
                            }

                        }

                        //-- resize all rows text heigh --//
                        onWidthChanged: {
                            lv2.resizing()
                        }

                        //-- delay for resizing slack --//
                        Timer {id: timer_resizing; interval: 10;  onTriggered: lv2.resizing() }

                        //-- check all rows item and resize heihjt of them --//
                        function resizing(){
                            var maxHeigh = 0;
                            for(var i=0; i< lv2.list_text.length; i++){
                                if(maxHeigh < lv2.list_text[i].implicitHeight){
                                    maxHeigh = lv2.list_text[i].implicitHeight + 30
                                }
                            }
                            model_1.setProperty(itm1.itm1_index, 'max_height', maxHeigh)
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
