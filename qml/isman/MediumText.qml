import QtQuick 2.0



Rectangle{
    id:rect1;
    width: 180;
    height: 28;
    //anchors.centerIn: parent;
    property alias text: lab.text;
    Text {
        id:lab;
        //anchors.centerIn: parent;
        //anchors.verticalCenter: parent;
        font.bold: true;
        text: "text";
    }
 }


