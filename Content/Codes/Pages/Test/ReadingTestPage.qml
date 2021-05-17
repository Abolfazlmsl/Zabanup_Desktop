import QtQuick 2.14
//import QtQuick.Controls 2.2
import QtQuick.Controls 2.14
import QtQuick.Window 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import Qt.labs.platform 1.0

import io.qt.examples.texteditor 1.0

import "./../../../Fonts/Icon.js" as Icons
import "./../../Utils/Utils.js" as Utils
import "./../../Utils/ConvertRTFtoPlain.js" as ConvertRTFtoPlain
import "./../../Modules"
import "./../../Modules/TypesOfQuestions"
import "./../../Modules/QuestionsText"
import "./../ListModels"
import "./../ListModels/QuestionListModel"
import "./../../Utils/ReadingFooter"
import "./../../Utils/ReadingHeader"


Item {
    id:rootReadingTestPage

    property var currentObject
    property var checkbox_start1: 0
    property var checkbox_end1: 0
    property var checkbox_start2: 0
    property var checkbox_end2: 0
    property var checkbox_start3: 0
    property var checkbox_end3: 0
    //    property var questionCount
    property var mObj: []
    property var questionText: ""
    property var questionSplit: []
    property var question_model
    property var trArray: []
    //-- save question JSON file --//
    property var questionObj: []
    property var section1_Count
    property var section2_Count
    property var section3_Count

    objectName: "ReadingTestPage"

    Component.onCompleted: {
        print("salam")
        var counter = 0
        var counter_check = 0
        var num = 0
        for (var j=0; j<root._FullTestQuestions_1.count; j++){
            mObj = []
            mObj.push(JSON.parse(JSON.stringify(root._FullTestQuestions_1.get(j))))

            if(mObj[0]['type'].name === "Multiple choice" || mObj[0]['type'].name === "main idea"
                    || mObj[0]['type'].name === "matching heading" || mObj[0]['type'].name === "Yes No NotGiven"
                    || mObj[0]['type'].name === "classifying information" || mObj[0]['type'].name === "matching information with paragraphs"
                    || mObj[0]['type'].name === "matching sentence ending" || mObj[0]['type'].name === "matching statements & people & ..."
                    || mObj[0]['type'].name === "True False Not Given" || mObj[0]['type'].name === "short answer"
                    || mObj[0]['type'].name === "sentence completion"){
                num = getTotalQuestion_1(mObj)
                counter += num
                counter_check += num
            }else if(mObj[0]['type'].name === "completing summary paragraph"){
                num = getTotalQuestion_2(mObj)
                counter += num
                counter_check += num
            }else if(mObj[0]['type'].name === "map and chart"){
                num = getTotalQuestion_3(mObj)
                counter += num
                counter_check += num
            }else if (mObj[0]['type'].name === "multiple choice list"){
                num = getTotalQuestion_1(mObj)
                counter += num
                counter_check += 1
            }
        }
        section1_Count = counter


        var counter1 = 0
        var counter_check1 = 0
        var num1 = 0
        for (var j=0; j<root._FullTestQuestions_2.count; j++){
            mObj = []
            mObj.push(JSON.parse(JSON.stringify(root._FullTestQuestions_2.get(j))))

            if(mObj[0]['type'].name === "Multiple choice" || mObj[0]['type'].name === "main idea"
                    || mObj[0]['type'].name === "matching heading" || mObj[0]['type'].name === "Yes No NotGiven"
                    || mObj[0]['type'].name === "classifying information" || mObj[0]['type'].name === "matching information with paragraphs"
                    || mObj[0]['type'].name === "matching sentence ending" || mObj[0]['type'].name === "matching statements & people & ..."
                    || mObj[0]['type'].name === "True False Not Given" || mObj[0]['type'].name === "short answer"
                    || mObj[0]['type'].name === "sentence completion"){
                num1 = getTotalQuestion_1(mObj)
                counter1 += num1
                counter_check1 += num1
            }else if(mObj[0]['type'].name === "completing summary paragraph"){
                num1 = getTotalQuestion_2(mObj)
                counter1 += num1
                counter_check1 += num1
            }else if(mObj[0]['type'].name === "map and chart"){
                num1 = getTotalQuestion_3(mObj)
                counter1 += num1
                counter_check1 += num1
            }else if (mObj[0]['type'].name === "multiple choice list"){
                num1 = getTotalQuestion_1(mObj)
                counter1 += num1
                counter_check1 += 1
            }

        }
        section2_Count =  counter1


        var counter2 = 0
        var counter_check2 = 0
        var num2 = 0
        for (var j=0; j<root._FullTestQuestions_3.count; j++){
            mObj = []
            mObj.push(JSON.parse(JSON.stringify(root._FullTestQuestions_3.get(j))))

            if(mObj[0]['type'].name === "Multiple choice" || mObj[0]['type'].name === "main idea"
                    || mObj[0]['type'].name === "matching heading" || mObj[0]['type'].name === "Yes No NotGiven"
                    || mObj[0]['type'].name === "classifying information" || mObj[0]['type'].name === "matching information with paragraphs"
                    || mObj[0]['type'].name === "matching sentence ending" || mObj[0]['type'].name === "matching statements & people & ..."
                    || mObj[0]['type'].name === "True False Not Given" || mObj[0]['type'].name === "short answer"
                    || mObj[0]['type'].name === "sentence completion"){
                num2 = getTotalQuestion_1(mObj)
                counter2 += num2
                counter_check2 += num2
            }else if(mObj[0]['type'].name === "completing summary paragraph"){
                num2 = getTotalQuestion_2(mObj)
                counter2 += num2
                counter_check2 += num2
            }else if(mObj[0]['type'].name === "map and chart"){
                num2 = getTotalQuestion_3(mObj)
                counter2 += num2
                counter_check2 += num2
            }else if (mObj[0]['type'].name === "multiple choice list"){
                num2 = getTotalQuestion_1(mObj)
                counter2 += num2
                counter_check2 += 1
            }
        }
        section3_Count = counter2

        passage = false
        qN1 = counter_check
        qN2 = counter_check1
        qN3 = counter_check2

        model_ans.clear()
        model_answer.clear()

        //-- preset answer model --//
        for(var i=0; i<counter_check+counter_check1+counter_check2; i++){
            model_ans.append({"answer":""})
            model_answer.append({"answer":""})
        }

        var mainObj = []
        var num = 0
        var counter = 0
        for (var jj=0; jj<root._FullTestQuestions_1.count; jj++){
            mainObj = []
            num = 0
            mainObj.push(JSON.parse(JSON.stringify(root._FullTestQuestions_1.get(jj))))
            if(mainObj[0]['type'].name === "Multiple choice"){
                num = getTotalQuestion_1(mainObj)
                for(var i=counter; i<counter+num; i++){
                    model_answer.setProperty(i, "answer", "A")
                }
            }else if (mainObj[0]['type'].name === "completing summary paragraph"){
                num = getTotalQuestion_2(mainObj)
                for(var i=counter; i<counter+num; i++){
                    model_answer.setProperty(i, "answer", "A")
                }
            }else if (mainObj[0]['type'].name === "True False Not Given" || mainObj[0]['type'].name === "classifying information"
                      || mainObj[0]['type'].name === "matching heading" || mainObj[0]['type'].name === "Yes No NotGiven"
                      || mainObj[0]['type'].name === "matching sentence ending" || mainObj[0]['type'].name === "matching information with paragraphs"
                      || mainObj[0]['type'].name === "sentence completion" || mainObj[0]['type'].name === "matching statements & people & ..."
                      || mainObj[0]['type'].name === "short answer"){
                num = getTotalQuestion_1(mainObj)
                for(var i=counter; i<counter+num; i++){
                    model_answer.setProperty(i, "answer", mainObj[0]['questions'][i-counter]['answers'][0]['text'])
                }
            }else if (mainObj[0]['type'].name === "map and chart"){
                num = getTotalQuestion_3(mainObj)
                for(var i=counter; i<counter+num; i++){
                    model_answer.setProperty(i, "answer", "A")
                }
            }else if (mainObj[0]['type'].name === "main idea"){
                num = getTotalQuestion_3(mainObj)
                for(var i=counter; i<counter+num; i++){
                    model_answer.setProperty(i, "answer", "A")
                }
            }else if (mainObj[0]['type'].name === "multiple choice list"){
                num = 1
                for(var i=counter; i<counter+num; i++){
                    model_answer.setProperty(i, "answer", "A,B")
                }
            }
            counter += num
        }

        for (var jj=0; jj<root._FullTestQuestions_2.count; jj++){
            mainObj = []
            num = 0
            mainObj.push(JSON.parse(JSON.stringify(root._FullTestQuestions_2.get(jj))))
            if(mainObj[0]['type'].name === "Multiple choice"){
                num = getTotalQuestion_1(mainObj)
                for(var i=counter; i<counter+num; i++){
                    model_answer.setProperty(i, "answer", "A")
                }
            }else if (mainObj[0]['type'].name === "completing summary paragraph"){
                num = getTotalQuestion_2(mainObj)
                for(var i=counter; i<counter+num; i++){
                    model_answer.setProperty(i, "answer", "A")
                }
            }else if (mainObj[0]['type'].name === "True False Not Given" || mainObj[0]['type'].name === "classifying information"
                      || mainObj[0]['type'].name === "matching heading" || mainObj[0]['type'].name === "Yes No NotGiven"
                      || mainObj[0]['type'].name === "matching sentence ending" || mainObj[0]['type'].name === "matching information with paragraphs"
                      || mainObj[0]['type'].name === "sentence completion" || mainObj[0]['type'].name === "matching statements & people & ..."
                      || mainObj[0]['type'].name === "short answer"){
                num = getTotalQuestion_1(mainObj)
                for(var i=counter; i<counter+num; i++){
                    model_answer.setProperty(i, "answer", mainObj[0]['questions'][i-counter]['answers'][0]['text'])
                }
            }else if (mainObj[0]['type'].name === "map and chart"){
                num = getTotalQuestion_3(mainObj)
                for(var i=counter; i<counter+num; i++){
                    model_answer.setProperty(i, "answer", "A")
                }
            }else if (mainObj[0]['type'].name === "main idea"){
                num = getTotalQuestion_3(mainObj)
                for(var i=counter; i<counter+num; i++){
                    model_answer.setProperty(i, "answer", "A")
                }
            }else if (mainObj[0]['type'].name === "multiple choice list"){
                num = 1
                for(var i=counter; i<counter+num; i++){
                    model_answer.setProperty(i, "answer", "A,B")
                }
            }
            counter += num
        }

        for (var jj=0; jj<root._FullTestQuestions_3.count; jj++){
            mainObj = []
            num = 0
            mainObj.push(JSON.parse(JSON.stringify(root._FullTestQuestions_3.get(jj))))
            if(mainObj[0]['type'].name === "Multiple choice"){
                num = getTotalQuestion_1(mainObj)
                for(var i=counter; i<counter+num; i++){
                    model_answer.setProperty(i, "answer", "A")
                }
            }else if (mainObj[0]['type'].name === "completing summary paragraph"){
                num = getTotalQuestion_2(mainObj)
                for(var i=counter; i<counter+num; i++){
                    model_answer.setProperty(i, "answer", "A")
                }
            }else if (mainObj[0]['type'].name === "True False Not Given" || mainObj[0]['type'].name === "classifying information"
                      || mainObj[0]['type'].name === "matching heading" || mainObj[0]['type'].name === "Yes No NotGiven"
                      || mainObj[0]['type'].name === "matching sentence ending" || mainObj[0]['type'].name === "matching information with paragraphs"
                      || mainObj[0]['type'].name === "sentence completion" || mainObj[0]['type'].name === "matching statements & people & ..."
                      || mainObj[0]['type'].name === "short answer"){
                num = getTotalQuestion_1(mainObj)
                for(var i=counter; i<counter+num; i++){
                    model_answer.setProperty(i, "answer", mainObj[0]['questions'][i-counter]['answers'][0]['text'])
                }
            }else if (mainObj[0]['type'].name === "map and chart"){
                num = getTotalQuestion_3(mainObj)
                for(var i=counter; i<counter+num; i++){
                    model_answer.setProperty(i, "answer", "A")
                }
            }else if (mainObj[0]['type'].name === "main idea"){
                num = getTotalQuestion_3(mainObj)
                for(var i=counter; i<counter+num; i++){
                    model_answer.setProperty(i, "answer", "A")
                }
            }else if (mainObj[0]['type'].name === "multiple choice list"){
                num = 1
                for(var i=counter; i<counter+num; i++){
                    model_answer.setProperty(i, "answer", "A,B")
                }
            }
            counter += num
        }
    }

    property real handlerWidth: 15

    property real sizeRatio: 1.25


    //-- fill answer --//
    signal fillAnswer(string question, string answer)
    onFillAnswer: {
        log("answer to " + question + ": " + answer)
        model_ans.setProperty((parseInt(question)-1), "answer", answer)
    }

    //-- when width changed , SplitHandle goto Center --//
    onWidthChanged: {
        readingTextSection.width = (rootReadingTestPage.width / 2) - (handlerWidth / 2) - 5.5

    }

    //--- Timer Signals ---//
    //-- Timer Start --//
    signal startTimer
    onStartTimer: {
        footer_Reading.startTimer()
    }

    //-- Timer Stop --//
    signal stopTimer
    onStopTimer: {
        footer_Reading.stopTimer()
    }

    //-- Timer Stop --//
    signal resetTimer
    onResetTimer: {
        footer_Reading.resetTimer()
    }


    //-- size porpos --//
    Label{id: lbl_size; visible: false; text: "Not Given"; font.pixelSize: Qt.application.font.pixelSize*sizeRatio}


    //-- body --//
    ColumnLayout{
        anchors.fill: parent
        spacing: 0

        //-- free space for handling Header --//
        Rectangle{
            Layout.fillWidth: true
            Layout.preferredHeight: 60 * ratio

            color: "#cccccc"
        }

        //-- Body of Test Page  (Passage and Answer) --//
        SplitView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            orientation: Qt.Horizontal

            handle: Rectangle{
                implicitWidth: handlerWidth
                implicitHeight: parent.height
                color: "#dddddd"

                MouseArea{
                    anchors.fill: parent
                    propagateComposedEvents: true
                    cursorShape: Qt.SizeHorCursor//Qt.SplitHCursor
                    onPressed: {
                        mouse.accepted = false
                    }
                }
            }

            //-- TEXT (Passages text) --//
            Rectangle {
                id:readingTextSection

                SplitView.preferredWidth: (rootReadingTestPage.width / 2) - (handlerWidth / 2) - 5.5 // 5.5 => width of StopWatch Icon / 4 => 22 / 4 = 5.5

                SplitView.minimumWidth: 200 * ratio
                SplitView.maximumWidth: rootReadingTestPage.width - (50 * ratio)


                DocumentHandler {
                    id: document
                    document: textArea.textDocument
                    cursorPosition: textArea.cursorPosition
                    selectionStart: textArea.selectionStart
                    selectionEnd: textArea.selectionEnd

                    //                    textColor: colorDialog.color
                    //                    Component.onCompleted: document.load("qrc:/Content/Codes/Pages/Test/HTML/Test.htm")
                    onLoaded: {
                        textArea.text = text
                    }
                }

                Flickable {
                    id: flickable
                    flickableDirection: Flickable.VerticalFlick
                    anchors.fill: parent
                    visible: testSection1.checked

                    TextArea.flickable: TextArea {
                        id: textArea
                        text: root._FullText_1
                        textFormat: Qt.RichText
                        wrapMode: TextArea.Wrap
                        readOnly: true
                        //                        focus: true
                        selectByMouse: true
                        persistentSelection: true
                        // Different styles have different padding and background
                        // decorations, but since this editor is almost taking up the
                        // entire window, we don't need them.
                        leftPadding: 6
                        rightPadding: 6
                        topPadding: 0
                        bottomPadding: 0
                        //                        background: null

                        onLinkActivated: Qt.openUrlExternally(link)
                    }

                    ScrollBar.vertical: ScrollBar {}
                }

                DocumentHandler {
                    id: document_2
                    document: textArea_2.textDocument
                    cursorPosition: textArea_2.cursorPosition
                    selectionStart: textArea_2.selectionStart
                    selectionEnd: textArea_2.selectionEnd

                    //                    textColor: colorDialog.color
                    //                    Component.onCompleted: document.load("qrc:/Content/Codes/Pages/Test/HTML/Test.htm")
                    //                    onLoaded: {
                    //                        textArea_2.text = text
                    //                    }
                }

                Flickable {
                    id: flickable_2
                    flickableDirection: Flickable.VerticalFlick
                    anchors.fill: parent
                    visible: testSection2.checked

                    TextArea.flickable: TextArea {
                        id: textArea_2
                        text: root._FullText_2
                        textFormat: Qt.RichText
                        wrapMode: TextArea.Wrap
                        readOnly: true
                        //                        focus: true
                        selectByMouse: true
                        persistentSelection: true
                        // Different styles have different padding and background
                        // decorations, but since this editor is almost taking up the
                        // entire window, we don't need them.
                        leftPadding: 6
                        rightPadding: 6
                        topPadding: 0
                        bottomPadding: 0
                        //                        background: null

                        onLinkActivated: Qt.openUrlExternally(link)
                    }

                    ScrollBar.vertical: ScrollBar {}
                }

                DocumentHandler {
                    id: document_3
                    document: textArea_3.textDocument
                    cursorPosition: textArea_3.cursorPosition
                    selectionStart: textArea_3.selectionStart
                    selectionEnd: textArea_3.selectionEnd

                    //                    textColor: colorDialog.color
                    //                    Component.onCompleted: document.load("qrc:/Content/Codes/Pages/Test/HTML/Test.htm")
                    onLoaded: {
                        textArea_3.text = text
                    }
                }

                Flickable {
                    id: flickable_3
                    flickableDirection: Flickable.VerticalFlick
                    anchors.fill: parent
                    visible: testSection3.checked

                    TextArea.flickable: TextArea {
                        id: textArea_3
                        text: root._FullText_3
                        textFormat: Qt.RichText
                        wrapMode: TextArea.Wrap
                        readOnly: true
                        //                        focus: true
                        selectByMouse: true
                        persistentSelection: true
                        // Different styles have different padding and background
                        // decorations, but since this editor is almost taking up the
                        // entire window, we don't need them.
                        leftPadding: 6
                        rightPadding: 6
                        topPadding: 0
                        bottomPadding: 0
                        //                        background: null

                        onLinkActivated: Qt.openUrlExternally(link)
                    }

                    ScrollBar.vertical: ScrollBar {}
                }


                color: "lightblue"

            }

            //-- Answers Section --//
            Rectangle {
                id: readingAnswerSection

                SplitView.minimumWidth: 200 * ratio
                SplitView.fillWidth: true

                color: "#ffffff"

                DocumentHandler {
                    id: documentAnswer
                    document: currentObject.textDocument
                    cursorPosition: currentObject.cursorPosition
                    selectionStart: currentObject.selectionStart
                    selectionEnd: currentObject.selectionEnd

                    //                    textColor: colorDialog.color
                    //                    Component.onCompleted: document.load("qrc:/Content/Codes/Pages/Test/HTML/Test.htm")
                    //                    onLoaded: {
                    //                        textArea_1.text = text
                    //                    }
                }

                //                Questions{id: model_questions}

                //-- lv of section 1 --//
                ListView{
                    id: lst_Answer_sec1
                    visible: testSection1.checked
                    width: parent.width - 8
                    height: parent.height - sectionButtons.height
                    anchors.top: parent.top
                    anchors.topMargin: 5
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 0
                    clip: true
                    cacheBuffer: 10000

                    //-- back of ScrollBar --//
                    Rectangle{
                        id: itm_scroll
                        height: parent.height
                        width: 6
                        color: "#00a0a0a0"
                        anchors.right: parent.right
                        anchors.rightMargin: 1

                    }

                    //-- ScrollBar --//
                    ScrollBar.vertical: ScrollBar {
                        id: scrollBarVertical
                        parent: lst_Answer_sec1
                        anchors.fill: itm_scroll
                    }

                    //                    model: model_questions
                    model: ListModel{
                        id: model_section1

                        property bool qtype: false
                        property var factor: 1
                        property bool vis: true
                        property var mainObj: []

                        Component.onCompleted: {
                            //                            questionObj = Utils.data

                            questionCount_1 = 0
//                            getTotalQuestions()
                            //-- fill section 1 --//
                            model_section1.clear()
                            var num = 0

                            for (var j=0; j<root._FullTestQuestions_1.count; j++){
                                mainObj = []
                                model_section1.mainObj.push(JSON.parse(JSON.stringify(root._FullTestQuestions_1.get(j))))

                                if(model_section1.mainObj[0]['type'].name === "Multiple choice" || model_section1.mainObj[0]['type'].name === "main idea"
                                        || model_section1.mainObj[0]['type'].name === "matching heading" || model_section1.mainObj[0]['type'].name === "Yes No NotGiven"
                                        || model_section1.mainObj[0]['type'].name === "classifying information" || model_section1.mainObj[0]['type'].name === "matching information with paragraphs"
                                        || model_section1.mainObj[0]['type'].name === "matching sentence ending" || model_section1.mainObj[0]['type'].name === "matching statements & people & ..."
                                        || model_section1.mainObj[0]['type'].name === "True False Not Given" || model_section1.mainObj[0]['type'].name === "short answer"
                                        || model_section1.mainObj[0]['type'].name === "sentence completion"){
                                    num = getTotalQuestion_1(model_section1.mainObj)
                                    for(var k=questionCount_1; k<questionCount_1+num+1; k++){
                                        vis = true
                                        if (k === questionCount_1+num+1-factor){factor+=1}
                                        if (k === questionCount_1){qtype = true}else{qtype = false}
                                        model_section1.append({"type": model_section1.mainObj[0]['type'].name,
                                                                  "number": k+1-questionCount_1,
                                                                  "qnumber":k+1,
                                                                  "qcountnum": num + questionCount_1,
                                                                  "qsection": qtype,
                                                                  "factor": factor,
                                                                  "ssquestion": j,
                                                                  "visible": vis})

                                    }
                                    questionCount_1 += num

                                }else if (model_section1.mainObj[0]['type'].name === "multiple choice list"){
                                    num = getTotalQuestion_1(model_section1.mainObj)
                                    for(var k=questionCount_1; k<questionCount_1+2; k++){
                                        vis = true
                                        if (k === questionCount_1+2-factor){factor+=1}
                                        if (k === questionCount_1){qtype = true}else{qtype = false}
                                        model_section1.append({"type": model_section1.mainObj[0]['type'].name,
                                                                  "number": k+1-questionCount_1,
                                                                  "qnumber":k+1,
                                                                  "qcountnum": num + questionCount_1,
                                                                  "qsection": qtype,
                                                                  "factor": factor,
                                                                  "ssquestion": j,
                                                                  "totalQuestions": num,
                                                                  "visible": vis})

                                    }
                                    checkbox_start1 = questionCount_1 + 1
                                    checkbox_end1 = questionCount_1 + num
                                    start_1 = checkbox_start1
                                    end_1 = checkbox_end1
                                    start_1 = checkbox_start1
                                    end_1 = checkbox_end1
                                    questionCount_1 += 1
                                }else if(model_section1.mainObj[0]['type'].name === "completing summary paragraph"){
                                    num = getTotalQuestion_2(model_section1.mainObj)
                                    for(var k=questionCount_1; k<questionCount_1+num+1; k++){
                                        if (k === questionCount_1+num+1-factor){factor+=1}
                                        if (k === questionCount_1){qtype = true}else{qtype = false}
                                        if (k === questionCount_1+1){vis = true}else{vis = false}
                                        model_section1.append({"type": model_section1.mainObj[0]['type'].name,
                                                                  "number": k+1-questionCount_1,
                                                                  "qnumber":k+1,
                                                                  "qcountnum": num + questionCount_1,
                                                                  "qsection": qtype,
                                                                  "factor": factor,
                                                                  "ssquestion": j,
                                                                  "visible": vis,
                                                                  "firstindex": questionCount_1+1})

                                    }
                                    questionCount_1 += num
                                }else if(model_section1.mainObj[0]['type'].name === "map and chart"){
                                    num = getTotalQuestion_3(model_section1.mainObj)
                                    for(var k=questionCount_1; k<questionCount_1+num+1; k++){
                                        if (k === questionCount_1+num+1-factor){factor+=1}
                                        if (k === questionCount_1){qtype = true}else{qtype = false}
                                        if (k === questionCount_1+1){vis = true}else{vis = false}
                                        model_section1.append({"type": model_section1.mainObj[0]['type'].name,
                                                                  "number": k+1-questionCount_1,
                                                                  "qnumber":k+1,
                                                                  "qcountnum": num + questionCount_1,
                                                                  "qsection": qtype,
                                                                  "factor": factor,
                                                                  "ssquestion": j,
                                                                  "visible": vis,
                                                                  "firstindex": questionCount_1+1})

                                    }
                                    questionCount_1 += num
                                }
                            }
                        }
                    }

                    //-- header text of section 1 --//
                    header: Item {
                        width: parent.width
                        height: lbl_lv_sec1.implicitHeight * 2

                        Label{
                            id: lbl_lv_sec1
                            text: "SECTION 1: QUESTIONS 1 - " + section1_Count
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.leftMargin: 10
                            font.bold: true
                            color: Utils.color_Tile_practice
                            renderType: Text.NativeRendering
                        }
                    }

                    delegate:Loader{

                        id: ld

                        width: parent.width
                        height: (item !== null) ? item.qHeight + (lbl_size.implicitHeight * 1.3) : 0
                        objectName: index

                        sourceComponent: {
                            if(model.type === "matching heading") {
                                if (model.qsection === true){
                                    return dropix
                                }else{
                                    return comp_dropdown_ix
                                }
                            }else if(model.type === "True False Not Given") {
                                if (model.qsection === true){
                                    return droptruefalse
                                }else{
                                    return comp_dropdown_TrueFalseNotGiven
                                }
                            }else if(model.type === "multiple choice list"){
                                if (model.qsection === true){
                                    return checkboxaf
                                }else{
                                    return comp_checkbox_AF
                                }
                            }else if(model.type === "Yes No NotGiven") {
                                if (model.qsection === true){
                                    return dropyesno
                                }else{
                                    return comp_dropdown_YesNoNotGiven
                                }
                            }else if(model.type === "completing summary paragraph") {
                                if (model.qsection === true & model.visible === false){
                                    return placeholder
                                }else if (model.qsection === false & model.visible === false){
                                    return null
                                }else{
                                    return comp_placeholder_paragraph
                                }
                            }else if(model.type === "short answer") {
                                if (model.qsection === true){
                                    return placeholderend
                                }else{
                                    return comp_placeholder_end
                                }
                            }else if(model.type === "sentence completion") {
                                if (model.qsection === true){
                                    return placeholderanypos
                                }else{
                                    return comp_placeholder_anyPostion
                                }
                            }else if(model.type === "Multiple choice" || model.type === "main idea") {
                                if (model.qsection === true){
                                    return radiotext
                                }else{
                                    return comp_radio_AD
                                }
                            }else if(model.type === "classifying information" || model.type === "matching information with paragraphs"
                                     || model.type === "matching sentence ending" || model.type === "matching statements & people & ...") {
                                if (model.qsection === true){
                                    return dropah
                                }else{
                                    return comp_dropdown_AH
                                }
                            }else if (model.type === "map and chart"){
                                if (model.qsection === true & model.visible === false){
                                    return mapandchart
                                }else if (model.qsection === false & model.visible === false){
                                    return null
                                }else{
                                    return comp_Map_and_Chart
                                }
                            }

                            else null

                        }

                        property var total: model.totalQuestions
                        property var modelnumber: model.number
                        property var modelQnumber: model.qnumber
                        property var modelQCountnumber: model.qcountnum
                        property var modelvisible: model.visible
                        property var obj: JSON.stringify(root._FullTestQuestions_1.get(model.ssquestion))
                        property real ratios: sizeRatio
                        property int index1: index

                    }
                }

                //-- lv of section 2 --//
                ListView{
                    id: lst_Answer_sec2
                    visible: testSection2.checked
                    width: parent.width - 8
                    height: parent.height - sectionButtons.height
                    anchors.top: parent.top
                    anchors.margins: 5
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 0
                    clip: true
                    cacheBuffer: 10000

                    //-- back of ScrollBar --//
                    Rectangle{
                        id: itm_scroll2
                        height: parent.height
                        width: 6
                        color: "#00a0a0a0"
                        anchors.right: parent.right
                        anchors.rightMargin: 1

                    }

                    //-- ScrollBar --//
                    ScrollBar.vertical: ScrollBar {
                        id: scrollBarVertical2
                        parent: lst_Answer_sec2
                        anchors.fill: itm_scroll2
                    }

                    model: ListModel{
                        id: model_section2
                        property bool qtype: false
                        property var factor: 1
                        property bool vis: true
                        property var mainObj: []

                        Component.onCompleted: {

                            questionCount_2 = 0
//                            getTotalQuestions()
                            var num = 0
                            //-- fill section 1 --//
                            model_section2.clear()
                            for (var j=0; j<root._FullTestQuestions_2.count; j++){
                                mainObj = []
                                model_section2.mainObj.push(JSON.parse(JSON.stringify(root._FullTestQuestions_2.get(j))))
                                if(model_section2.mainObj[0]['type'].name === "Multiple choice" || model_section2.mainObj[0]['type'].name === "main idea"
                                        || model_section2.mainObj[0]['type'].name === "matching heading" || model_section2.mainObj[0]['type'].name === "Yes No NotGiven"
                                        || model_section2.mainObj[0]['type'].name === "classifying information" || model_section2.mainObj[0]['type'].name === "matching information with paragraphs"
                                        || model_section2.mainObj[0]['type'].name === "matching sentence ending" || model_section2.mainObj[0]['type'].name === "matching statements & people & ..."
                                        || model_section2.mainObj[0]['type'].name === "True False Not Given" || model_section2.mainObj[0]['type'].name === "short answer"
                                        || model_section2.mainObj[0]['type'].name === "sentence completion"){
                                    num = getTotalQuestion_1(model_section2.mainObj)

                                    for(var k=section1_Count+questionCount_2; k<section1_Count+questionCount_2+num+1; k++){
                                        vis = true
                                        if (k === section1_Count+questionCount_2+num+1-factor){factor+=1}
                                        if (k === section1_Count+questionCount_2){qtype = true}else{qtype = false}
                                        model_section2.append({"type": model_section2.mainObj[0]['type'].name,
                                                                  "number": k+1-section1_Count-questionCount_2,
                                                                  "qnumber":k+1,
                                                                  "qcountnum": section1_Count+num + questionCount_2,
                                                                  "qsection": qtype,
                                                                  "factor": factor,
                                                                  "ssquestion": j,
                                                                  "visible": vis})


                                    }

                                    questionCount_2 += num

                                }else if (model_section2.mainObj[0]['type'].name === "multiple choice list"){
                                    num = getTotalQuestion_1(model_section2.mainObj)
                                    for(var k=section1_Count+questionCount_2; k<section1_Count+questionCount_2+2; k++){
                                        vis = true
                                        if (k === section1_Count+questionCount_2+2-factor){factor+=1}
                                        if (k === section1_Count+questionCount_2){qtype = true}else{qtype = false}
                                        model_section2.append({"type": model_section2.mainObj[0]['type'].name,
                                                                  "number": k+1-section1_Count-questionCount_2,
                                                                  "qnumber":k+1,
                                                                  "qcountnum": section1_Count+num + questionCount_2,
                                                                  "qsection": qtype,
                                                                  "factor": factor,
                                                                  "ssquestion": j,
                                                                  "totalQuestions": num,
                                                                  "visible": vis})

                                    }
                                    checkbox_start2 = section1_Count+questionCount_2 + 1
                                    checkbox_end2 = section1_Count+questionCount_2 + num
                                    start_2 = checkbox_start2
                                    end_2 = checkbox_end2
                                    start_2 = checkbox_start2
                                    end_2 = checkbox_end2
                                    questionCount_2 += 1
                                }else if(model_section2.mainObj[0]['type'].name === "completing summary paragraph"){
                                    num = getTotalQuestion_2(model_section2.mainObj)
                                    for(var k=section1_Count+questionCount_2; k<section1_Count+questionCount_2+num+1; k++){
                                        if (k === section1_Count+questionCount_2+num+1-factor){factor+=1}
                                        if (k === section1_Count+questionCount_2){qtype = true}else{qtype = false}
                                        if (k === section1_Count+questionCount_2+1){vis = true}else{vis = false}
                                        model_section2.append({"type": model_section2.mainObj[0]['type'].name,
                                                                  "number": k+1-section1_Count-questionCount_2,
                                                                  "qnumber":k+1,
                                                                  "qcountnum": section1_Count+num + questionCount_2,
                                                                  "qsection": qtype,
                                                                  "factor": factor,
                                                                  "ssquestion": j,
                                                                  "visible": vis,
                                                                  "firstindex": section1_Count+questionCount_2+1})

                                    }
                                    questionCount_2 += num
                                }else if(model_section2.mainObj[0]['type'].name === "map and chart"){
                                    num = getTotalQuestion_3(model_section2.mainObj)
                                    for(var k=section1_Count+questionCount_2; k<section1_Count+questionCount_2+num+1; k++){
                                        if (k === section1_Count+questionCount_2+num+1-factor){factor+=1}
                                        if (k === section1_Count+questionCount_2){qtype = true}else{qtype = false}
                                        if (k === section1_Count+questionCount_2+1){vis = true}else{vis = false}
                                        model_section2.append({"type": model_section2.mainObj[0]['type'].name,
                                                                  "number": k+1-section1_Count-questionCount_2,
                                                                  "qnumber":k+1,
                                                                  "qcountnum": section1_Count+num + questionCount_2,
                                                                  "qsection": qtype,
                                                                  "factor": factor,
                                                                  "ssquestion": j,
                                                                  "visible": vis,
                                                                  "firstindex": section1_Count+questionCount_2+1})

                                    }
                                    questionCount_2 += num
                                }
                            }

                        }
                    }

                    //-- header text of section 1 --//
                    header: Item {
                        width: parent.width
                        height: lbl_lv_sec2.implicitHeight * 2

                        Label{
                            id: lbl_lv_sec2
                            text: "SECTION 2: QUESTIONS " + (section1_Count+1) + " - " + (section1_Count+section2_Count)
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.leftMargin: 10
                            font.bold: true
                            color: Utils.color_Tile_practice
                            renderType: Text.NativeRendering
                        }
                    }

                    delegate:Loader{

                        id: ld_sec2

                        width: parent.width
                        height: (item !== null) ? item.qHeight + (lbl_size.implicitHeight * 1.3) : 0
                        objectName: index

                        sourceComponent: {
                            if(model.type === "matching heading") {
                                if (model.qsection === true){
                                    return dropix
                                }else{
                                    return comp_dropdown_ix
                                }
                            }else if(model.type === "True False Not Given") {
                                if (model.qsection === true){
                                    return droptruefalse
                                }else{
                                    return comp_dropdown_TrueFalseNotGiven
                                }
                            }else if(model.type === "multiple choice list"){
                                if (model.qsection === true){
                                    return checkboxaf
                                }else{
                                    return comp_checkbox_AF
                                }
                            }else if(model.type === "Yes No NotGiven") {
                                if (model.qsection === true){
                                    return dropyesno
                                }else{
                                    return comp_dropdown_YesNoNotGiven
                                }
                            }else if(model.type === "completing summary paragraph") {
                                if (model.qsection === true & model.visible === false){
                                    return placeholder
                                }else if (model.qsection === false & model.visible === false){
                                    return null
                                }else{
                                    return comp_placeholder_paragraph
                                }
                            }else if(model.type === "Multiple choice" || model.type === "main idea") {
                                if (model.qsection === true){
                                    return radiotext
                                }else{
                                    return comp_radio_AD
                                }
                            }else if(model.type === "sentence completion") {
                                if (model.qsection === true){
                                    return placeholderanypos
                                }else{
                                    return comp_placeholder_anyPostion
                                }
                            }else if(model.type === "short answer") {
                                if (model.qsection === true){
                                    return placeholderend
                                }else{
                                    return comp_placeholder_end
                                }
                            }else if(model.type === "classifying information" || model.type === "matching information with paragraphs"
                                     || model.type === "matching sentence ending" || model.type === "matching statements & people & ...") {
                                if (model.qsection === true){
                                    return dropah
                                }else{
                                    return comp_dropdown_AH
                                }
                            }else if (model.type === "map and chart"){
                                if (model.qsection === true & model.visible === false){
                                    return mapandchart
                                }else if (model.qsection === false & model.visible === false){
                                    return null
                                }else{
                                    return comp_Map_and_Chart
                                }
                            }
                            else null
                        }
                        property var total: model.totalQuestions
                        property var modelnumber: model.number
                        property var modelQnumber: model.qnumber
                        property var modelQCountnumber: model.qcountnum
                        property var modelvisible: model.visible
                        property var obj: JSON.stringify(root._FullTestQuestions_2.get(model.ssquestion))
                        property real ratios: sizeRatio
                        property int index1: index

                    }


                }

                //-- lv of section 3 --//
                ListView{
                    id: lst_Answer_sec3
                    visible: testSection3.checked
                    width: parent.width - 8
                    height: parent.height - sectionButtons.height
                    anchors.top: parent.top
                    anchors.margins: 5
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 0
                    clip: true
                    cacheBuffer: 10000

                    //-- back of ScrollBar --//
                    Rectangle{
                        id: itm_scroll3
                        height: parent.height
                        width: 6
                        color: "#00a0a0a0"
                        anchors.right: parent.right
                        anchors.rightMargin: 1

                    }

                    //-- ScrollBar --//
                    ScrollBar.vertical: ScrollBar {
                        id: scrollBarVertical3
                        parent: lst_Answer_sec3
                        anchors.fill: itm_scroll3
                    }

                    //                    model: model_questions
                    model: ListModel{
                        id: model_section3
                        property bool qtype: false
                        property var factor: 1
                        property bool vis: true
                        property var mainObj: []

                        Component.onCompleted: {

                            questionCount_3 = 0
//                            getTotalQuestions()
                            var num = 0
                            //-- fill section 1 --//
                            model_section3.clear()
                            for (var j=0; j<root._FullTestQuestions_3.count; j++){
                                mainObj = []
                                model_section3.mainObj.push(JSON.parse(JSON.stringify(root._FullTestQuestions_3.get(j))))
                                if(model_section3.mainObj[0]['type'].name === "Multiple choice" || model_section3.mainObj[0]['type'].name === "main idea"
                                        || model_section3.mainObj[0]['type'].name === "matching heading" || model_section3.mainObj[0]['type'].name === "Yes No NotGiven"
                                        || model_section3.mainObj[0]['type'].name === "classifying information" || model_section3.mainObj[0]['type'].name === "matching information with paragraphs"
                                        || model_section3.mainObj[0]['type'].name === "matching sentence ending" || model_section3.mainObj[0]['type'].name === "matching statements & people & ..."
                                        || model_section3.mainObj[0]['type'].name === "True False Not Given" || model_section3.mainObj[0]['type'].name === "short answer"
                                        || model_section3.mainObj[0]['type'].name === "sentence completion"){
                                    num = getTotalQuestion_1(model_section3.mainObj)
                                    for(var k=section1_Count+section2_Count+questionCount_3; k<section1_Count+section2_Count+questionCount_3+num+1; k++){
                                        vis = true
                                        if (k === section1_Count+section2_Count+questionCount_3+num+1-factor){factor+=1}
                                        if (k === section1_Count+section2_Count+questionCount_3){qtype = true}else{qtype = false}
                                        model_section3.append({"type": model_section3.mainObj[0]['type'].name,
                                                                  "number": k+1-section1_Count-section2_Count-questionCount_3,
                                                                  "qnumber":k+1,
                                                                  "qcountnum": section1_Count+section2_Count+num + questionCount_3,
                                                                  "qsection": qtype,
                                                                  "factor": factor,
                                                                  "ssquestion": j,
                                                                  "visible": vis})

                                    }

                                    questionCount_3 += num

                                }else if (model_section3.mainObj[0]['type'].name === "multiple choice list"){
                                    num = getTotalQuestion_1(model_section3.mainObj)
                                    for(var k=section1_Count+section2_Count+questionCount_3; k<section1_Count+section2_Count+questionCount_3+2; k++){
                                        vis = true
                                        if (k === section1_Count+section2_Count+questionCount_3+2-factor){factor+=1}
                                        if (k === section1_Count+section2_Count+questionCount_3){qtype = true}else{qtype = false}
                                        model_section3.append({"type": model_section3.mainObj[0]['type'].name,
                                                                  "number": k+1-section1_Count-section2_Count-questionCount_3,
                                                                  "qnumber":k+1,
                                                                  "qcountnum": section1_Count+section2_Count+num + questionCount_3,
                                                                  "qsection": qtype,
                                                                  "factor": factor,
                                                                  "ssquestion": j,
                                                                  "totalQuestions": num,
                                                                  "visible": vis})

                                    }
                                    checkbox_start3 = section1_Count+section2_Count+questionCount_3 + 1
                                    checkbox_end3 = section1_Count+section2_Count+questionCount_3 + num
                                    start_3 = checkbox_start3
                                    end_3 = checkbox_end3
                                    start_3 = checkbox_start3
                                    end_3 = checkbox_end3
                                    questionCount_3 += 1
                                }else if(model_section3.mainObj[0]['type'].name === "completing summary paragraph"){
                                    num = getTotalQuestion_2(model_section3.mainObj)
                                    for(var k=section1_Count+section2_Count+questionCount_3; k<section1_Count+section2_Count+questionCount_3+num+1; k++){
                                        if (k === section1_Count+section2_Count+questionCount_3+num+1-factor){factor+=1}
                                        if (k === section1_Count+section2_Count+questionCount_3){qtype = true}else{qtype = false}
                                        if (k === section1_Count+section2_Count+questionCount_3+1){vis = true}else{vis = false}
                                        model_section3.append({"type": model_section3.mainObj[0]['type'].name,
                                                                  "number": k+1-section1_Count-section2_Count-questionCount_3,
                                                                  "qnumber":k+1,
                                                                  "qcountnum": section1_Count+section2_Count+num + questionCount_3,
                                                                  "qsection": qtype,
                                                                  "factor": factor,
                                                                  "ssquestion": j,
                                                                  "visible": vis,
                                                                  "firstindex": section1_Count+section2_Count+questionCount_3+1})

                                    }

                                    questionCount_3 += num
                                }else if(model_section3.mainObj[0]['type'].name === "map and chart"){
                                    num = getTotalQuestion_3(model_section3.mainObj)
                                    for(var k=section1_Count+section2_Count+questionCount_3; k<section1_Count+section2_Count+questionCount_3+num+1; k++){
                                        if (k === section1_Count+section2_Count+questionCount_3+num+1-factor){factor+=1}
                                        if (k === section1_Count+section2_Count+questionCount_3){qtype = true}else{qtype = false}
                                        if (k === section1_Count+section2_Count+questionCount_3+1){vis = true}else{vis = false}
                                        model_section3.append({"type": model_section3.mainObj[0]['type'].name,
                                                                  "number": k+1-section1_Count-section2_Count-questionCount_3,
                                                                  "qnumber":k+1,
                                                                  "qcountnum": section1_Count+section2_Count+num + questionCount_3,
                                                                  "qsection": qtype,
                                                                  "factor": factor,
                                                                  "ssquestion": j,
                                                                  "visible": vis,
                                                                  "firstindex": section1_Count+section2_Count+questionCount_3+1})

                                    }
                                    questionCount_3 += num

                                }
                            }
                        }
                    }

                    //-- header text of section 1 --//
                    header: Item {
                        width: parent.width
                        height: lbl_lv_sec3.implicitHeight * 2

                        Label{
                            id: lbl_lv_sec3
                            text: "SECTION 3: QUESTIONS " + (section1_Count+section2_Count+1) + " - " + (section1_Count+section2_Count+section3_Count)
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.leftMargin: 10
                            font.bold: true
                            color: Utils.color_Tile_practice
                            renderType: Text.NativeRendering
                        }
                    }

                    delegate:Loader{

                        id: ld_sec3

                        width: parent.width
                        height: (item !== null) ? item.qHeight + (lbl_size.implicitHeight * 1.3) : 0
                        objectName: index

                        sourceComponent: {
                            if(model.type === "matching heading") {
                                if (model.qsection === true){
                                    return dropix
                                }else{
                                    return comp_dropdown_ix
                                }
                            }else if(model.type === "True False Not Given") {
                                if (model.qsection === true){
                                    return droptruefalse
                                }else{
                                    return comp_dropdown_TrueFalseNotGiven
                                }
                            }else if(model.type === "multiple choice list"){
                                if (model.qsection === true){
                                    return checkboxaf
                                }else{
                                    return comp_checkbox_AF
                                }
                            }else if(model.type === "Yes No NotGiven") {
                                if (model.qsection === true){
                                    return dropyesno
                                }else{
                                    return comp_dropdown_YesNoNotGiven
                                }
                            }else if(model.type === "completing summary paragraph") {
                                if (model.qsection === true & model.visible === false){
                                    return placeholder
                                }else if (model.qsection === false & model.visible === false){
                                    return null
                                }else{
                                    return comp_placeholder_paragraph
                                }
                            }else if(model.type === "sentence completion") {
                                if (model.qsection === true){
                                    return placeholderanypos
                                }else{
                                    return comp_placeholder_anyPostion
                                }
                            }else if(model.type === "short answer") {
                                if (model.qsection === true){
                                    return placeholderend
                                }else{
                                    return comp_placeholder_end
                                }
                            }else if(model.type === "Multiple choice" || model.type === "main idea") {
                                if (model.qsection === true){
                                    return radiotext
                                }else{
                                    return comp_radio_AD
                                }
                            }else if(model.type === "classifying information" || model.type === "matching information with paragraphs"
                                     || model.type === "matching sentence ending" || model.type === "matching statements & people & ...") {
                                if (model.qsection === true){
                                    return dropah
                                }else{
                                    return comp_dropdown_AH
                                }
                            }else if (model.type === "map and chart"){
                                if (model.qsection === true & model.visible === false){
                                    return mapandchart
                                }else if (model.qsection === false & model.visible === false){
                                    return null
                                }else{
                                    return comp_Map_and_Chart
                                }
                            }
                            else null
                        }

                        property var total: model.totalQuestions
                        property var modelnumber: model.number
                        property var modelQnumber: model.qnumber
                        property var modelQCountnumber: model.qcountnum
                        property var modelvisible: model.visible
                        property var obj: JSON.stringify(root._FullTestQuestions_3.get(model.ssquestion))
                        property real ratios: sizeRatio
                        property int index1: index

                    }
                }

                //-- Select Section --//
                Rectangle{
                    id: sectionButtons
                    width: parent.width
                    height: 50 * ratio
                    anchors.bottom: parent.bottom

                    color: "#dddddd"

                    Rectangle{
                        width: parent.width
                        height: 1
                        anchors.top: parent.top
                        color: "#bbbbbb"
                    }

                    TabBar {
                        id: bar
                        width: parent.width
                        height: parent.height - 2
                        anchors.bottom: parent.bottom
                        rotation: 180

                        font.pixelSize: Qt.application.font.pixelSize * 1.1
                        Material.accent: "#6c88b7"

                        currentIndex: 2

                        //-- Section 3 Button --//
                        TabButton {
                            id: testSection3
                            rotation: 180

                            signal checkSection3()
                            onCheckSection3: {
                                checked = true
                                //                                passageSection.selectPassage(false , false , true)
                                //                                myFilck.contentHeight = passageSection.passage3_Height
                            }

                            Label{
                                text: "Section 3"
                                font.bold: testSection3.checked ? true : false
                                font.pixelSize: testSection3.checked ? Qt.application.font.pixelSize * 1.1 : Qt.application.font.pixelSize
                                color: testSection3.checked ? "#000000" : "#aaaaaa"
                                anchors.centerIn: parent
                            }

                            onClicked: {
                                checkSection3()
                                lst_Answer_sec3.positionViewAtIndex(0 , ListView.Beginning)
                            }

                        }

                        //-- Section 2 Button --//
                        TabButton {
                            id: testSection2
                            rotation: 180

                            signal checkSection2()
                            onCheckSection2: {
                                checked = true
                                //                                passageSection.selectPassage(false , true , false)
                                //                                myFilck.contentHeight = passageSection.passage2_Height
                            }

                            Label{
                                text: "Section 2"
                                font.bold: testSection2.checked ? true : false
                                font.pixelSize: testSection2.checked ? Qt.application.font.pixelSize * 1.1 : Qt.application.font.pixelSize
                                color: testSection2.checked ? "#000000" : "#aaaaaa"
                                anchors.centerIn: parent
                            }

                            onClicked: {
                                checkSection2()
                                lst_Answer_sec2.positionViewAtIndex(0 , ListView.Beginning)
                            }
                        }

                        //-- Section 1 Button --//
                        TabButton {
                            id: testSection1
                            rotation: 180

                            signal checkSection1()
                            onCheckSection1: {
                                checked = true
                                //                                passageSection.selectPassage(true , false , false)
                                //                                myFilck.contentHeight = passageSection.passage1_Height
                            }

                            Label{
                                text: "Section 1"
                                font.bold: testSection1.checked ? true : false
                                font.pixelSize: testSection1.checked ? Qt.application.font.pixelSize * 1.1 : Qt.application.font.pixelSize
                                color: testSection1.checked ? "#000000" : "#aaaaaa"
                                anchors.centerIn: parent
                            }

                            onClicked: {
                                checkSection1()
                                lst_Answer_sec1.positionViewAtIndex(0 , ListView.Beginning)
                            }

                        }

                    }
                }

            }


        }

        //-- FOOTER of ReadingTestPage --//
        ReadingFooter_Body{
            id: footer_Reading
            visible: (sView.currentItem.objectName === readingTest.objectName) ? true : false
            Layout.fillWidth: true
            Layout.preferredHeight: height

        }
    }

    //-- shadow of header --//
    DropShadow {
        anchors.fill: readingTest_Header
        horizontalOffset: 0
        verticalOffset: 3
        radius: 8.0
        samples: 17
        color: "#80000000"
        source: readingTest_Header
    }

    //-- header section --//
    ReadingHeader_Body{
        id: readingTest_Header
        width: parent.width
        height: 60 * ratio

        isMainTest: true

        onChangeFontSize: {
            //            passageSection.textFontSize.pixelSize = Qt.application.font.pixelSize * 0.9 + readingTest_Header.fontResize
            textArea.font.pixelSize = Qt.application.font.pixelSize + readingTest_Header.fontResize
            textArea_2.font.pixelSize = Qt.application.font.pixelSize + readingTest_Header.fontResize
            textArea_3.font.pixelSize = Qt.application.font.pixelSize + readingTest_Header.fontResize
            sizeRatio = size + 1
            //        console.log("ratio: " + size + sizeRatio)
        }

        onClick_Eraser: {
            document.highlightTextColor = readingTextSection.color
            document_2.highlightTextColor = readingTextSection.color
            document_3.highlightTextColor = readingTextSection.color
            console.log("You chouse: " + readingTextSection.color)
            //            documentAnswer.highlightTextColor = readingAnswerSection.color

            textArea.deselect()
            textArea_2.deselect()
            textArea_3.deselect()
            //            questionTest.objTxt.deselect()
        }

        onClick_FontColor: {
            document.highlightTextColor = highlightDialog.color
            document_2.highlightTextColor = highlightDialog.color
            document_3.highlightTextColor = highlightDialog.color
            console.log("You chouse: " + highlightDialog.color)
            //            documentAnswer.highlightTextColor = highlightDialog.color
            textArea.deselect()
            textArea_2.deselect()
            textArea_3.deselect()
            //            questionTest.objTxt.deselect()
        }

        onClick_Share: {

        }

        onClick_Exit: {

        }
    }

    //-- problem report popup --//
    ProblemReport_Popup{
        id: problemReport

        x: (root.width / 2) - (width / 2)
        y: (root.height / 2) - (height / 2)
    }

    //-- Popup for review Answer's of Tests --//
    ReviewTest_Popup{
        id:reviewTest

        model_a: model_ans

        x: (root.width / 2) - (width / 2)
        y: (root.height / 2) - (height / 2) - (mainHeader.height / 2)
    }

    Component{
        id: radiotext
        RadioADQuestion{
            width: parent.width
            objectName: index1
            height: 100
            sizeR: ratios //-- module size --//
            sourceObj: obj
            ques_num: modelQnumber
            ques_range: modelQCountnumber
        }
    }

    Component{
        id: dropix
        Dropdown_ixQuestion{
            width: parent.width
            objectName: index1
            height: 100
            sizeR: ratios //-- module size --//
            sourceObj: obj
            ques_num: modelQnumber
            ques_range: modelQCountnumber
        }
    }

    Component{
        id: placeholder
        PlaceholderQuestion{
            width: parent.width
            objectName: index1
            height: 100
            sizeR: ratios //-- module size --//
            sourceObj: obj
            ques_num: modelQnumber
            ques_range: modelQCountnumber
        }
    }

    Component{
        id: dropah
        Dropdown_AHQuestion{
            width: parent.width
            objectName: index1
            height: 100
            sizeR: ratios //-- module size --//
            sourceObj: obj
            ques_num: modelQnumber
            ques_range: modelQCountnumber
        }
    }

    Component{
        id: dropyesno
        Dropdown_YesNoQuestion{
            width: parent.width
            objectName: index1
            height: 100
            sizeR: ratios //-- module size --//
            sourceObj: obj
            ques_num: modelQnumber
            ques_range: modelQCountnumber

        }
    }

    Component{
        id: droptruefalse
        Dropdown_TrueFalseQuestion{
            width: parent.width
            objectName: index1
            height: 100
            sizeR: ratios //-- module size --//
            sourceObj: obj
            ques_num: modelQnumber
            ques_range: modelQCountnumber

        }
    }

    Component{
        id: placeholderend
        PlaceholderEndQuestion{
            width: parent.width
            objectName: index1
            height: 100
            sizeR: ratios //-- module size --//
            sourceObj: obj
            ques_num: modelQnumber
            ques_range: modelQCountnumber

        }
    }

    Component{
        id: placeholderanypos
        PlaceholderanyposQoestion{
            width: parent.width
            objectName: index1
            height: 100
            sizeR: ratios //-- module size --//
            sourceObj: obj
            ques_num: modelQnumber
            ques_range: modelQCountnumber

        }
    }

    Component{
        id: checkboxaf

        Checkbox_AFQuestion{
            width: parent.width
            objectName: index1
            height: 100
            sizeR: ratios //-- module size --//
            sourceObj: obj
            ques_num: modelQnumber
            ques_range: modelQCountnumber

        }
    }

    Component{
        id: mapandchart

        Map_and_chartQuestion{
            width: parent.width
            objectName: index1
            height: 100
            sizeR: ratios //-- module size --//
            sourceObj: obj
            ques_num: modelQnumber
            ques_range: modelQCountnumber

        }
    }

    //-- Dropdown_i-x --//
    Component{
        id: comp_dropdown_ix

        Dropdown_ix{
            id: dropdown_ix

            width: parent.width
            objectName: index1
            height: 100
            sizeR: ratios //-- module size --//
            sourceObj: obj
            ques_num: modelnumber
            qnumber: modelQnumber

        }
    }

    //-- Dropdown_TrueFalseNotGiven --//
    Component{
        id: comp_dropdown_TrueFalseNotGiven

        Dropdown_TrueFalseNotGiven{
            id: dropdown_TrueFalseNotGiven

            width: parent.width
            objectName: index1
            height: 100
            sizeR: ratios //-- module size --//
            sourceObj: obj
            ques_num: modelnumber
            qnumber: modelQnumber

        }
    }

    //-- Checkbox_A-F --//
    Component{
        id: comp_checkbox_AF

        Checkbox_AF{
            id: checkbox_AF

            width: parent.width
            objectName: index1
            height: 100
            sizeR: ratios //-- module size --//
            sourceObj: obj
            ques_num: modelnumber
            totalnumber: total
            qnumber: modelQnumber

        }
    }

    //-- Dropdown_TrueFalseNotGiven --//
    Component{
        id: comp_dropdown_YesNoNotGiven

        Dropdown_YesNoNotGiven{
            id: dropdown_YesNoNotGiven

            width: parent.width
            objectName: index1
            height: 100
            sizeR: ratios //-- module size --//
            sourceObj: obj
            ques_num: modelnumber
            qnumber: modelQnumber

        }
    }

    //-- Placeholder_TwoWord --//
    Component{
        id: comp_placeholder_TwoWord

        Placeholder_TwoWord{
            id: placeholder_TwoWord

            width: parent.width
            objectName: index1
            height: 100
            sizeR: ratios //-- module size --//
            sourceObj: obj

        }
    }

    //-- Placeholder in middle paragraph --//
    Component{
        id: comp_placeholder_paragraph

        Placeholder_TwoWord{
            id: placeholder_paragraph

            width: parent.width
            objectName: index1
            height: 100
            sizeR: ratios //-- module size --//
            sourceObj: obj
            ques_num: modelnumber
            qnumber: modelQnumber

        }
    }

    //-- Radio_AD --//
    Component{
        id: comp_radio_AD

        Radio_AD{
            id: radio_AD

            width: parent.width
            objectName: index1
            height: 100
            sizeR: ratios //-- module size --//
            sourceObj: obj
            ques_num: modelnumber
            qnumber: modelQnumber
        }
    }

    //-- Placeholder in end of question --//
    Component{
        id: comp_placeholder_end

        Short_Answer{
            id: placeholder_end

            width: parent.width
            objectName: index1
            height: 100
            sizeR: ratios //-- module size --//
            sourceObj: obj
            ques_num: modelnumber
            qnumber: modelnumber

        }
    }

    //-- Placeholder in end of question --//
    Component{
        id: comp_Map_and_Chart

        Map_and_Chart{
            id: map_and_Chart

            width: parent.width
            objectName: index1
            height: 100
            sizeR: ratios //-- module size --//
            sourceObj: obj
            ques_num: modelnumber
            qnumber: modelQnumber

        }
    }

    //-- dropdown_AH --//
    Component{
        id: comp_dropdown_AH

        Dropdown_AH{
            id: dropdown_AH

            width: parent.width
            objectName: index1
            height: 100
            sizeR: ratios //-- module size --//
            sourceObj: obj
            ques_num: modelnumber
            qnumber: modelQnumber

        }
    }

    //-- Placeholder in any Postion of question --//
    Component{
        id: comp_placeholder_anyPostion

        Sentence_Completion{
            id: placeholder_anyPostion

            width: parent.width
            objectName: index1
            height: 100
            sizeR: ratios //-- module size --//
            sourceObj: obj
            ques_num: modelnumber
            qnumber: modelnumber

        }
    }

    //-- Get number of questions in questions of type 1 --//
    function getTotalQuestion_1(data){
        var questionCount = 0
        questionCount = data[0]['questions'].length
        return questionCount
    }

    //-- Get number of questions in questions of type 2 --//
    function getTotalQuestion_2(data){

        var questionCount = 0
        questionSplit = []
        questionText = ""

        questionText = ConvertRTFtoPlain.rtfToPlain(data[0]['questions'][0]['text'])

        questionSplit = questionText.split(" ")

        questionCount = 0
        for(var i =  0 ; i < questionSplit.length ; i++) if(questionSplit[i] === "_BLANK") questionCount++;
        return questionCount
    }

    //-- Get number of questions in questions of type 3 --//
    function getTotalQuestion_3(data){
        var questionCount = 0
        questionText = ""
        trArray = []
        questionText = ConvertRTFtoPlain.removeBackSlashT(data[0]['questions'][0]['text'])

        var tableIndx = questionText.indexOf('<table')
        if(tableIndx !== -1){

            var indx = questionText.indexOf('<tr')
            while(indx !== -1){
                trArray.push({'row': questionText.substring(indx , questionText.indexOf('</tr>') + 5)})
                questionText = questionText.replace(questionText.substring(indx , questionText.indexOf('</tr>') + 5) , "")
                indx = questionText.indexOf('<tr');
            }
            questionCount = trArray.length - 1
        }
        return questionCount
    }

}
