import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Window 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

import "./../../../../Fonts/Icon.js" as Icons
import "./../../../Utils/Enum.js" as Enum
import "./../../ListModels"

Item {

    //-- Body --//
    Rectangle{

        width: parent.width
        height: parent.height



        //Layout.leftMargin: (booksGrid.width - booksGrid.contentWidth)
        //Layout.topMargin: 70 * heightRatio
        //color: "#55ff0000"

        //-- Sample Image (width and height for use) --//
        Image {
            id: imgBooks
            visible: false
            source: "qrc:/Content/Images/SelectTest_Image/book_8.png"
        }

        //-- Flickable for Show Books (in Future add books) --//
        Flickable{

            property int cols: 4

            width: (widthRatio <= heightRatio)
                   ? (imgBooks.sourceSize.width * widthRatio * cols ) + ((cols-1) * myflow.spacing) + (40 * ratio) + 3 //(cols * 3)
                   : (imgBooks.sourceSize.width * heightRatio * cols ) + ((cols-1) * myflow.spacing) + (40 * ratio) + 3 //(cols * 3)

            height: contentHeight + myflow.padding

            contentHeight: myflow.implicitHeight



            //anchors.leftMargin: 10 * widthRatio
            //anchors.rightMargin: 100 * widthRatio

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            boundsBehavior: Flickable.StopAtBounds
            clip: true

            /*Rectangle{ //-- for show place of books --//
                anchors.fill: parent
                color: "#55ff0000"
            }*/


            //-- books holder --//
            Flow{
                id:myflow
                anchors.fill: parent
                spacing: 20 * ratio

                padding: 20 * ratio

                clip: true

                //-- for delegate Books --//
                Repeater{
                    model: testBooks


                }
            }
        }

    }

}
