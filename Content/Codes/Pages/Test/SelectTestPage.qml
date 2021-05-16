import QtQuick 2.14
import QtQuick.Controls 2.2
import QtQuick.Window 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import QtQml.Models 2.14

import "./../../../Fonts/Icon.js" as Icons
import "./../ListModels"
import "./../ListModels/FilterModels"
import "./../Test/CategoryPages"
import "./../../Modules"
import "./../../Modules/SideFilterItems"
import "./../../Utils/Enum.js" as Enum
import "./../../Utils/Utils.js" as Util
import "./../../REST/apiService.js" as Service
import "./../../Utils/ConvertRTFtoPlain.js" as ConvertRTFtoPlain



Item {
    id:rootSelectTestPage

    objectName: "SelectTestPage"

    signal filterQnumber(var state)

    property var qNumberFilterstate: "A"

    //-- Background --//
    Rectangle{
        anchors.fill: parent
        color: "#ffffff"
    }

    signal fullTestState
    onFullTestState: {
        root_Subject.isExpanded = false
        header_Subject.enabled = false

        root_ToQ.isExpanded = false
        header_ToQ.enabled = false

        root_ToT.isExpanded = false
        header_ToT.enabled = false

        tagListModel.clear()

        for(var i = 0 ; i < model_FilterTopic.count ; i++) model_FilterTopic.setProperty(i,'isSelected',false)
        for(var j = 0 ; j < model_FilterTypeofQuestion.count ; j++) model_FilterTypeofQuestion.setProperty(j,'isSelected',false)
        for(var k = 0 ; k < model_FilterTypeofText.count ; k++) model_FilterTypeofText.setProperty(k,'isSelected',false)
        for(var l = 0 ; l < model_Books.count ; l++) model_Books.setProperty(l,'isSelected',false)

        qNumberFilterstate = "A"
        radioall.checked = true
        applyFilter()
    }

    signal passageTestState
    onPassageTestState: {
        root_Subject.isExpanded = true
        header_Subject.enabled = true

        root_ToQ.isExpanded = true
        header_ToQ.enabled = true

        root_ToT.isExpanded = true
        header_ToT.enabled = true

        for(var l = 0 ; l < model_Books.count ; l++) model_Books.setProperty(l,'isSelected',false)


        qNumberFilterstate = "A"
        radioall.checked = true
        if(tagListModel.count !== 0){
            tagListModel.clear()
        }else{
            applyFilter()
        }

    }

    //    property alias bookModel: model_Books

    //-- ListModel For Handling Tags --//
    ListModel{id: tagListModel}
    property var handleQuestion: []
    property var myQuestionDataJson: []


    Flickable{
        width: parent.width
        height: parent.height

        contentHeight: height

        //-- Sample Image (width and height for size usage) --//
        Image {
            id: imgBooks
            visible: false
            source: "qrc:/Content/Images/SelectTest_Image/book_8.png"
        }

        RowLayout{
            anchors.fill: parent
            spacing: 5 * ratio
            anchors.leftMargin: spacing

            //-- Left Filter Section --//
            Rectangle{
                Layout.fillHeight: true
                Layout.preferredWidth:(rootSelectTestPage.width > (1000 * ratio)) ? (250 * ratio) : parent.width * 0.25

                Layout.topMargin: 25 * ratio
                //              color: "#66ff0000"

                ColumnLayout{
                    id: col_filter

                    anchors.fill: parent
                    spacing: 5 * ratio

                    property int subject_height: col_filter.height * 0.3
                    property int quest_height: col_filter.height * 0.3
                    property int type_height: col_filter.height * 0.2
                    property int count_height: col_filter.height * 0.2

                    //-- Subject Filter --//
                    Rectangle{
                        id: root_Subject

                        //-- این دو انیمیشن برای عدم نمایش گزینه ها در نوار 5 پیکسلی پایین، در هنگام بسته بودن فیلتر است --//
                        PropertyAnimation {id: hideBodySubject; targets: [body_Subject]; properties: "opacity"; to: 0; duration: 500 }
                        PropertyAnimation {id: showBodySubject; targets: [body_Subject]; properties: "opacity"; to: 1; duration: 500 }

                        property bool isExpanded: true
                        onIsExpandedChanged: {
                            if(isExpanded){
                                showBodySubject.restart()
                            }
                            else{
                                hideBodySubject.restart()
                            }
                        }

                        Layout.fillWidth: true
                        //                        Layout.preferredHeight: isExpanded ? (((35 * ratio) * 5) + header_Subject.height) * ratio : 45 * ratio
                        Layout.preferredHeight: isExpanded ? (col_filter.subject_height) * ratio : 45 * ratio
                        Behavior on Layout.preferredHeight {NumberAnimation{duration: 200}}

                        radius: 10 * ratio

                        border.color: "#5d5d5d"
                        border.width: 1
                        clip: true

                        //-- header --//
                        Rectangle{
                            id: header_Subject
                            width: parent.width - (10 * ratio)
                            height: 35 * ratio

                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: parent.top
                            anchors.topMargin: 5 * ratio

                            color: "#444444"
                            radius: 5 * ratio

                            //-- Text --//
                            Label{
                                id:title_Subject
                                text: "موضوع"
                                anchors.centerIn: parent
                                font.family: iranSans.name
                                font.pixelSize: Qt.application.font.pixelSize * 0.9
                                color: "#ffffff"
                            }

                            //-- Icon --//
                            Label{
                                id: titleIcon_Subject
                                text: Icons.chevron_down
                                anchors.right: parent.right
                                anchors.rightMargin: 10 * ratio
                                anchors.verticalCenter: parent.verticalCenter

                                font.family: webfont.name
                                font.pixelSize: Qt.application.font.pixelSize * 2 * ratio

                                color: "#ffffff"



                                NumberAnimation {
                                    id: rotateArrowUP_Subject
                                    target: titleIcon_Subject
                                    property: "rotation"
                                    from: 0
                                    to: 180
                                    duration: 200
                                    easing.type: Easing.InOutQuad
                                }
                                NumberAnimation {
                                    id: rotateArrowDOWN_Subject
                                    target: titleIcon_Subject
                                    property: "rotation"
                                    from: 180
                                    to: 0
                                    duration: 200
                                    easing.type: Easing.InOutQuad
                                }

                            }

                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    root_Subject.isExpanded = !root_Subject.isExpanded
                                    if(root_Subject.isExpanded){
                                        rotateArrowDOWN_Subject.restart()
                                    }
                                    else{
                                        rotateArrowUP_Subject.restart()
                                    }
                                }
                            }
                        }

                        //-- body --//
                        Rectangle{
                            id: body_Subject

                            visible: true

                            width: parent.width - (10 * ratio)
                            height: root_Subject.isExpanded ? ((35 * ratio) * 5) : 0
                            anchors.top: header_Subject.bottom
                            anchors.topMargin: 5 * ratio
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 5 * ratio
                            anchors.horizontalCenter: parent.horizontalCenter
                            //                            color: "#e5e5e5"
                            //                            radius: 5 * ratio
                            clip: true

                            Behavior on height {NumberAnimation{duration: 200}}

                            ListView{
                                id: lst_SubjectFilterButtons

                                anchors.fill: parent
                                topMargin: 4 * ratio
                                bottomMargin: 4 * ratio
                                clip: true
                                spacing: 4 * ratio

                                boundsBehavior: Flickable.StopAtBounds

                                ScrollBar.vertical: ScrollBar {
                                    width: 10 * ratio
                                    policy: ScrollBar.AsNeeded
                                    parent: lst_SubjectFilterButtons.parent
                                    anchors.top: lst_SubjectFilterButtons.top
                                    anchors.left: lst_SubjectFilterButtons.left
                                    anchors.bottom: lst_SubjectFilterButtons.bottom
                                }

                                model: model_FilterTopic

                                delegate: FiltersButton{

                                    width: parent.width - (16 * ratio) // (LeftMargin + rightMargin) - Left and Right Border
                                    height: 35 * ratio
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    subjText: model.name

                                    btnColor: (isSelected) ? "#00b300" : "#ffffff"
                                    lblColor: (isSelected) ? "#ffffff" : "#444444"

                                    onClickSubjectFilter: {
                                        model_FilterTopic.setProperty(index, 'isSelected', !model_FilterTopic.get(index).isSelected)
                                        if(model_FilterTopic.get(index).isSelected){

                                            tagListModel.append(model_FilterTopic.get(index))
                                        }
                                        else{
                                            for(var i=0; i<tagListModel.count; i++ ){

                                                if(model_FilterTopic.get(index).name === tagListModel.get(i).name){
                                                    tagListModel.remove(i);
                                                    break;
                                                }
                                            }
                                        }

                                        //-- apply filter --//
                                        //applyFilter(); //run in countChanged of tagListModel
                                    }
                                }
                            }

                        }
                    }

                    //-- Type of Question Filter --//
                    Rectangle{
                        id: root_ToQ

                        //-- این دو انیمیشن برای عدم نمایش گزینه ها در نوار 5 پیکسلی پایین، در هنگام بسته بودن فیلتر است --//
                        PropertyAnimation {id: hideBodyToQ; targets: [body_ToQ]; properties: "opacity"; to: 0; duration: 500 }
                        PropertyAnimation {id: showBodyToQ; targets: [body_ToQ]; properties: "opacity"; to: 1; duration: 500 }

                        property bool isExpanded: true
                        onIsExpandedChanged: {
                            if(isExpanded){
                                showBodyToQ.restart()
                            }
                            else{
                                hideBodyToQ.restart()
                            }
                        }

                        Layout.fillWidth: true
                        //                        Layout.preferredHeight: isExpanded ? (((35 * ratio) * 5) + header_ToQ.height) * ratio : 45 * ratio
                        Layout.preferredHeight: isExpanded ? (col_filter.quest_height) * ratio : 45 * ratio
                        Behavior on Layout.preferredHeight {NumberAnimation{duration: 200}}

                        radius: 10 * ratio

                        border.color: "#5d5d5d"
                        border.width: 1
                        clip: true

                        //-- header --//
                        Rectangle{
                            id: header_ToQ

                            width: parent.width - (10 * ratio)
                            height: 35 * ratio

                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: parent.top
                            anchors.topMargin: 5 * ratio

                            color: "#444444"
                            radius: 5 * ratio

                            //-- Text --//
                            Label{
                                id:title_ToQ
                                text: "نوع سوال"
                                anchors.centerIn: parent
                                font.family: iranSans.name
                                font.pixelSize: Qt.application.font.pixelSize * 0.9
                                color: "#ffffff"
                            }

                            //-- Icon --//
                            Label{
                                id: titleIcon_ToQ
                                text: Icons.chevron_down
                                anchors.right: parent.right
                                anchors.rightMargin: 10 * ratio
                                anchors.verticalCenter: parent.verticalCenter

                                font.family: webfont.name
                                font.pixelSize: Qt.application.font.pixelSize * 2 * ratio

                                color: "#ffffff"



                                NumberAnimation {
                                    id: rotateArrowUP_ToQ
                                    target: titleIcon_ToQ
                                    property: "rotation"
                                    from: 0
                                    to: 180
                                    duration: 200
                                    easing.type: Easing.InOutQuad
                                }
                                NumberAnimation {
                                    id: rotateArrowDOWN_ToQ
                                    target: titleIcon_ToQ
                                    property: "rotation"
                                    from: 180
                                    to: 0
                                    duration: 200
                                    easing.type: Easing.InOutQuad
                                }

                            }

                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    root_ToQ.isExpanded = !root_ToQ.isExpanded
                                    if(root_ToQ.isExpanded){
                                        rotateArrowDOWN_ToQ.restart()
                                    }
                                    else{
                                        rotateArrowUP_ToQ.restart()
                                    }
                                }
                            }
                        }

                        //-- body --//
                        Rectangle{
                            id: body_ToQ

                            visible: true

                            width: parent.width - (10 * ratio)
                            height: root_ToQ.isExpanded ? ((35 * ratio) * 5) : 0
                            anchors.top: header_ToQ.bottom
                            anchors.topMargin: 5 * ratio
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 5 * ratio
                            anchors.horizontalCenter: parent.horizontalCenter
                            //                            color: "#e5e5e5"
                            //                            radius: 5 * ratio
                            clip: true

                            Behavior on height {NumberAnimation{duration: 200}}

                            ListView{
                                id: lst_ToQFilterButtons

                                anchors.fill: parent
                                topMargin: 4 * ratio
                                bottomMargin: 4 * ratio
                                clip: true
                                spacing: 4 * ratio

                                boundsBehavior: Flickable.StopAtBounds

                                ScrollBar.vertical: ScrollBar {
                                    width: 10 * ratio
                                    policy: ScrollBar.AsNeeded
                                    parent: lst_ToQFilterButtons.parent
                                    anchors.top: lst_ToQFilterButtons.top
                                    anchors.left: lst_ToQFilterButtons.left
                                    anchors.bottom: lst_ToQFilterButtons.bottom
                                }

                                model: model_FilterTypeofQuestion

                                delegate: FiltersButton{

                                    width: parent.width - (16 * ratio) // (LeftMargin + rightMargin) - Left and Right Border
                                    height: 35 * ratio
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    subjText: model.name

                                    btnColor: (isSelected) ? "#00b300" : "#ffffff"
                                    lblColor: (isSelected) ? "#ffffff" : "#444444"

                                    onClickSubjectFilter: {
                                        model_FilterTypeofQuestion.setProperty(index, 'isSelected', !model_FilterTypeofQuestion.get(index).isSelected)
                                        if(model_FilterTypeofQuestion.get(index).isSelected){

                                            tagListModel.append(model_FilterTypeofQuestion.get(index))
                                        }
                                        else{
                                            for(var i=0; i<tagListModel.count; i++ ){

                                                if(model_FilterTypeofQuestion.get(index).name === tagListModel.get(i).name){
                                                    tagListModel.remove(i);
                                                    break;
                                                }
                                            }
                                        }

                                        //-- apply filter --//
                                        //applyFilter();  run in countChanged of tagListModel
                                    }
                                }
                            }

                        }
                    }

                    //-- Type of Text Filter --//
                    Rectangle{
                        id: root_ToT

                        //-- این دو انیمیشن برای عدم نمایش گزینه ها در نوار 5 پیکسلی پایین، در هنگام بسته بودن فیلتر است --//
                        PropertyAnimation {id: hideBodyToT; targets: [body_ToT]; properties: "opacity"; to: 0; duration: 500 }
                        PropertyAnimation {id: showBodyToT; targets: [body_ToT]; properties: "opacity"; to: 1; duration: 500 }

                        property bool isExpanded: true
                        onIsExpandedChanged: {
                            if(isExpanded){
                                showBodyToT.restart()
                            }
                            else{
                                hideBodyToT.restart()
                            }
                        }

                        Layout.fillWidth: true
                        Layout.preferredHeight: isExpanded ? (((35 * ratio) * 4.5) + header_ToT.height) * ratio : 45 * ratio
                        //                        Layout.preferredHeight: isExpanded ? (col_filter.type_height) * ratio : 45 * ratio
                        Behavior on Layout.preferredHeight {NumberAnimation{duration: 200}}

                        radius: 10 * ratio

                        border.color: "#5d5d5d"
                        border.width: 1
                        clip: true

                        //-- header --//
                        Rectangle{
                            id: header_ToT

                            width: parent.width - (10 * ratio)
                            height: 35 * ratio

                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: parent.top
                            anchors.topMargin: 5 * ratio

                            color: "#444444"
                            radius: 5 * ratio

                            //-- Text --//
                            Label{
                                id:title_ToT
                                text: "نوع متن"
                                anchors.centerIn: parent
                                font.family: iranSans.name
                                font.pixelSize: Qt.application.font.pixelSize * 0.9
                                color: "#ffffff"
                            }

                            //-- Icon --//
                            Label{
                                id: titleIcon_ToT
                                text: Icons.chevron_down
                                anchors.right: parent.right
                                anchors.rightMargin: 10 * ratio
                                anchors.verticalCenter: parent.verticalCenter
                                color: "#ffffff"

                                font.family: webfont.name
                                font.pixelSize: Qt.application.font.pixelSize * 2 * ratio



                                NumberAnimation {
                                    id: rotateArrowUP_ToT
                                    target: titleIcon_ToT
                                    property: "rotation"
                                    from: 0
                                    to: 180
                                    duration: 200
                                    easing.type: Easing.InOutQuad
                                }
                                NumberAnimation {
                                    id: rotateArrowDOWN_ToT
                                    target: titleIcon_ToT
                                    property: "rotation"
                                    from: 180
                                    to: 0
                                    duration: 200
                                    easing.type: Easing.InOutQuad
                                }

                            }

                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    root_ToT.isExpanded = !root_ToT.isExpanded
                                    if(root_ToT.isExpanded){
                                        rotateArrowDOWN_ToT.restart()
                                    }
                                    else{
                                        rotateArrowUP_ToT.restart()
                                    }
                                }
                            }
                        }

                        //-- body --//
                        Rectangle{
                            id: body_ToT

                            visible: true

                            width: parent.width - (10 * ratio)
                            height: root_ToT.isExpanded ? ((35 * ratio) * 5) : 0
                            anchors.top: header_ToT.bottom
                            anchors.topMargin: 5 * ratio
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 5 * ratio
                            anchors.horizontalCenter: parent.horizontalCenter
                            //                            color: "#e5e5e5"
                            //                            radius: 5 * ratio
                            clip: true

                            Behavior on height {NumberAnimation{duration: 200}}

                            ListView{
                                id: lst_ToTFilterButtons

                                anchors.fill: parent
                                topMargin: 4 * ratio
                                bottomMargin: 4 * ratio
                                clip: true
                                spacing: 4 * ratio

                                boundsBehavior: Flickable.StopAtBounds

                                ScrollBar.vertical: ScrollBar {
                                    width: 10 * ratio
                                    policy: ScrollBar.AsNeeded
                                    parent: lst_ToTFilterButtons.parent
                                    anchors.top: lst_ToTFilterButtons.top
                                    anchors.left: lst_ToTFilterButtons.left
                                    anchors.bottom: lst_ToTFilterButtons.bottom
                                }

                                model: model_FilterTypeofText

                                delegate: FiltersButton{

                                    width: parent.width - (16 * ratio) // (LeftMargin + rightMargin) - Left and Right Border
                                    height: 35 * ratio
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    subjText: model.name

                                    btnColor: (model.isSelected) ? "#00b300" : "#ffffff"
                                    lblColor: (model.isSelected) ? "#ffffff" : "#444444"

                                    onClickSubjectFilter: {
                                        model_FilterTypeofText.setProperty(index, 'isSelected', !model_FilterTypeofText.get(index).isSelected)
                                        if(model_FilterTypeofText.get(index).isSelected){

                                            tagListModel.append(model_FilterTypeofText.get(index))
                                        }
                                        else{
                                            for(var i=0; i<tagListModel.count; i++ ){

                                                if(model_FilterTypeofText.get(index).name === tagListModel.get(i).name){
                                                    tagListModel.remove(i);
                                                    break;
                                                }
                                            }
                                        }

                                        //-- apply filter --// run in countChanged of tagListModel
                                        //applyFilter();
                                    }
                                }
                            }

                        }
                    }

                    //-- Question Count Filter --//
                    Rectangle{
                        id: root_QC

                        //-- این دو انیمیشن برای عدم نمایش گزینه ها در نوار 5 پیکسلی پایین، در هنگام بسته بودن فیلتر است --//
                        PropertyAnimation {id: hideBodyQC; targets: [body_QC]; properties: "opacity"; to: 0; duration: 500 }
                        PropertyAnimation {id: showBodyQC; targets: [body_QC]; properties: "opacity"; to: 1; duration: 500 }

                        property bool isExpanded: true
                        onIsExpandedChanged: {
                            if(isExpanded){
                                showBodyQC.restart()
                            }
                            else{
                                hideBodyQC.restart()
                            }
                        }

                        Layout.fillWidth: true
                        Layout.preferredHeight: isExpanded ? (((35 * ratio) * 4.5) + header_QC.height) * ratio : 45 * ratio
                        //                        Layout.preferredHeight: isExpanded ? (col_filter.type_height) * ratio : 45 * ratio
                        Behavior on Layout.preferredHeight {NumberAnimation{duration: 200}}

                        radius: 10 * ratio

                        border.color: "#5d5d5d"
                        border.width: 1
                        clip: true

                        //-- header --//
                        Rectangle{
                            id: header_QC

                            width: parent.width - (10 * ratio)
                            height: 35 * ratio

                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: parent.top
                            anchors.topMargin: 5 * ratio

                            color: "#444444"
                            radius: 5 * ratio

                            //-- Text --//
                            Label{
                                id:title_QC
                                text: "تعداد سوال"
                                anchors.centerIn: parent
                                font.family: iranSans.name
                                font.pixelSize: Qt.application.font.pixelSize * 0.9
                                color: "#ffffff"
                            }

                            //-- Icon --//
                            Label{
                                id: titleIcon_QC
                                text: Icons.chevron_down
                                anchors.right: parent.right
                                anchors.rightMargin: 10 * ratio
                                anchors.verticalCenter: parent.verticalCenter
                                color: "#ffffff"

                                font.family: webfont.name
                                font.pixelSize: Qt.application.font.pixelSize * 2 * ratio



                                NumberAnimation {
                                    id: rotateArrowUP_QC
                                    target: titleIcon_QC
                                    property: "rotation"
                                    from: 0
                                    to: 180
                                    duration: 200
                                    easing.type: Easing.InOutQuad
                                }
                                NumberAnimation {
                                    id: rotateArrowDOWN_QC
                                    target: titleIcon_QC
                                    property: "rotation"
                                    from: 180
                                    to: 0
                                    duration: 200
                                    easing.type: Easing.InOutQuad
                                }

                            }

                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    root_QC.isExpanded = !root_QC.isExpanded
                                    if(root_QC.isExpanded){
                                        rotateArrowDOWN_QC.restart()
                                    }
                                    else{
                                        rotateArrowUP_QC.restart()
                                    }
                                }
                            }
                        }

                        //-- body --//
                        Rectangle{
                            id: body_QC

                            visible: true

                            width: parent.width - (10 * ratio)
                            height: root_QC.isExpanded ? ((35 * ratio) * 5) : 0
                            anchors.top: header_QC.bottom
                            anchors.topMargin: 5 * ratio
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 5 * ratio
                            anchors.horizontalCenter: parent.horizontalCenter
                            //                            color: "#e5e5e5"
                            //                            radius: 5 * ratio
                            clip: true

                            Behavior on height {NumberAnimation{duration: 200}}

                            Flickable{
                                id: flick_QC

                                anchors.fill: parent

                                contentHeight: flw_Count.implicitHeight


                                boundsBehavior: Flickable.StopAtBounds

                                ScrollBar.vertical: ScrollBar {
                                    width: 10 * ratio
                                    policy: ScrollBar.AsNeeded
                                    parent: flick_QC.parent
                                    anchors.top: flick_QC.top
                                    anchors.left: flick_QC.left
                                    anchors.bottom: flick_QC.bottom
                                }


                                Flow {
                                    id: flw_Count
                                    anchors.fill: parent

                                    leftPadding: 10
                                    rightPadding: 10

                                    RadioButton {
                                        id: radioall
                                        width: (parent.width / 2) -10
                                        height: implicitHeight
                                        text: "All"
                                        checked: true
                                        onCheckedChanged: {
                                            if (checked){
                                                qNumberFilterstate = "A"
                                                applyFilter()
                                            }
                                        }
                                    }
                                    RadioButton {
                                        width: (parent.width / 2) -10
                                        height: implicitHeight
                                        text: "≤5"
                                        onCheckedChanged: {
                                            if (checked){
                                                qNumberFilterstate = "B"
                                                applyFilter()
                                            }
                                        }
                                    }
                                    RadioButton {
                                        width: (parent.width / 2) -10
                                        height: implicitHeight
                                        text: "6-9"
                                        onCheckedChanged: {
                                            if (checked){
                                                qNumberFilterstate = "C"
                                                applyFilter()
                                            }
                                        }
                                    }
                                    RadioButton {
                                        width: (parent.width / 2) -10
                                        height: implicitHeight
                                        text: "10+"
                                        onCheckedChanged: {
                                            if (checked){
                                                qNumberFilterstate = "D"
                                                applyFilter()
                                            }
                                        }
                                    }

                                }

                            }

                        }
                    }

                    //-- apply filter --//
                    Button{
                        id: btn_Filter
                        visible: false
                        Layout.preferredWidth: parent.width * 0.8
                        Layout.preferredHeight: 40
                        Layout.alignment: Qt.AlignHCenter

                        text: "اعمال فیلتر"

                        onClicked: {
                            applyFilter()
                        }
                    }

                    Item {  Layout.fillHeight: true } //-- filler --//
                }

            }

            //-- Right Section (All Parts Without Filter Section) --//
            Rectangle{
                Layout.fillHeight: true
                Layout.fillWidth: true

                Layout.topMargin: 25 * ratio
                Layout.rightMargin: 10 * ratio

                ColumnLayout{
                    anchors.fill: parent
                    spacing: 5 * ratio

                    //-- Cambridge Books Filter Section --//
                    Rectangle{
                        Layout.fillWidth: true
                        Layout.preferredHeight: 175
                        Layout.topMargin: 23

                        border.width: 1
                        border.color: "#000000"

                        radius: 10 * ratio

                        //-- Cambridge Books List --//
                        ListView{
                            id: lv_CambridgeBooks

                            width: parent.width
                            height: parent.height - 25
                            anchors.bottom: parent.bottom
                            anchors.left: parent.left
                            anchors.leftMargin: 2
                            anchors.right: parent.right
                            anchors.rightMargin: 57 // 60 is (width + rightMargin) of rect
                            clip: true

                            leftMargin: (width > ((imgBooks.sourceSize.width * 0.35 * model_Books.count) + ((model_Books.count - 1) * spacing ) + (head_bookFilter.width)))
                                        ? ((width - ((imgBooks.sourceSize.width * 0.35 * model_Books.count) + ((model_Books.count - 1) * spacing ))) / 2) - (head_bookFilter.width / 2) + 10
                                        : 10
                            rightMargin: 10


                            onWidthChanged: {
                                log("leftMargin : " + leftMargin)
                            }

                            spacing: 20

                            snapMode: ListView.SnapToItem

                            flickableDirection: Flickable.HorizontalFlick
                            //                            boundsBehavior: Flickable.StopAtBounds
                            Behavior on contentX{ NumberAnimation{duration: 500}}

                            orientation: ListView.Horizontal

                            model: model_Books

                            delegate: Rectangle{

                                width: imgBooks.sourceSize.width * 0.35
                                height: (null) ? 0 : parent.height * 0.8
                                color: "#00FF0000"

                                anchors.verticalCenter: parent.verticalCenter

                                //-- Shadow of loaded_Images --//
                                DropShadow {
                                    anchors.fill: loaded_Images
                                    transparentBorder: true
                                    horizontalOffset: 3
                                    verticalOffset: 3
                                    spread: 0.2
                                    radius: 6.0
                                    samples: 14
                                    color: "#40000000"
                                    source: loaded_Images
                                }

                                //-- Images of Books --//
                                Image {

                                    id: loaded_Images
                                    source: model.image
                                    width: parent.width
                                    height: parent.height
                                    //                                    anchors.centerIn: parent
                                    fillMode: Image.PreserveAspectFit


                                    //-- Check mark in center of CambridgeBook --//
                                    Label{
                                        id: lbl_CheckIcon
                                        visible: model.isSelected

                                        width: parent.width
                                        height: parent.height - 6

                                        verticalAlignment: Qt.AlignVCenter
                                        horizontalAlignment: Qt.AlignHCenter

                                        text: Icons.check_circle_outline
                                        font.family: webfont.name
                                        font.pixelSize: Qt.application.font.pixelSize * 2.2

                                        color: "#00ff00"

                                        anchors.right: parent.right
                                        anchors.rightMargin: (parent.width - parent.paintedWidth) / 2
                                        anchors.bottom: parent.bottom
                                        anchors.bottomMargin: (parent.height - parent.paintedHeight) / 2

                                        background: Rectangle{
                                            color: "#88444444"
                                        }
                                    }


                                    //-- on Click Each Book --//
                                    ItemDelegate{
                                        width: parent.paintedWidth
                                        height: parent.paintedHeight
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        anchors.verticalCenter: parent.verticalCenter
                                        onClicked: {
                                            model_Books.setProperty(index, 'isSelected', !model_Books.get(index).isSelected)
                                            if(model_Books.get(index).isSelected){

                                                tagListModel.append(model_Books.get(index))

                                            }
                                            else{
                                                for(var i=0; i<tagListModel.count; i++ ){

                                                    if(model_Books.get(index).name === tagListModel.get(i).name){
                                                        tagListModel.remove(i);
                                                        break;
                                                    }
                                                }
                                            }

                                            //-- apply filter --//
                                            //applyFilter(); // run in countChanged of tagListModel
                                        }
                                    }


                                }
                            }

                        }

                        //-- Left Arrow --//
                        Rectangle{
                            width: 30
                            height: 50

                            visible: lv_CambridgeBooks.leftMargin <= 10 ? true : false

                            anchors.verticalCenter: parent.verticalCenter

                            color: "#00ff0000"

                            Label{
                                font.family: font_material.name
                                font.pixelSize: Qt.application.font.pixelSize * 3
                                text: Icons.chevron_left
                                anchors.centerIn: parent
                                color: "#9a9a9a"
                            }

                            ItemDelegate{
                                anchors.fill: parent
                                onClicked: {


                                    //                                    lv_CambridgeBooks.flick(imgBooks.sourceSize.width * 0.35 , 0)
                                    var newCurrentX = lv_CambridgeBooks.contentX
                                            - imgBooks.sourceSize.width * 0.35
                                            - lv_CambridgeBooks.spacing;
                                    console.log(newCurrentX, lv_CambridgeBooks.contentX)
                                    if(newCurrentX >=  0){

                                        lv_CambridgeBooks.contentX = newCurrentX
                                    }
                                    else{
                                        lv_CambridgeBooks.contentX = -10;
                                    }

                                }
                            }
                        }

                        //-- Right Arrow --//
                        Rectangle{
                            width: 30
                            height: 50

                            visible : lv_CambridgeBooks.leftMargin <= 10 ? true : false

                            color: "#00ff0000"

                            Label{
                                font.family: font_material.name
                                font.pixelSize: Qt.application.font.pixelSize * 3
                                text: Icons.chevron_right
                                anchors.centerIn: parent
                                color: "#9a9a9a"
                            }

                            anchors.right: parent.right
                            anchors.rightMargin: head_bookFilter.width + (5 * ratio)
                            anchors.verticalCenter: parent.verticalCenter

                            ItemDelegate{
                                id: rightArrow
                                anchors.fill: parent
                                onClicked: {
                                    //                                    lv_CambridgeBooks.flick(-imgBooks.sourceSize.width * 0.35 , 0)

                                    var newCurrentX = lv_CambridgeBooks.contentX
                                            + imgBooks.sourceSize.width * 0.35
                                            + lv_CambridgeBooks.spacing;
                                    if(newCurrentX + lv_CambridgeBooks.width <= lv_CambridgeBooks.contentWidth){

                                        lv_CambridgeBooks.contentX = newCurrentX
                                    }
                                    else{
                                        lv_CambridgeBooks.contentX = lv_CambridgeBooks.contentWidth - lv_CambridgeBooks.width
                                    }
                                }
                            }
                        }

                        //-- FullTest or PassageTest Button --//
                        Rectangle{
                            width: 250
                            height: 46
                            radius: 10
                            color: "#dddddd"
                            anchors.top: parent.top
                            anchors.topMargin: -23
                            anchors.horizontalCenter: parent.horizontalCenter

                            //-- (Left) Full Test --//
                            Rectangle{
                                id: btn_FullTest

                                property bool isSelected: false

                                width: (parent.width / 2)
                                height: parent.height
                                radius: 10
                                anchors.left: parent.left

                                color: (btn_FullTest.isSelected) ? Util.color_DarkBlue : "#dddddd"

                                Rectangle{
                                    width: parent.radius
                                    height: parent.height
                                    anchors.right: parent.right
                                    color: parent.color
                                }


                                Label{
                                    width: parent.width - 50
                                    height: parent.height
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    text: "Full Test"
                                    color: (btn_FullTest.isSelected) ? "#ffffff" : "#bbbbbb"

                                    verticalAlignment: Qt.AlignVCenter
                                    horizontalAlignment: Qt.AlignHCenter

                                    font.pixelSize: Qt.application.font.pixelSize * 1.9
                                    font.family: iranSans.name
                                    minimumPixelSize: 1
                                    fontSizeMode: Text.Fit
                                }

                                MouseArea{
                                    anchors.fill: parent
                                    cursorShape: Qt.PointingHandCursor
                                    onClicked: {
                                        if(btn_FullTest.isSelected === false){
                                            btn_FullTest.isSelected = true
                                            btn_Passages.isSelected = false
                                            rootSelectTestPage.fullTestState()
                                        }
                                    }
                                }

                            }

                            //-- (Right) Passages --//
                            Rectangle{
                                id: btn_Passages

                                property bool isSelected: true

                                width: (parent.width / 2)
                                height: parent.height
                                radius: 10
                                anchors.right: parent.right

                                color: (btn_Passages.isSelected) ? Util.color_DarkBlue : "#dddddd"

                                Rectangle{
                                    width: parent.radius
                                    height: parent.height
                                    anchors.left: parent.left
                                    color: parent.color
                                }

                                Label{
                                    width: parent.width - 50
                                    height: parent.height
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    text: "Passages"
                                    color: (btn_Passages.isSelected) ? "#ffffff" : "#bbbbbb"
                                    verticalAlignment: Qt.AlignVCenter
                                    horizontalAlignment: Qt.AlignHCenter

                                    font.pixelSize: Qt.application.font.pixelSize * 1.9
                                    font.family: iranSans.name
                                    minimumPixelSize: 1
                                    fontSizeMode: Text.Fit
                                }

                                MouseArea{
                                    anchors.fill: parent
                                    cursorShape: Qt.PointingHandCursor
                                    onClicked: {
                                        if(btn_Passages.isSelected === false){
                                            btn_Passages.isSelected = true
                                            btn_FullTest.isSelected = false
                                            rootSelectTestPage.passageTestState()
                                        }
                                    }
                                }

                            }
                        }

                        //-- Right Label (Rect in right) "جلد های کمبریج" --//
                        Rectangle{
                            id: head_bookFilter
                            width: 50 * ratio
                            height: parent.height - (10 * ratio)

                            anchors.right: parent.right
                            anchors.rightMargin: 5 * ratio
                            anchors.verticalCenter: parent.verticalCenter

                            color: "#034ea2"
                            radius: 5 * ratio

                            Label{
                                width: parent.height - (30 * ratio)
                                height: parent.width
                                anchors.centerIn: parent

                                text: "جلدهای کمبریج"
                                font.pixelSize: Qt.application.font.pixelSize * 1.9
                                font.family: iranSans.name

                                minimumPixelSize: 1
                                fontSizeMode: Text.Fit
                                rotation: 90
                                color: "#ffffff"

                                verticalAlignment: Qt.AlignVCenter
                                horizontalAlignment: Qt.AlignHCenter

                            }


                        }


                    }

                    //-- Tags Section --//
                    Rectangle{
                        Layout.fillWidth: true
                        Layout.preferredHeight: {
                            //((lst_TagsFilter.implicitHeight + 10) < 150) ? lst_TagsFilter.implicitHeight + 10 : 150
                            if(tagListModel.count <= 0){
                                return 45;  // 35 + 10
                            }

                            if((lst_TagsFilter.implicitHeight + 10) < 150){
                                return (lst_TagsFilter.implicitHeight + 10);
                            }
                            else{
                                return 150;
                            }
                        }

                        color: "transparent"
                        border.color: "#000000"
                        border.width: 1
                        radius: 10 * ratio

                        //-- When Tag List is Empty --//
                        Label{
                            id: lbl_AddFilter
                            visible: (tagListModel.count <= 0) ? true : false
                            text: "You can add filters"
                            color: "#88aaaaaa"
                            font.family: iranSans.name
                            font.pixelSize: Qt.application.font.pixelSize * 1.5
                            font.bold: true
                            anchors.centerIn: parent
                        }
                        //-- When Tag List is Empty --//
                        Label{
                            id: lbl_AddFilterIcon
                            visible: (tagListModel.count <= 0) ? true : false
                            text: Icons.filter_plus_outline
                            color: "#88aaaaaa"
                            font.family: webfont.name
                            font.pixelSize: Qt.application.font.pixelSize * 2
                            anchors.right: lbl_AddFilter.left
                            anchors.rightMargin: 5 * ratio
                            //                            anchors.verticalCenter: parent.verticalCenter
                            y: lbl_AddFilter.y - 4 * ratio
                        }

                        Flickable{
                            id: flick_Tag
                            anchors.fill: parent

                            onContentHeightChanged: {
                                flick_Tag.contentY = flick_Tag.contentHeight - flick_Tag.height
                            }

                            contentHeight: lst_TagsFilter.implicitHeight
                            anchors.margins: 5 * ratio
                            boundsBehavior: Flickable.StopAtBounds
                            clip: true

                            //-- Tags ListView --//
                            Flow{
                                id: lst_TagsFilter
                                anchors.fill: parent

                                layoutDirection: Qt.RightToLeft
                                spacing: 10 * ratio
                                clip: true
                                anchors.rightMargin: 2
                                anchors.leftMargin: 27

                                Repeater{
                                    model: tagListModel

                                    onCountChanged: {
                                        applyFilter()
                                    }

                                    TagButton{

                                        width: btnSize.width
                                        height: btnSize.height

                                        tagText: model.name
                                        btnColor: {
                                            if(model.type === "subject"){
                                                return "#96cdf9"
                                            }
                                            else if(model.type === "question"){
                                                return "#85cdc6"
                                            }
                                            else if(model.category === "type"){
                                                return "#93f5ed"
                                            }
                                            else if(model.category === "Book"){
                                                return "#addaae"
                                            }
                                        }

                                        lblColor: "#5d5d5d"

                                        onClickTag: {
                                            console.log("BEFORE : " , index , tagListModel.count)


                                            if(tagListModel.get(index).type === "subject"){
                                                for(var i=0; i<model_FilterTopic.count; i++ ){

                                                    if(model_FilterTopic.get(i).name === tagListModel.get(index).name){
                                                        model_FilterTopic.setProperty(i, 'isSelected', false)
                                                        tagListModel.remove(index)
                                                        break;
                                                    }
                                                }
                                            }
                                            else if(tagListModel.get(index).type === "question"){
                                                for(var j=0; j<model_FilterTypeofQuestion.count; j++ ){

                                                    if(model_FilterTypeofQuestion.get(j).name === tagListModel.get(index).name){
                                                        model_FilterTypeofQuestion.setProperty(j, 'isSelected', false)
                                                        tagListModel.remove(index)
                                                        break;
                                                    }
                                                }
                                            }
                                            else if(tagListModel.get(index).type === "type"){
                                                for(var k=0; k<model_FilterTypeofText.count; k++ ){

                                                    if(model_FilterTypeofText.get(k).name === tagListModel.get(index).name){
                                                        model_FilterTypeofText.setProperty(k, 'isSelected', false)
                                                        tagListModel.remove(index)
                                                        break;
                                                    }
                                                }
                                            }
                                            else if(tagListModel.get(index).type === "Book"){
                                                for(var l=0; l<model_Books.count; l++ ){
                                                    if(model_Books.get(l).name === tagListModel.get(index).name){

                                                        model_Books.setProperty(l, 'isSelected', false)
                                                        tagListModel.remove(index)
                                                        break;
                                                    }
                                                }
                                            }



                                            //-- apply filter --//

                                            //rootSelectTestPage.applyFilter();
                                        }


                                    }
                                }

                            }
                        }
                    }

                    //-- Results Section --//
                    Rectangle{
                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        Flickable{
                            id: flick_Result
                            anchors.fill: parent
                            contentHeight: (btn_FullTest.isSelected) ? myFlowFullTest.height : myFlowPassage.height
                            clip: true

                            //anchors.margins: 10

                            ScrollBar.vertical: ScrollBar {
                                width: 10 * ratio
                                policy: ScrollBar.AlwaysOn
                                parent: flick_Result.parent
                                anchors.top: flick_Result.top
                                anchors.right: flick_Result.right
                                anchors.bottom: flick_Result.bottom
                            }

                            //-- FullTest Result --//
                            Flow {
                                id: myFlowFullTest

                                visible: btn_FullTest.isSelected

                                width: (flick_Result.width % 320 === 0) ? (320 * ((flick_Result.width / 320)) + ((Math.floor(flick_Result.width / 320) - 1) * spacing))
                                                                        : ((320 * Math.floor(flick_Result.width / 320)) + ((Math.floor(flick_Result.width / 320) - 1) * spacing))
                                height: implicitHeight
                                spacing: 10

                                anchors.horizontalCenter: parent.horizontalCenter

                                Repeater {
                                    model: model_LoadTexts


                                    Rectangle{

                                        width: 315
                                        height: 285
                                        color: "#ffffff"
                                        clip: true

                                        DropShadow {
                                            anchors.fill: _practice
                                            horizontalOffset: 0
                                            verticalOffset: 0
                                            radius: 6.0
                                            samples: 17
                                            color: "#b0000000"
                                            source: _practice
                                        }

                                        PracticeTest{
                                            id:_practice

                                            anchors.centerIn: parent

                                            headerTitle: "Practice Test" + (index +1)

                                            onR_TakeTest_Clicked: {

                                                console.log("ID is : " , model.id)
                                                var d  = Service.get_all(Service.url_fullTest + model.id , function(data){
                                                    //                                                    print("DFf ", data.passages)

                                                    //                                                    root._FullTestQuestions.clear()
                                                    root._FullTestQuestions_1.clear()
                                                    root._FullTestQuestions_2.clear()
                                                    root._FullTestQuestions_3.clear()
                                                    for (var k=0; k < data.passages.length; k++){
                                                        var firstData = JSON.stringify(data.passages[k])

                                                        var indx = firstData.indexOf('\\n')
                                                        while(indx !== -1){
                                                            firstData = firstData.replace('\\n' , "")   //\n
                                                            indx = firstData.indexOf('\\n')
                                                        }

                                                        var indx1 = firstData.indexOf('\\r')
                                                        while(indx1 !== -1){
                                                            firstData = firstData.replace('\\r' , "")  // \r
                                                            indx1 = firstData.indexOf('\\r')
                                                        }

                                                        var indx2 = firstData.indexOf('null')
                                                        while(indx2 !== -1){
                                                            firstData = firstData.replace('null' , "0")
                                                            indx2 = firstData.indexOf('null')
                                                        }

                                                        var firstDataJSON = JSON.parse(firstData)

                                                        //console.log("PARSE = " + firstDataJSON.question_description[0].questions[0] + " AND " + firstDataJSON.question_description[0].type.name)

                                                        handleQuestion = []
                                                        for(var i = 0 ; i < firstDataJSON.question_description.length ; i++){
                                                            handleQuestion.push(firstDataJSON.question_description[i])
                                                        }


                                                        //handleQuestion.setProperty(i, 'answer', JSON.stringify(firstDataJSON.questions[i].answers)) // use this for add another things


                                                        //console.log("MY DATA : " ,JSON.parse(JSON.stringify(handleQuestion)))
                                                        myQuestionDataJson = JSON.parse(JSON.stringify(handleQuestion))
                                                        for(var j = 0 ; j < myQuestionDataJson[0].questions.length ; j++){
                                                            //console.log("COUNTER OF Q : " + (j+1))
                                                            myQuestionDataJson[0].questions[j].text = myQuestionDataJson[0].questions[j].text.replace('<p>' , '<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;')
                                                            //console.log("Q " + (j+1) + " : " + myQuestionDataJson[0].questions[j].text)
                                                        }

                                                        if (k===0){
                                                            root._FullTestQuestions_1.append(myQuestionDataJson)

                                                            root._FullText_1 = firstDataJSON.text  // text of Question

                                                            //console.log("LAST LINE : " + root._FullTestQuestions.get(0).text)
                                                            //--  چون ممکن است که اصلا تگ "<پی>" وجود نداشته باشد این شرط برقرار شده است و غیره --//
                                                            if(root._FullText_1.indexOf("<p>") !== -1){
                                                                root._FullText_1 = root._FullText_1.replace('<p>' , '<br><p><font size="6">'+firstDataJSON.title+'</font></p><br><p>')
                                                                root._FullText_1 = root._FullText_1.replace('</p>' , '</p><br><img src='+firstDataJSON.image+'><br>')
                                                            }
                                                            else if(root._FullText_1.indexOf("<ol") !== -1){
                                                                var temp = root._FullText_1.substring(root._FullText_1.indexOf("<ol") , root._FullText_1.indexOf(">")+1)
                                                                //console.log("TEMP = " , temp)
                                                                root._FullText_1 = root._FullText_1.replace(temp , '<br><p><font size="6">'+firstDataJSON.title+'</font></p><br>'+temp)
                                                                root._FullText_1 = root._FullText_1.replace('</p>' , '</p><br><img src='+firstDataJSON.image+'><br>')
                                                            }
                                                            else {
                                                                root._FullText_1 = "PROBLEM IN TEXT FORMAT : PLEASE CALL TO MAIN ADMIN"
                                                            }
                                                        }else if (k===1){
                                                            root._FullTestQuestions_2.append(myQuestionDataJson)
                                                            root._FullText_2 = firstDataJSON.text  // text of Question

                                                            //console.log("LAST LINE : " + root._FullTestQuestions.get(0).text)
                                                            //--  چون ممکن است که اصلا تگ "<پی>" وجود نداشته باشد این شرط برقرار شده است و غیره --//
                                                            if(root._FullText_2.indexOf("<p>") !== -1){
                                                                root._FullText_2 = root._FullText_2.replace('<p>' , '<br><p><font size="6">'+firstDataJSON.title+'</font></p><br><p>')
                                                                root._FullText_2 = root._FullText_2.replace('</p>' , '</p><br><img src='+firstDataJSON.image+'><br>')
                                                            }
                                                            else if(root._FullText_2.indexOf("<ol") !== -1){
                                                                var temp = root._FullText_2.substring(root._FullText_2.indexOf("<ol") , root._FullText_2.indexOf(">")+1)
                                                                //console.log("TEMP = " , temp)
                                                                root._FullText_2 = root._FullText_2.replace(temp , '<br><p><font size="6">'+firstDataJSON.title+'</font></p><br>'+temp)
                                                                root._FullText_2 = root._FullText_2.replace('</p>' , '</p><br><img src='+firstDataJSON.image+'><br>')
                                                            }
                                                            else {
                                                                root._FullText_2 = "PROBLEM IN TEXT FORMAT : PLEASE CALL TO MAIN ADMIN"
                                                            }
                                                        }else{
                                                            root._FullTestQuestions_3.append(myQuestionDataJson)
                                                            root._FullText_3 = firstDataJSON.text  // text of Question

                                                            //console.log("LAST LINE : " + root._FullTestQuestions.get(0).text)
                                                            //--  چون ممکن است که اصلا تگ "<پی>" وجود نداشته باشد این شرط برقرار شده است و غیره --//
                                                            if(root._FullText_3.indexOf("<p>") !== -1){
                                                                root._FullText_3 = root._FullText_3.replace('<p>' , '<br><p><font size="6">'+firstDataJSON.title+'</font></p><br><p>')
                                                                root._FullText_3 = root._FullText_3.replace('</p>' , '</p><br><img src='+firstDataJSON.image+'><br>')
                                                            }
                                                            else if(root._FullText_3.indexOf("<ol") !== -1){
                                                                var temp = root._FullText_3.substring(root._FullText_3.indexOf("<ol") , root._FullText_3.indexOf(">")+1)
                                                                //console.log("TEMP = " , temp)
                                                                root._FullText_3 = root._FullText_3.replace(temp , '<br><p><font size="6">'+firstDataJSON.title+'</font></p><br>'+temp)
                                                                root._FullText_3 = root._FullText_3.replace('</p>' , '</p><br><img src='+firstDataJSON.image+'><br>')
                                                            }
                                                            else {
                                                                root._FullText_3 = "PROBLEM IN TEXT FORMAT : PLEASE CALL TO MAIN ADMIN"
                                                            }
                                                        }


                                                        console.log('PaasageText :' + root._FullTestQuestions_1.count)

                                                        //console.log("STRING MY DATA : " , JSON.parse(myDataJson[0].answer)[0].text)// برای نستد ها می بایست اینگونه عمل کرد

                                                        console.log("Q_DESCRIPTION = " + handleQuestion.length)

                                                        //                    obj = JSON.parse(data)

                                                        //-- JSON to S

                                                        //                    for(var i=0 ; i< data.length ; i++){

                                                        //                        delete data[i]['questions']; //-- delete object element --//
                                                        //                        delete data[i]['subject'];   //-- delete object element --//

                                                        //                    }

                                                    }sView.push(Enum._PAGE_ReadingTest)})
                                            }

                                            onL_Solution_Clicked: {

                                            }
                                        }

                                    }
                                }
                            }

                            //-- Passage Result --//
                            Flow {
                                id: myFlowPassage

                                visible: !btn_FullTest.isSelected

                                width: (flick_Result.width % 320 === 0) ? (320 * ((flick_Result.width / 320)) + ((Math.floor(flick_Result.width / 320) - 1) * spacing))
                                                                        : ((320 * Math.floor(flick_Result.width / 320)) + ((Math.floor(flick_Result.width / 320) - 1) * spacing))
                                height: implicitHeight
                                spacing: 10

                                anchors.horizontalCenter: parent.horizontalCenter

                                Repeater {
                                    model: model_LoadPassages


                                    Rectangle{

                                        width: 315
                                        height: 285
                                        color: "#ffffff"
                                        clip: true

                                        DropShadow {
                                            anchors.fill: _passage
                                            horizontalOffset: 0
                                            verticalOffset: 0
                                            radius: 6.0
                                            samples: 17
                                            color: "#b0000000"
                                            source: _passage
                                        }

                                        PassageTest{
                                            id: _passage
                                            anchors.centerIn: parent

                                            headerText: model.title
                                            topicText: model.subject
                                            imageUrl: model.image

                                            onTakeTest_Clicked: {
                                                console.log("ID is : " , model.id)

                                                var d  = Service.get_all(Service.url_passageTest + model.id , function(data){
                                                    //                                                    print("data: ", JSON.stringify(data))

                                                    var firstData = JSON.stringify(data)

                                                    var indx = firstData.indexOf('\\n')
                                                    while(indx !== -1){
                                                        firstData = firstData.replace('\\n' , "")   //\n
                                                        indx = firstData.indexOf('\\n')
                                                    }

                                                    var indx1 = firstData.indexOf('\\r')
                                                    while(indx1 !== -1){
                                                        firstData = firstData.replace('\\r' , "")  // \r
                                                        indx1 = firstData.indexOf('\\r')
                                                    }

                                                    var indx2 = firstData.indexOf('null')
                                                    while(indx2 !== -1){
                                                        firstData = firstData.replace('null' , "0")
                                                        indx2 = firstData.indexOf('null')
                                                    }

                                                    var firstDataJSON = JSON.parse(firstData)

                                                    //console.log("PARSE = " + firstDataJSON.question_description[0].questions[0] + " AND " + firstDataJSON.question_description[0].type.name)

                                                    handleQuestion = []
                                                    for(var i = 0 ; i < firstDataJSON.question_description.length ; i++){
                                                        handleQuestion.push(firstDataJSON.question_description[i])
                                                    }


                                                    //handleQuestion.setProperty(i, 'answer', JSON.stringify(firstDataJSON.questions[i].answers)) // use this for add another things


                                                    //console.log("MY DATA : " ,JSON.parse(JSON.stringify(handleQuestion)))
                                                    myQuestionDataJson = JSON.parse(JSON.stringify(handleQuestion))
                                                    for(var j = 0 ; j < myQuestionDataJson[0].questions.length ; j++){
                                                        //console.log("COUNTER OF Q : " + (j+1))
                                                        myQuestionDataJson[0].questions[j].text = myQuestionDataJson[0].questions[j].text.replace('<p>' , '<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;')
                                                        //console.log("Q " + (j+1) + " : " + myQuestionDataJson[0].questions[j].text)
                                                    }

                                                    root._PassageTestQuestions.clear()
                                                    root._PassageTestQuestions.append(myQuestionDataJson)  // Questions Data

                                                    root._PaasageText = firstDataJSON.text  // text of Question

                                                    //console.log("LAST LINE : " + root._PassageTestQuestions.get(0).text)
                                                    //--  چون ممکن است که اصلا تگ "<پی>" وجود نداشته باشد این شرط برقرار شده است و غیره --//
                                                    if(root._PaasageText.indexOf("<p>") !== -1){
                                                        root._PaasageText = root._PaasageText.replace('<p>' , '<br><p><font size="6">'+firstDataJSON.title+'</font></p><br><p>')
                                                        root._PaasageText = root._PaasageText.replace('</p>' , '</p><br><img src='+firstDataJSON.image+'><br>')
                                                    }
                                                    else if(root._PaasageText.indexOf("<ol") !== -1){
                                                        var temp = root._PaasageText.substring(root._PaasageText.indexOf("<ol") , root._PaasageText.indexOf(">")+1)
                                                        //console.log("TEMP = " , temp)
                                                        root._PaasageText = root._PaasageText.replace(temp , '<br><p><font size="6">'+firstDataJSON.title+'</font></p><br>'+temp)
                                                        root._PaasageText = root._PaasageText.replace('</p>' , '</p><br><img src='+firstDataJSON.image+'><br>')
                                                    }
                                                    else {
                                                        root._PaasageText = "PROBLEM IN TEXT FORMAT : PLEASE CALL TO MAIN ADMIN"
                                                    }



                                                    console.log('PaasageText :' + root._PassageTestQuestions)

                                                    //console.log("STRING MY DATA : " , JSON.parse(myDataJson[0].answer)[0].text)// برای نستد ها می بایست اینگونه عمل کرد

                                                    console.log("Q_DESCRIPTION = " + handleQuestion.length)

                                                    //-- برای وقتی است که یک پسیچ چندین نوع سوال دارد . بنابراین دکمه های هر نوع سوال فعال می شود --//
                                                    if(handleQuestion.length > 1){
                                                        console.log("Q_DESCRIPTION has more than one ToQ")
                                                        allToQ = handleQuestion
                                                        whichToQ(true)

                                                    }
                                                    else{
                                                        sView.push(Enum._PAGE_PassageTest)
                                                    }




                                                    //                    obj = JSON.parse(data)

                                                    //-- JSON to S

                                                    //                    for(var i=0 ; i< data.length ; i++){

                                                    //                        delete data[i]['questions']; //-- delete object element --//
                                                    //                        delete data[i]['subject'];   //-- delete object element --//

                                                    //                    }

                                                })



                                            }


                                        }

                                        /*PracticeTest{
                                            id:_practice

                                            anchors.centerIn: parent

                                            headerTitle: "Practice Test"

                                            onR_TakeTest_Clicked: {
                                                sView.push(Enum._PAGE_ReadingTest)
                                            }

                                            onL_Solution_Clicked: {
                                                log("implicit = " + myFlow.implicitWidth)
                                                log("implicit = " + myFlow.width)
                                            }
                                        }*/

                                    }
                                }
                            }
                        }

                    }
                }
            }
        }

    }

    function applyFilter(){

        //-- check passage tab selected --//
        if(btn_Passages.isSelected){

            var subjectIDs = ""
            var bookIDs = ""
            var typeTextIDs = ""
            var typeQuestionIDs = ""


            for(var i = 0 ; i < tagListModel.count ; i++){
                if(tagListModel.get(i).type === "type"){
                    if(typeTextIDs === "") typeTextIDs += tagListModel.get(i).id
                    else typeTextIDs += "," + tagListModel.get(i).id

                }
                else if(tagListModel.get(i).type === "subject"){
                    if(subjectIDs === "") subjectIDs += tagListModel.get(i).id
                    else subjectIDs += "," + tagListModel.get(i).id

                }
                else if(tagListModel.get(i).type === "question"){
                    if(typeQuestionIDs === "") typeQuestionIDs += tagListModel.get(i).id
                    else typeQuestionIDs += "," + tagListModel.get(i).id

                }
                else if(tagListModel.get(i).type === "Book"){
                    if(bookIDs === "") bookIDs += tagListModel.get(i).id
                    else bookIDs += "," + tagListModel.get(i).id

                }
            }

            console.log("TAG LIST = " , tagListModel.count)

            if (tagListModel.count > 0){
                model_LoadPassages.clear()

                //-- load Passage on SelectTestPage --// -------------------------
                var e  = Service.get_all(Service.getPassages(subjectIDs,bookIDs,typeTextIDs,typeQuestionIDs), function(data){ //  subject, book, passage(type), question_type

                    //               print("data: ", JSON.stringify(data))
                    //                print(data.length)

                    //-- JSON to S



                    for(var i=0 ; i< data.length ; i++){
                        var subjs = ""
                        //-- parse subject sub-array --//
                        for(var j=0 ; j< data[i].subject.length ; j++){
                            if(j===0) subjs = data[i].subject[j].name
                            else subjs = subjs +','+ data[i].subject[j].name
                        }

                        delete data[i]['subject']; //-- delete object element --//
                        data[i]['subject'] = subjs  //-- add custom item to json --//

                        //                    print(JSON.stringify(data[i]))
                        model_LoadPassages.append(data[i])
                        console.log("DATA : " , data[i].book)
                    }
                    for (var num=0; num<model_LoadPassages.count; num++){
                        model_LoadPassages.setProperty(num, "question_number", model_LoadPassages_backup.get(model_LoadPassages.get(num).id-1).question_number)
                    }
                    filterNumberQuestion(qNumberFilterstate)
                })
            }else{
                model_LoadPassages.clear()
                for (var num=0; num<model_LoadPassages_backup.count; num++){
                    model_LoadPassages.append(model_LoadPassages_backup.get(num))
                }
                filterNumberQuestion(qNumberFilterstate)
            }

            //                            console.log("typeTextIDs = " + bookIDs)

            //                            for(var k = 0; k < tagListModel.count; k++){
            //                                console.log(JSON.stringify(tagListModel.get(k)))
            //                            }
        }
        else if(btn_FullTest.isSelected){
            model_LoadTexts.clear()
            for (var num=0; num<model_LoadTexts_backup.count; num++){
                model_LoadTexts.append(model_LoadTexts_backup.get(num))
            }
            filterNumberQuestion(qNumberFilterstate)
        }
    }

    function filterNumberQuestion(state){

        if (btn_FullTest.isSelected){
            for (var f=model_LoadTexts.count-1; f>=0; f--){
                if (state === "B"){
                    if (model_LoadTexts.get(f).question_number > 5){
                        model_LoadTexts.remove(f)
                    }
                }else if (state === "C"){
                    if (model_LoadTexts.get(f).question_number < 6 || model_LoadTexts.get(f).question_number > 9){
                        model_LoadTexts.remove(f)
                    }
                }else if (state === "D"){
                    if (model_LoadTexts.get(f).question_number < 10){
                        model_LoadTexts.remove(f)
                    }
                }

            }
        }else if(btn_Passages.isSelected){
            if (state === "A" && tagListModel.count===0){
                model_LoadPassages.clear()
                for (var num=0; num<model_LoadPassages_backup.count; num++){
                    model_LoadPassages.append(model_LoadPassages_backup.get(num))
                }
            }

            for (var f=model_LoadPassages.count-1; f>=0; f--){
                if (state === "B"){
                    if (model_LoadPassages.get(f).question_number > 5){
                        model_LoadPassages.remove(f)
                    }
                }else if (state === "C"){
                    if (model_LoadPassages.get(f).question_number < 6 || model_LoadPassages.get(f).question_number > 9){
                        model_LoadPassages.remove(f)
                    }
                }else if (state === "D"){
                    if (model_LoadPassages.get(f).question_number < 10){
                        model_LoadPassages.remove(f)
                    }
                }

            }
        }
    }
}


