import QtQuick 2.0
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1
import QtQuick.Window 2.0
import QtQuick.Dialogs 1.1

//import QtQuick.Particles 2.0 error??
import qt.login_check 1.0

Rectangle {
    id: root_w;
    width: 640;
    height: 360;
    border.color: "#808080";
    border.width: 2;
    radius:8;


    Login_Gui{
        id:loginck;
        onSig_login_result:
        {
            switch(result)
            {
            case 0 :
                console.log("Login successfully!");
                outwin.setHeight(720);
                outwin.setWidth(720);
                sceneTransition( login_win, main_w );
                break;
            case 1:
                console.log("Username or password is wrong.");
                messageDialog.text = "Username or password is wrong.";
                messageDialog.visible = true;
                break;
            case 2:
                //console.log("Try time out");
                messageDialog.text = "Time out!";
                messageDialog.visible = true;
                break;
            default:
                messageDialog.text = "Unknown errors";
                messageDialog.visible = true;
                break;
            }
        }
    }
    
    Item
    {
        id: login_win;
        visible: true;
        anchors.fill: parent
        
//        Image
//            {
//                id: background
//                anchors { top: parent.top; bottom: parent.bottom }
//                anchors.fill: parent
//                source: "resource/babyg.png"
//                fillMode: Image.PreserveAspectCrop
//            }


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



        Column{
            anchors.centerIn: parent;

            spacing: 16;
            Column
            {                  
                spacing: 2;
                MediumText {text: "Username:" ;}                                   
                LineInput
                {
                    id: usr;
                    hint: "{usr}";
                    focus : true;
                    KeyNavigation.tab: password;
                }
            }
            Column
            {
                spacing: 4;
                MediumText {text: "Password:" ;}
                LineInput
                {
                    id: password;
                    hint : "password"
                    echoMode: TextInput.Password;
                }
            }
            Row
            {
                spacing: 16;
                Button{
                    text:"Login";
                    style: btnStyle;
                    onClicked:
                    {
                        login_req();

                    }
                }
                Button{
                    //anchors.verticalCenter: parent;
                    text:"Cancel";
                    style: btnStyle;
                    onClicked: Qt.quit();
                }
            }
        }

    }//enditem1



    MessageDialog
    {
        id: messageDialog
        title: "提示"
        text: "To be or not to be!"
        onAccepted:
        {
            console.log("And of course you could only agree.")
        }
        visible:false
        //Component.onCompleted: visible = true
    }

    //log_in request:
    function login_req()
    {
        if(usr.text =="")
        {
            messageDialog.text = "user name cannot be empty!";
            messageDialog.visible = true;
            return;
        }
        loginck.user_id = usr.text;
        loginck.password = password.text;

        loginck.slot_login_req();
    }


    //show window 2
    function sceneTransition( thisScene, nextScene )
    {
        thisScene.visible = false;
        nextScene.visible = true;
    }


    //********************************************************************
    //
    //the second window:
    Item
    {
        id: main_w;
        visible: false;
        anchors.fill: parent;



    }



    Component.onCompleted:
    {
        loginck.initialise();

        }
}

