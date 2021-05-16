import QtQuick 2.14
//import QtQuick.Controls 2.2
import QtQuick.Controls 2.14
import QtQuick.Window 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import Qt.labs.platform 1.0

import io.qt.examples.texteditor 1.0

import "./../../../../Fonts/Icon.js" as Icons
import "./../../../Utils/Utils.js" as Utils
import "./../../../Utils/Enum.js" as Enum
import "./../../../Utils/ConvertRTFtoPlain.js" as ConvertRTFtoPlain

import "./../../../Modules"
import "./../../../Modules/TypesOfQuestions"
import "./../../../Modules/QuestionsText"
import "./../../ListModels"
import "./../../ListModels/QuestionListModel"
import "./../../../Utils/ReadingFooter"
import "./../../../Utils/ReadingHeader"


Item {
    id:rootPassageTestPage

    property var currentObject

    property alias mainText: textArea.text

    property var questionText: ""
    property var questionSplit: []
    property var question_model
    property var trArray: []

    //-- save question JSON file --//
    property var questionObj
    property var quesCheckNum

    //-- Question Type Enum --//
    property string _QST_DROP_IX: "DROPDOWN_i-x"
    property string m_QST_DROP_IX: "matching heading"
    property string _QST_DROP_TFNG: "DROPDOWN_TRUE-FALSE-NOTGIVEN"
    property string m_QST_DROP_TFNG: "True False Not Given"
    property string _QST_CHECK_AF: "CHECKBOX_A-F"
    property string m_QST_CHECK_AF: "Multiple Choice"
    property string _QST_DROP_YNNG: "DROPDOWN_YES-NO-NOTGIVEN"
    property string _QST_HOLDER_2W: "PLACEHOLDER_TwoWord"
    property string _QST_HOLDER_3W: "PLACEHOLDER_ThreeWord"
    property string m_QST_RADIO_AD: "RADIO_A-D"
    property string _QST_DROP_AH: "DROPDOWN_A-H"

    objectName: "PassageTestPage"
    property int section1_Count: {
        var counter = 0
        for(var p = 0 ; p < root._PassageTestQuestions.length ; p++){
            counter += JSON.parse(root._PassageTestQuestions[p].answer).length

        }
        return counter;
    }

    property real handlerWidth: 15

    property real sizeRatio: 1

    signal changeFontSize(var size)
    onChangeFontSize: {
        textArea.font.pixelSize = Qt.application.font.pixelSize + passageTest_Header.fontResize
        sizeRatio = size * 3 + 1
        //        console.log("ratio: " + size + sizeRatio)
    }

    //-- fill answer --//
    signal fillAnswer(string question, string answer)
    onFillAnswer: {
        log("answer to " + question + ": " + answer)
        model_ans.setProperty((parseInt(question)-1), "answer", answer)

        //        print(model_ans.get(0)["answer"])
    }

    //-- when width changed , SplitHandle goto Center --//
    onWidthChanged: {

        passageTextSection.width = (rootPassageTestPage.width / 2) - (handlerWidth / 2) - 5.5

    }

    //--- Timer Signals ---//
    //-- Timer Start --//
    signal startTimer
    onStartTimer: {
        footer_Passage.startTimer()
    }

    //-- Timer Stop --//
    signal stopTimer
    onStopTimer: {
        footer_Passage.stopTimer()
    }

    //-- Timer Stop --//
    signal resetTimer
    onResetTimer: {
        footer_Passage.resetTimer()
    }

    //-- Get number of questions in questions of type 1 --//
    function getTotalQuestion_1(data){
        questionCount = data[0]['questions'].length
        quesCheckNum = questionCount
    }

    //-- Get number of questions in questions of type 2 --//
    function getTotalQuestion_2(data){

        questionText = ConvertRTFtoPlain.rtfToPlain(data[0]['questions'][0]['text'])

        questionSplit = questionText.split(" ")

        questionCount = 0
        for(var i =  0 ; i < questionSplit.length ; i++) if(questionSplit[i] === "_BLANK") questionCount++;
        quesCheckNum = questionCount
    }

    //-- Get number of questions in questions of type 3 --//
    function getTotalQuestion_3(data){
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
         quesCheckNum = questionCount
    }

    //-- Get number of questions in questions of type 4 --//
    function getTotalQuestion_4(data){
        questionCount = data[0]['questions'].length
        quesCheckNum = 1
    }

    ListModel{
        id: model_ans

        Component.onCompleted: {
            //-- preset answer model --//
            for(var j=0; j<quesCheckNum; j++){
                model_ans.append({"answer":""})
                model_answer.append({"answer":""})
            }
            startTimer()
            questionsCheckCount = quesCheckNum

            var mainObj = []
            mainObj.push(JSON.parse(JSON.stringify(root._PassageTestQuestions.get(0))))
            if(mainObj[0]['type'].name === "Multiple choice"){
                getTotalQuestion_1(mainObj)
                for(var i=0; i<quesCheckNum; i++){
                    model_answer.setProperty(i, "answer", "A")
                }
            }else if (mainObj[0]['type'].name === "completing summary paragraph"){
                getTotalQuestion_2(mainObj)
                for(var i=0; i<quesCheckNum; i++){
                    model_answer.setProperty(i, "answer", "A")
                }
            }else if (mainObj[0]['type'].name === "True False Not Given" || mainObj[0]['type'].name === "classifying information"
                      || mainObj[0]['type'].name === "matching heading" || mainObj[0]['type'].name === "Yes No NotGiven"
                      || mainObj[0]['type'].name === "matching sentence ending" || mainObj[0]['type'].name === "matching information with paragraphs"
                      || mainObj[0]['type'].name === "sentence completion" || mainObj[0]['type'].name === "matching statements & people & ..."
                      || mainObj[0]['type'].name === "short answer"){
                getTotalQuestion_1(mainObj)
                for(var i=0; i<quesCheckNum; i++){
                    model_answer.setProperty(i, "answer", mainObj[0]['questions'][i]['answers'][0]['text'])
                }
            }else if (mainObj[0]['type'].name === "map and chart"){
                getTotalQuestion_3(mainObj)
                for(var i=0; i<quesCheckNum; i++){
                    model_answer.setProperty(i, "answer", "A")
                }
            }else if (mainObj[0]['type'].name === "main idea"){
                getTotalQuestion_3(mainObj)
                for(var i=0; i<quesCheckNum; i++){
                    model_answer.setProperty(i, "answer", "A")
                }
            }else if (mainObj[0]['type'].name === "multiple choice list"){
                getTotalQuestion_3(mainObj)
                for(var i=0; i<quesCheckNum; i++){
                    model_answer.setProperty(i, "answer", "A,B")
                }
            }
        }
    }

    Component.onCompleted: {


        //        console.log(JSON.stringify(Utils.data))
//        questionObj = Utils.data
//        log("--=-=-= dataz loaded")
        //        log("assa0" + questionObj.Sections[0].question_count)

        //-- check section count --//
//        if(questionObj.Sections.length !== 3){
//            log("Section count is not equal to 3");
//            return
//        }

        //-- fill section 1 --//
        //        model_section1.clear()
        //        for(var j=0; j<questionObj.Sections[0].questions.length; j++){

        //            console.log("\t ["+j+"] -> " + questionObj.Sections[0].questions[j].type)
        //            model_section1.append({"type": questionObj.Sections[0].questions[j].type})
        //        }

        //-- preset answer model --//
//        for(var i=0; i<questionObj.question_count; i++){
//            model_ans.append({"answer":""})
//        }

        /*for(var i=0; i<questionObj.Sections.length; i++){
            console.log("["+i+"] -> " + questionObj.Sections[i]["section"])


        }*/

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
            Layout.preferredHeight: 60

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
                id:passageTextSection
                SplitView.preferredWidth: (rootPassageTestPage.width / 2) - (handlerWidth / 2) - 5.5 // 5.5 => width of StopWatch Icon / 4 => 22 / 4 = 5.5

                SplitView.minimumWidth: 200
                SplitView.maximumWidth: rootPassageTestPage.width - (50)

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

                    TextArea.flickable: TextArea {
                        id: textArea
                        text: root._PaasageText
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
                        rightPadding: 12
                        topPadding: 0
                        bottomPadding: 0
                        //                        background: null

                        onLinkActivated: Qt.openUrlExternally(link)
                    }

                    ScrollBar.vertical: ScrollBar {}
                }

                color: "lightblue"

                //-- passage --//  VISIBLE = FALSE
                Flickable{
                    id:myFilck
                    visible: false

                    width: parent.width
                    height: parent.height

                    flickableDirection: Flickable.VerticalFlick
                    boundsBehavior: Flickable.StopAtBounds

                    clip: true

                    contentWidth: width - passageTextSection_Scroll.width
                    contentHeight: passage1.contentHeight

                    Item {
                        anchors.fill: parent

                        Flickable{
                            id: passage1
                            anchors.fill: parent
                            contentWidth: width
                            contentHeight: descriptSection1.height + img_Sec1.height + headingBI1.height + mainTextPSG1.height

                            Column{
                                width: parent.width
                                spacing: 2

                                //-- DESCRIPTION OF THIS SECTION --//
                                Label{
                                    id: descriptSection1
                                    width: parent.width
                                    height: implicitHeight + 20

                                    text: "You should spend about 20 minutes on Questions 1-13, which are based on Reading Passage 1 below."
                                    clip: true
                                    wrapMode: Text.WordWrap
                                    font.pixelSize: Qt.application.font.pixelSize * 0.9
                                    font.family: iranSans.name
                                    anchors.margins: 10
                                }

                                //-- Image --//
                                Image {
                                    id: img_Sec1
                                    width: parent.width - 20
                                    height: sourceSize.height / (sourceSize.width / width)

                                    horizontalAlignment: Qt.AlignHCenter

                                    fillMode: Image.PreserveAspectFit

                                    source: "qrc:/Content/Images/Other/section 1_1.png"
                                }

                                //-- Heading in Below Image --//
                                Label{
                                    id: headingBI1
                                    width: parent.width
                                    height: implicitHeight + 20

                                    horizontalAlignment: Qt.AlignHCenter
                                    verticalAlignment: Qt.AlignVCenter

                                    text: "The Concept of Childhood in Western Countries"
                                    clip: true
                                    wrapMode: Text.WordWrap
                                    font.pixelSize: Qt.application.font.pixelSize * 1.8
                                    font.family: iranSans.name
                                    font.bold: true
                                    anchors.margins: 10
                                }

                                //-- Main Text Passage_1 --//
                                TextArea{
                                    id:mainTextPSG1
                                    width: parent.width
                                    height: implicitHeight

                                    readOnly: true
                                    selectByMouse: true
                                    text: Enum._SAMPLE_TEXT_PASSAGE_1
                                    clip: true
                                    wrapMode: Text.WordWrap
                                    font.pixelSize: Qt.application.font.pixelSize * 0.9
                                    font.family: iranSans.name
                                    Layout.margins: 10

                                    Material.accent: "transparent"

                                    background: Rectangle{
                                        color: "#00ffffff"
                                    }
                                }
                            }

                        }
                    }

                    ScrollBar.vertical: ScrollBar {
                        id: passageTextSection_Scroll
                        visible: false
                        parent: myFilck.parent
                        anchors.top: myFilck.top
                        anchors.right: myFilck.right
                        anchors.bottom: myFilck.bottom

                        stepSize: 0.005

                        width: 15

                        policy: ScrollBar.AlwaysOn
                        //snapMode: ScrollBar.SnapAlways
                    }

                }

            }

            //-- Answers Section --//
            Rectangle {
                id: readingAnswerSection

                SplitView.minimumWidth: 200
                SplitView.fillWidth: true

                color: "#ffffff"

//                DocumentHandler {
//                    id: documentAnswer
//                    document: currentObject.textDocument
//                    cursorPosition: currentObject.cursorPosition
//                    selectionStart: currentObject.selectionStart
//                    selectionEnd: currentObject.selectionEnd

//                    //                    textColor: colorDialog.color
//                    //                    Component.onCompleted: document.load("qrc:/Content/Codes/Pages/Test/HTML/Test.htm")
//                    //                    onLoaded: {
//                    //                        textArea.text = text
//                    //                    }
//                }


                ListModel{
                    id: model_mv
                    property var mainObj: []

                    Component.onCompleted: {
                        mainObj.push(JSON.parse(JSON.stringify(root._PassageTestQuestions.get(0))))
                        if(model_mv.mainObj[0]['type'].name === "Multiple choice" || model_mv.mainObj[0]['type'].name === "main idea"
                                || model_mv.mainObj[0]['type'].name === "matching heading" || model_mv.mainObj[0]['type'].name === "Yes No NotGiven"
                                || model_mv.mainObj[0]['type'].name === "classifying information" || model_mv.mainObj[0]['type'].name === "matching information with paragraphs"
                                || model_mv.mainObj[0]['type'].name === "matching sentence ending" || model_mv.mainObj[0]['type'].name === "matching statements & people & ..."
                                || model_mv.mainObj[0]['type'].name === "True False Not Given" || model_mv.mainObj[0]['type'].name === "short answer"
                                || model_mv.mainObj[0]['type'].name === "sentence completion"){
                            getTotalQuestion_1(model_mv.mainObj)
                            for(var i=0; i<questionCount+1; i++){
                                model_mv.append({
                                                    'number': "",
                                                    "qcountnum": "",
                                                })
                                model_mv.setProperty(i, "number", i+1)
                                model_mv.setProperty(i, "qcountnum", questionCount)

                            }
                        }else if(model_mv.mainObj[0]['type'].name === "completing summary paragraph"){
                            getTotalQuestion_2(model_mv.mainObj)
                            for(var i=0; i<questionCount+1; i++){
                                model_mv.append({
                                                    'number': "",
                                                    "ques_num": ""
                                                })
                                model_mv.setProperty(i, "number", i+1)
                                model_mv.setProperty(i, "qcountnum", questionCount)
                            }
                        }else if(model_mv.mainObj[0]['type'].name === "map and chart"){
                            getTotalQuestion_3(model_mv.mainObj)
                            for(var i=0; i<questionCount+1; i++){
                                model_mv.append({
                                                    'number': "",
                                                    "ques_num": ""
                                                })
                                model_mv.setProperty(i, "number", i+1)
                                model_mv.setProperty(i, "qcountnum", questionCount)
                            }
                        }else if (model_mv.mainObj[0]['type'].name === "multiple choice list"){
                            getTotalQuestion_4(model_mv.mainObj)
                            for(var i=0; i<2; i++){
                                model_mv.append({
                                                    'number': "",
                                                    "ques_num": ""
                                                })
                                model_mv.setProperty(i, "number", i+1)
                                model_mv.setProperty(i, "qcountnum", questionCount)
                            }
                        }

                        passage = true
                        qN1 = questionCount
                    }
                }

                //-- lv of section 1 --//
                ListView{
                    id: lst_Answer_sec1

                    width: parent.width - 8
                    height: parent.height
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
                        //                        parent: lst_Answer_sec1
                        anchors.fill: itm_scroll
                    }

                    //                    model: model_questions
                    model: model_mv
                    //-- header text of section 1 --//

                    delegate:Loader{

                        id: ld

                        property var modelnumber: number
                        property var qCountNum: model.qcountnum
                        property var obj: JSON.stringify(root._PassageTestQuestions.get(0))
                        property real ratios: sizeRatio
                        property int index1: index
                        property var qFont: nunito_italic.name

                        width: parent.width
                        height: (item !== null) ? item.qHeight + (lbl_size.implicitHeight * 1.3) : 0
                        objectName: index

                        sourceComponent: {
                            if(model_mv.mainObj[0]['type'].name === "Multiple choice" || model_mv.mainObj[0]['type'].name === "main idea"){
                                if (model.number === "1"){
                                    return radiotext
                                }else{
                                    return comp_radio_AD
                                }
                            }
                            else if(model_mv.mainObj[0]['type'].name === "matching heading") {
                                if (model.number === "1"){
                                    return dropix
                                }else{
                                    return comp_dropdown_ix
                                }
                            }
                            else if(model_mv.mainObj[0]['type'].name === "completing summary paragraph") {
                                if (model.number === "1"){
                                    return placeholder
                                }else if (model.number === "2"){
                                    return comp_placeholder_paragraph
                                }else{
                                    return null
                                }
                            }
                            else if(model_mv.mainObj[0]['type'].name === "classifying information" || model_mv.mainObj[0]['type'].name === "matching information with paragraphs"
                                    || model_mv.mainObj[0]['type'].name === "matching sentence ending" || model_mv.mainObj[0]['type'].name === "matching statements & people & ..."){
                                if (model.number === "1"){
                                    return dropah
                                }else{
                                    return comp_dropdown_AH
                                }
                            }
                            else if(model_mv.mainObj[0]['type'].name === "Yes No NotGiven") {
                                if (model.number === "1"){
                                    return dropyesno
                                }else{
                                    return comp_dropdown_YesNoNotGiven
                                }
                            }
                            else if(model_mv.mainObj[0]['type'].name === "True False Not Given") {
                                if (model.number === "1"){
                                    return droptruefalse
                                }else{
                                    return comp_dropdown_TrueFalseNotGiven
                                }
                            }
                            else if(model_mv.mainObj[0]['type'].name === "short answer") {
                                if (model.number === "1"){
                                    return placeholderend
                                }else{
                                    return comp_placeholder_end
                                }
                            }
                            else if(model_mv.mainObj[0]['type'].name === "sentence completion") {
                                if (model.number === "1"){
                                    return placeholderanypos
                                }else{
                                    return comp_placeholder_anyPostion
                                }
                            }
                            else if(model_mv.mainObj[0]['type'].name === "multiple choice list") {
                                if (model.number === "1"){
                                    return checkboxaf
                                }else{
                                    lst_Answer_sec1.spacing = 15
                                    return comp_checkbox_AF
                                }
                            }
                            else if(model_mv.mainObj[0]['type'].name === "map and chart") {
                                if (model.number === "1"){
                                    return mapandchart
                                }else if (model.number === "2"){
                                    return comp_Map_and_Chart
                                }else{
                                    return null
                                }
                            }
                            else null
                        }



                    }

                }



            }
        }

        //-- FOOTER of ReadingTestPage --//
        QuestionList{
            id: footer_Passage

            //            question_data: JSON.stringify(root._PassageTestQuestions.get(0))
            Layout.fillWidth: true
            Layout.preferredHeight: height
        }
    }

    //-- shadow of header --//
    DropShadow {
        anchors.fill: passageTest_Header
        horizontalOffset: 0
        verticalOffset: 3
        radius: 8.0
        samples: 17
        color: "#80000000"
        source: passageTest_Header
    }

    //-- header section --//
    ReadingHeader_Body{
        id: passageTest_Header
        width: parent.width
        height: 60

        isMainTest: false


        onClick_FontColor: {
            document.highlightTextColor = highlightDialog.color
        }

        onClick_Eraser: {
            document.highlightTextColor = passageTextSection.color
        }

        onChangeFontSize: {
            textArea.font.pixelSize = Qt.application.font.pixelSize + passageTest_Header.fontResize
            sizeRatio = size + 1
            console.log("ratio: " + size +"  "+ sizeRatio)
        }

    }

    //-- problem report popup --//
    ProblemReport_Popup{
        id: problemReport

        x: (root.width / 2) - (width / 2)
        y: (root.height / 2) - (height / 2)
    }

    //-- Popup for review Answer's of Tests --//
    ReviewPassge_Popup{
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
            ques_num: modelnumber
            ques_range: qCountNum
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
            ques_num: modelnumber
            ques_range: qCountNum
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
            ques_num: modelnumber
            ques_range: qCountNum
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
            ques_num: modelnumber
            ques_range: qCountNum
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
            ques_num: modelnumber
            ques_range: qCountNum

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
            ques_num: modelnumber
            ques_range: qCountNum

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
            ques_num: modelnumber
            ques_range: qCountNum

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
            ques_num: modelnumber
            ques_range: qCountNum

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
            ques_num: modelnumber
            ques_range: qCountNum

        }
    }

    Component{
        id: mapandchart

        Map_and_chartQuestion{
            num: questionCount
            width: parent.width
            objectName: index1
            height: 100
            sizeR: ratios //-- module size --//
            sourceObj: obj
            ques_num: modelnumber
            ques_range: qCountNum

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
            qnumber: modelnumber

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
            qnumber: modelnumber
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
            qnumber: modelnumber
            totalnumber: qCountNum

        }
    }

    //-- Dropdown_YesNoNotGiven --//
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
            qnumber: modelnumber

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
            qnumber: modelnumber

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

    //-- Radio_AD --//
    Component{
        id: comp_radio_AD

        Radio_AD{
            id: radio_AD

            width: parent.width
//                   height: item.qHeight + (lbl_size_2.implicitHeight * 1.3)
            objectName: index1
            height: 250
            sizeR: ratios //-- module size --//
            sourceObj: obj
            ques_num: modelnumber
            qnumber: modelnumber

        }
    }

    //-- dropdown_AH --//
    Component{
        id: comp_dropdown_AH

        Dropdown_AH{
            id: dropdown_AH

            width: parent.width
            objectName: index1
            height: 250
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
            qnumber: modelnumber

        }
    }


    //-- test --//
    Button{
        visible: false
        text: "load"
        onClicked: {
            questionObj = Utils.data_zabanup
            log("-=-= data loaded")
            log(questionObj.length)

            //-- check section count --//
            /*if(questionObj.questions.length !== 3){
                log("questions count is not equal to 3");
                return
            }*/

            //-- fill section 1 --//
            mymodel_section1.clear()
            for(var j=0; j<questionObj.questions.length; j++){

                console.log("\t ["+j+"] -> " + questionObj.questions[j].type.name)
                mymodel_section1.append({"type": questionObj.questions[j].type.name})
            }

            //-- preset answer model --//
            for(var i=0; i<questionObj.questions.length; i++){
                model_ans.append({"answer":""})
            }

        }
    }

}
