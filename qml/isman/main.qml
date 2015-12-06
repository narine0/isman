import QtQuick 2.0
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1
import QtQuick.Window 2.0

//import QtQuick.Particles 2.0

Rectangle {

//ApplicationWindow{
//Item{

    id: root_w;
    width: 360;
    height: 360;
    //title:"isman";

//   property Window win;
    border.color: "#808080";
    border.width: 2;
    radius:8;

    Item
    {
        id: login_win;
        visible: true;
        anchors.fill: parent

        Rectangle{
            id:background;
            anchors.left: parent.left;
            anchors.leftMargin: 4;
            anchors.right: parent.right;
            anchors.rightMargin:  4;
            anchors.top:  parent.top;
            anchors.topMargin: 4;
            anchors.bottom:  parent.bottom;
            anchors.bottomMargin: 4;

            rotation: 90;
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#212121" }
                GradientStop { position: 1.0; color: "#A0A0A0"; }
            }
        }

        Text {
            id: lab_usr
            x: 62
            y: 135
            text: qsTr("user:")
            anchors.verticalCenterOffset: -36
            anchors.horizontalCenterOffset: -101
            anchors.centerIn: parent
        }
        Text {
            id: lab_password
            y: 164
            anchors.left: parent.left;
            anchors.leftMargin: 43
            anchors.verticalCenterOffset: -7
            anchors.horizontalCenterOffset: -102
            anchors.centerIn: parent

            text: qsTr("password:")
            z: 1
        }

        MouseArea {
            anchors.rightMargin: 0
            anchors.bottomMargin: 0
            anchors.leftMargin: 0
            anchors.topMargin: 0
            anchors.fill: parent
            onClicked: {
                //Qt.quit();
            }
        }

        //Button style:
        Component{
                id: btnStyle;
                ButtonStyle {
                    background: Rectangle {
                        implicitWidth: 70;
                        implicitHeight: 25;
                        color: "#DDDDDD";
                        border.width: control.pressed ? 2 : 1;
                        border.color: (control.hovered || control.pressed) ? "green" : "#888888";
                    }
                }
            }

        Button{
            x: 138
            y: 203
            anchors.centerIn: parent;
            text:"log in";
            anchors.verticalCenterOffset: 37
            anchors.horizontalCenterOffset: 1
            style: btnStyle;
            onClicked:
            {
                outwin.setHeight(720);
                outwin.setWidth(720);
                //outwin.setHeight(180);
                //win.showMinimized();
                //win.close();
                //win.setWidth(180);
                //win.setHeight(180);
                sceneTransition( login_win, main_w );
            }
        }

        TextInput {
            id: usr
            x: 138
            y: 133
            width: 175
            height: 20
            anchors.verticalCenterOffset: -37
            anchors.horizontalCenterOffset: 46
            anchors.centerIn: parent
            text: qsTr("Input usrname")
            font.pixelSize: 12
        }

        TextInput {
            id: password
            x: 138
            y: 162
            width: 175
            height: 20
            anchors.verticalCenterOffset: -8
            anchors.horizontalCenterOffset: 46
            anchors.centerIn: parent
            text: qsTr("password")
            font.pixelSize: 12
        }

    }



    Item
    {
        id: main_w;
        visible: false;
        anchors.fill: parent;

    }


    function sceneTransition( thisScene, nextScene )
    {
        thisScene.visible = false;

        nextScene.visible = true;
//            emitterTimer.thisScene = thisScene;
//            emitterTimer.nextScene = nextScene;
//            emitter.enabled = true;
    }
}

