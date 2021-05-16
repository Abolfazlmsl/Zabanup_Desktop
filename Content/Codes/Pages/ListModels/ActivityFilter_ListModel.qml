import QtQuick 2.14

ListModel {

    ListElement {
        type: "Date"
        name: "تمامی تاریخ ها"
        isSelected: true
    }
    ListElement {
        type: "Date"
        name: "امروز"
        isSelected: false
    }
    ListElement {
        type: "Date"
        name: "این هفته"
        isSelected: false
    }
    ListElement {
        type: "Date"
        name: "این ماه"
        isSelected: false
    }
    ListElement {
        type: "Date"
        name: "امسال"
        isSelected: false
    }
    ListElement {
        type: "Date"
        name: "انتخاب تاریخ"
        isSelected: false
    }


    ListElement {
        type: "TestType"
        name: "تمامی آزمون ها"
        isSelected: true
    }
    ListElement {
        type: "TestType"
        name: "آزمون 1"
        isSelected: false
    }
    ListElement {
        type: "TestType"
        name: "آزمون 2"
        isSelected: false
    }
    ListElement {
        type: "TestType"
        name: "آزمون 3"
        isSelected: false
    }

}
