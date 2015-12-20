import QtQuick 2.0

FocusScope {
    id: wrapper;
    MouseArea {   anchors.fill: parent;
        onClicked: input.focus=true;
    }
    width: 180;
    height: 28;
    //anchors.centerIn: parent;

    property alias text: input.text;
    //property alias front_size: input.font.pixelSize;
    property alias hint: hint.text;
    property alias echoMode: input.echoMode;
    property int font_size: 16;

    signal accepted;

    Rectangle{

        //anchors.centerIn: parent;
        anchors.fill: parent;
        border.color:  "#707070";
        border.width:  2;
        color: "#c2c2c2"
        radius :4;

        Text
        {
            id:hint;
            //anchors {left:parent.left; leftMargin: 14; right: parent.right;top: parent.top; bottom: parent.bottom ;}
            //anchors.centerIn: parent;
            anchors.left:parent.left;
            anchors.leftMargin: 14;
            font.pixelSize:  font_size;
            font.bold: true;
            color: "#707070";
            text: "hint";
            opacity: input.length? 0 : 1;
        }

        TextInput
        {
            id: input;
            focus:true;
            //anchors.centerIn: parent;
            anchors.left:parent.left;
            anchors.leftMargin: 14;
            font.pixelSize: font_size ;
            font.bold: true;
            //color: "#707070" ;
            selectionColor: "blue"
            color: "black";
            onAccepted: wrapper.accepted();
        }
    }
}
