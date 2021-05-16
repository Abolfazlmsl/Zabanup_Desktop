import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Window 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

import "./../../../Fonts/Icon.js" as Icons
import "./../ListModels"
import "./../ListModels/FilterModels"
import "./../Test/CategoryPages"
import "./../../Modules"
import "./../../Modules/SideFilterItems"
import "./../../Utils/Enum.js" as Enum

Item {
    objectName: "LearnPage"

    //-- ListModel For Handling Tags --//
    ListModel{id: tagListModel}

    //-- Background --//
    Rectangle{
        anchors.fill: parent
        color: "#ffffff"
    }

    RowLayout{
        anchors.fill: parent
        spacing: -20
        //-- Left Filter Section --//
        Rectangle{
            Layout.fillHeight: true
            Layout.preferredWidth: 300 * ratio

            Layout.topMargin: 25 * ratio
            Layout.leftMargin: 10 * ratio
            //              color: "#66ff0000"

                //-- left Filter --//
                Rectangle{
                    id: root_Q

                    width: parent.width - (30 * ratio)
                    height: parent.height - (30 * ratio)

                    radius: 10 * ratio

                    border.color: "#5d5d5d"
                    border.width: 2
                    clip: true

                    //-- header --//
                    Rectangle{
                        id: header_Q

                        width: parent.width - (10 * ratio)
                        height: 35 * ratio

                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                        anchors.topMargin: 5 * ratio

                        color: "#6c88b7"
                        radius: 5 * ratio

                        //-- Text --//
                        Label{
                            id:title_Q
                            text: "سوالات مرتبط"
                            anchors.centerIn: parent
                            font.family: iranSans.name
                            font.pixelSize: Qt.application.font.pixelSize * 0.9
                            color: "#ffffff"
                        }

                        //-- Icon --//
                        Label{
                            id: titleIcon_Q
                            visible: false
                            text: Icons.chevron_down
                            anchors.right: parent.right
                            anchors.rightMargin: 10 * ratio
                            anchors.verticalCenter: parent.verticalCenter

                            font.family: webfont.name
                            font.pixelSize: Qt.application.font.pixelSize * 2 * ratio

                            color: "#ffffff"



                            NumberAnimation {
                                id: rotateArrowUP_Q
                                target: titleIcon_Q
                                property: "rotation"
                                from: 0
                                to: 180
                                duration: 200
                                easing.type: Easing.InOutQuad
                            }
                            NumberAnimation {
                                id: rotateArrowDOWN_Q
                                target: titleIcon_Q
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
                                root_Q.isExpanded = !root_Q.isExpanded
                                if(root_Q.isExpanded){
                                    rotateArrowDOWN_Q.restart()
                                }
                                else{
                                    rotateArrowUP_Q.restart()
                                }
                            }
                        }
                    }

                    //-- body --//
                    Rectangle{
                        id: body_Q

                        visible: true

                        width: parent.width - (10 * ratio)
                        height: parent.height
                        anchors.top: header_Q.bottom
                        anchors.topMargin: 5 * ratio
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 5 * ratio
                        anchors.horizontalCenter: parent.horizontalCenter
                        //                            color: "#e5e5e5"
                        //                            radius: 5 * ratio
                        clip: true

                        ListView{
                            id: lst_QFilterButtons

                            anchors.fill: parent
                            topMargin: 4 * ratio
                            bottomMargin: 4 * ratio
                            clip: true
                            spacing: 4 * ratio

                            boundsBehavior: Flickable.StopAtBounds

                            ScrollBar.vertical: ScrollBar {
                                width: 10 * ratio
                                policy: ScrollBar.AsNeeded
                                parent: lst_QFilterButtons.parent
                                anchors.top: lst_QFilterButtons.top
                                anchors.left: lst_QFilterButtons.left
                                anchors.bottom: lst_QFilterButtons.bottom
                            }

                            model: Subject_Model{id: model_Q}

                            delegate: FiltersButton{

                                width: parent.width - (16 * ratio) // (LeftMargin + rightMargin) - Left and Right Border
                                height: 35 * ratio
                                anchors.horizontalCenter: parent.horizontalCenter
                                subjText: model.title

                                btnColor: (isSelected) ? "#23b7ca" : "#ffffff"
                                lblColor: (isSelected) ? "#ffffff" : "#5d5d5d"

                                onClickSubjectFilter: {
                                    model_Q.setProperty(index, 'isSelected', !model_Q.get(index).isSelected)
                                    if(model_Q.get(index).isSelected){

                                        tagListModel.append(model_Q.get(index))
                                    }
                                    else{
                                        for(var i=0; i<tagListModel.count; i++ ){

                                            if(model_Q.get(index).title === tagListModel.get(i).title){
                                                tagListModel.remove(i);
                                                break;
                                            }
                                        }
                                    }
                                }
                            }
                        }

                    }
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

                //-- Level and Type Filter Section --//
                Rectangle{
                    Layout.fillWidth: true
                    Layout.preferredHeight: 280 * ratio

                    color: "#ffffff"

                    //-- Level and Filter Type --//
                    RowLayout{
                        anchors.fill: parent
                        spacing: 5 * ratio

                        //-- Filler --//
                        Item {Layout.fillWidth: true}

                        //-- Level Filter --//
                        Rectangle{
                            id: root_Level

                            Layout.preferredWidth: 260 * ratio
                            Layout.fillHeight: true

                            radius: 10 * ratio

                            border.color: "#5d5d5d"
                            border.width: 2
                            clip: true

                            //-- header --//
                            Rectangle{
                                id: header_Level

                                width: parent.width - (10 * ratio)
                                height: 35 * ratio

                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.top: parent.top
                                anchors.topMargin: 5 * ratio

                                color: "#6c88b7"
                                radius: 5 * ratio

                                //-- Text --//
                                Label{
                                    id:title_Level
                                    text: "سطح"
                                    anchors.centerIn: parent
                                    font.family: iranSans.name
                                    font.pixelSize: Qt.application.font.pixelSize * 0.9
                                    color: "#ffffff"
                                }

                                //-- Icon --//
                                Label{
                                    id: titleIcon_Level
                                    visible: false
                                    text: Icons.chevron_down
                                    anchors.right: parent.right
                                    anchors.rightMargin: 10 * ratio
                                    anchors.verticalCenter: parent.verticalCenter

                                    font.family: webfont.name
                                    font.pixelSize: Qt.application.font.pixelSize * 2 * ratio

                                    color: "#ffffff"



                                    NumberAnimation {
                                        id: rotateArrowUP_Level
                                        target: titleIcon_Q
                                        property: "rotation"
                                        from: 0
                                        to: 180
                                        duration: 200
                                        easing.type: Easing.InOutQuad
                                    }
                                    NumberAnimation {
                                        id: rotateArrowDOWN_Level
                                        target: titleIcon_Q
                                        property: "rotation"
                                        from: 180
                                        to: 0
                                        duration: 200
                                        easing.type: Easing.InOutQuad
                                    }

                                }

                                MouseArea{
                                    anchors.fill: parent
                                    enabled: false
                                    onClicked: {
                                        root_Q.isExpanded = !root_Q.isExpanded
                                        if(root_Q.isExpanded){
                                            rotateArrowDOWN_Q.restart()
                                        }
                                        else{
                                            rotateArrowUP_Q.restart()
                                        }
                                    }
                                }
                            }

                            //-- body --//
                            Rectangle{
                                id: body_Level

                                visible: true

                                width: parent.width - (10 * ratio)
                                height: parent.height
                                anchors.top: header_Level.bottom
                                anchors.topMargin: 5 * ratio
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: 5 * ratio
                                anchors.horizontalCenter: parent.horizontalCenter
                                //                            color: "#e5e5e5"
                                //                            radius: 5 * ratio
                                clip: true

                                ListView{
                                    id: lst_LevelFilterButtons

                                    anchors.fill: parent
                                    topMargin: 4 * ratio
                                    bottomMargin: 4 * ratio
                                    clip: true
                                    spacing: 4 * ratio

                                    boundsBehavior: Flickable.StopAtBounds

                                    ScrollBar.vertical: ScrollBar {
                                        width: 10 * ratio
                                        policy: ScrollBar.AsNeeded
                                        parent: lst_LevelFilterButtons.parent
                                        anchors.top: lst_LevelFilterButtons.top
                                        anchors.left: lst_LevelFilterButtons.left
                                        anchors.bottom: lst_LevelFilterButtons.bottom
                                    }

                                    model: ToQ_Model{id: model_Level}

                                    delegate: FiltersButton{

                                        width: parent.width - (16 * ratio) // (LeftMargin + rightMargin) - Left and Right Border
                                        height: 35 * ratio
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        subjText: model.title

                                        btnColor: (isSelected) ? "#23b7ca" : "#ffffff"
                                        lblColor: (isSelected) ? "#ffffff" : "#5d5d5d"

                                        onClickSubjectFilter: {
                                            model_Level.setProperty(index, 'isSelected', !model_Level.get(index).isSelected)
                                            if(model_Level.get(index).isSelected){

                                                tagListModel.append(model_Level.get(index))
                                            }
                                            else{
                                                for(var i=0; i<tagListModel.count; i++ ){

                                                    if(model_Level.get(index).title === tagListModel.get(i).title){
                                                        tagListModel.remove(i);
                                                        break;
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }

                            }
                        }

                        //-- Learn Type Filter --//
                        Rectangle{
                            id: root_LearnType

                            Layout.preferredWidth: 260 * ratio
                            Layout.fillHeight: true

                            radius: 10 * ratio

                            border.color: "#5d5d5d"
                            border.width: 2
                            clip: true

                            //-- header --//
                            Rectangle{
                                id: header_LearnType

                                width: parent.width - (10 * ratio)
                                height: 35 * ratio

                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.top: parent.top
                                anchors.topMargin: 5 * ratio

                                color: "#6c88b7"
                                radius: 5 * ratio

                                //-- Text --//
                                Label{
                                    id:title_LearnType
                                    text: "نوع آموزش"
                                    anchors.centerIn: parent
                                    font.family: iranSans.name
                                    font.pixelSize: Qt.application.font.pixelSize * 0.9
                                    color: "#ffffff"
                                }

                                //-- Icon --//
                                Label{
                                    id: titleIcon_LearnType
                                    visible: false
                                    text: Icons.chevron_down
                                    anchors.right: parent.right
                                    anchors.rightMargin: 10 * ratio
                                    anchors.verticalCenter: parent.verticalCenter

                                    font.family: webfont.name
                                    font.pixelSize: Qt.application.font.pixelSize * 2 * ratio

                                    color: "#ffffff"



                                    NumberAnimation {
                                        id: rotateArrowUP_LearnType
                                        target: titleIcon_Q
                                        property: "rotation"
                                        from: 0
                                        to: 180
                                        duration: 200
                                        easing.type: Easing.InOutQuad
                                    }
                                    NumberAnimation {
                                        id: rotateArrowDOWN_LearnType
                                        target: titleIcon_Q
                                        property: "rotation"
                                        from: 180
                                        to: 0
                                        duration: 200
                                        easing.type: Easing.InOutQuad
                                    }

                                }

                                MouseArea{
                                    anchors.fill: parent
                                    enabled: false
                                    onClicked: {
                                        root_Q.isExpanded = !root_Q.isExpanded
                                        if(root_Q.isExpanded){
                                            rotateArrowDOWN_Q.restart()
                                        }
                                        else{
                                            rotateArrowUP_Q.restart()
                                        }
                                    }
                                }
                            }

                            //-- body --//
                            Rectangle{
                                id: body_LearnType

                                visible: true

                                width: parent.width - (10 * ratio)
                                height: parent.height
                                anchors.top: header_LearnType.bottom
                                anchors.topMargin: 5 * ratio
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: 5 * ratio
                                anchors.horizontalCenter: parent.horizontalCenter
                                //                            color: "#e5e5e5"
                                //                            radius: 5 * ratio
                                clip: true

                                ListView{
                                    id: lst_LearnTypeFilterButtons

                                    anchors.fill: parent
                                    topMargin: 4 * ratio
                                    bottomMargin: 4 * ratio
                                    clip: true
                                    spacing: 4 * ratio

                                    boundsBehavior: Flickable.StopAtBounds

                                    ScrollBar.vertical: ScrollBar {
                                        width: 10 * ratio
                                        policy: ScrollBar.AsNeeded
                                        parent: lst_LearnTypeFilterButtons.parent
                                        anchors.top: lst_LearnTypeFilterButtons.top
                                        anchors.left: lst_LearnTypeFilterButtons.left
                                        anchors.bottom: lst_LearnTypeFilterButtons.bottom
                                    }

                                    model: ToT_Model{id: model_LearnType}

                                    delegate: FiltersButton{

                                        width: parent.width - (16 * ratio) // (LeftMargin + rightMargin) - Left and Right Border
                                        height: 35 * ratio
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        subjText: model.title

                                        btnColor: (isSelected) ? "#23b7ca" : "#ffffff"
                                        lblColor: (isSelected) ? "#ffffff" : "#5d5d5d"

                                        onClickSubjectFilter: {
                                            model_LearnType.setProperty(index, 'isSelected', !model_LearnType.get(index).isSelected)
                                            if(model_LearnType.get(index).isSelected){

                                                tagListModel.append(model_LearnType.get(index))
                                            }
                                            else{
                                                for(var i=0; i<tagListModel.count; i++ ){

                                                    if(model_LearnType.get(index).title === tagListModel.get(i).title){
                                                        tagListModel.remove(i);
                                                        break;
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }

                            }
                        }

                        //-- Filler --//
                        Item {Layout.fillWidth: true}

                    }
                }

                //-- Tags Section --//
                Rectangle{
                    Layout.fillWidth: true
                    Layout.preferredHeight: 65 * ratio

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


                    //-- Tags ListView --//
                    ListView{
                        id: lst_TagsFilter
                        anchors.fill: parent

                        orientation: ListView.Horizontal
                        layoutDirection: Qt.RightToLeft
                        spacing: 10 * ratio
                        clip: true
                        anchors.rightMargin: 2
                        anchors.leftMargin: 2
                        rightMargin: 10 * ratio
                        leftMargin: 10 * ratio

                        model: tagListModel


                        delegate: TagButton{

                            anchors.verticalCenter: parent.verticalCenter

                            tagText: model.title
                            btnColor: {
                                if(model.category === "Subject"){
                                    return "#96cdf9"
                                }
                                else if(model.category === "ToQ"){
                                    return "#85cdc6"
                                }
                                else if(model.category === "ToT"){
                                    return "#93f5ed"
                                }
                                else if(model.category === "Book"){
                                    return "#addaae"
                                }
                            }

                            lblColor: "#5d5d5d"

                            onClickTag: {
                                if(tagListModel.get(index).category === "Subject"){
                                    for(var i=0; i<model_Q.count; i++ ){

                                        if(model_Q.get(i).title === tagListModel.get(index).title){
                                            tagListModel.remove(index)
                                            model_Q.setProperty(i, 'isSelected', false)
                                            break;
                                        }
                                    }
                                }
                                else if(tagListModel.get(index).category === "ToT"){
                                    for(var j=0; j<model_LearnType.count; j++ ){

                                        if(model_LearnType.get(j).title === tagListModel.get(index).title){
                                            tagListModel.remove(index)
                                            model_LearnType.setProperty(j, 'isSelected', false)
                                            break;
                                        }
                                    }
                                }
                                else if(tagListModel.get(index).category === "ToQ"){
                                    for(var k=0; k<model_Level.count; k++ ){

                                        if(model_Level.get(k).title === tagListModel.get(index).title){
                                            tagListModel.remove(index)
                                            model_Level.setProperty(k, 'isSelected', false)
                                            break;
                                        }
                                    }
                                }

                            }
                        }

                        add: Transition {
                            NumberAnimation { property: "opacity"; from: 0; to: 1.0; duration: 400 }
                            NumberAnimation { property: "scale"; from: 0; to: 1.0; duration: 400 }
                        }

                        displaced: Transition {
                            NumberAnimation { properties: "x,y"; duration: 400; easing.type: Easing.OutBounce }
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
                        contentHeight: myFlow.height
                        clip: true

                        //                            anchors.margins: 20 * ratio

                        ScrollBar.vertical: ScrollBar {
                            width: 10 * ratio
                            policy: ScrollBar.AlwaysOn
                            parent: flick_Result.parent
                            anchors.top: flick_Result.top
                            anchors.right: flick_Result.right
                            anchors.bottom: flick_Result.bottom
                        }

                        Flow {
                            id: myFlow
                            width: parent.width
                            height: implicitHeight
                            spacing: 10 * ratio


                            Repeater {
                                model: FilterListModel{}

                                PracticeTest{

                                    headerTitle: "Practice Test"

                                    onR_TakeTest_Clicked: {
                                        sView.push(Enum._PAGE_CambridgeBookTest)
                                    }
                                }
                            }
                        }
                    }

                }
            }
        }
    }


}
