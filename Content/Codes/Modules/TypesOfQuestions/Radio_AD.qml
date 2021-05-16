import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.13

import "./../../Utils/Utils.js" as Utils
import "./../../Modules/TypesOfQuestions"

import "./../../Modules"

Item {
    id: rootQ
    width: parent.width
    height: qHeight

    property var ques_num
    property var qnumber
    property var sourceObj
    property var label_vis: true
    property var mainObj: []
    onSourceObjChanged: {
        mainObj.push(JSON.parse(sourceObj))

        //log("-=-=-=- 333 data: " + mainObj[0]['questions'][0]['text']/*mainObj[0]['questions'][0]['answers'][0]['text']*/)
//        log(sourceObj.questions.length)
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
    Label{id: lbl_size; visible: false; text: "Not Given"; font.pixelSize: Qt.application.font.pixelSize * sizeRatio}

    //-- body --//
    ColumnLayout{
        id: colbody

        anchors.fill: parent

        ListView{
            id: lv_options

            Layout.fillWidth: true
            Layout.margins: 5
            //-- todo: fixe hardcode height --//
            Layout.preferredHeight: 300 * (mainObj[0]['questions'].length) //lv_options.contentHeigh
            spacing: 2

            model: 1
            interactive: false

            delegate: Multiple_Choice{
                id: multiple_Choice

                width: parent.width
                //            Layout.rightMargin: 10

                qNumber: qnumber - 1//sourceObj.questions[index].number
                qText: mainObj[0]['questions'][ques_num - 2]['text']
                sizeR: slider_size.value

                choice1.text: mainObj[0]['questions'][ques_num - 2]['answers'][0].text
                choice2.text: mainObj[0]['questions'][ques_num - 2]['answers'][1].text
                choice3.text: mainObj[0]['questions'][ques_num - 2]['answers'][2].text
                choice4.text: mainObj[0]['questions'][ques_num - 2]['answers'][3].text

                choice1.checked: model_ans.get(parseInt(qNumber)-1).answer === "A" ? true : false
                choice2.checked: model_ans.get(parseInt(qNumber)-1).answer === "B" ? true : false
                choice3.checked: model_ans.get(parseInt(qNumber)-1).answer === "C" ? true : false
                choice4.checked: model_ans.get(parseInt(qNumber)-1).answer === "D" ? true : false
            }
        }

        Item{Layout.fillHeight: true}

    }

    //-- (unchange) change size fo test --//
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
