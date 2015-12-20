#include "commonheader.h"
#include "logcheck.h"

//Logcheck::Logcheck(QObject *parent) :
//    QObject(parent)
//{
    
//}
Logcheck::Logcheck()

{
        //Initialise login_counter  
        Login_Counter = 0;  
        //pulse  
        timer = new QTimer(this);  
        //bind singal  
        connect(timer, SIGNAL (timeout()), this , SLOT(slot_tick()));  
        connect(this, SIGNAL(sig_net_tx_frame_with_id(QByteArray)), this, SLOT(slot_login_ack(QByteArray)) );
        //connect(this,&Logcheck::sig_net_tx_frame_with_id,this, &Logcheck::slot_login_ack);
        _cfg = "cfg.txt";

}

void Logcheck::initialise()
{
    QFile file_cfg("cfg.txt");
    //QByteArray arr;
    //QString str;
    QString line;

    if(!file_cfg.exists())
    {
        file_cfg.close();
        std::cout << "file_cfg not exist!";
        qDebug()<<"file_cfg not exist!";

    }
    else
    {
        file_cfg.open(QIODevice::ReadOnly);
        QTextStream in( &file_cfg );
        while(!in.atEnd())
        {
            line.clear();
            line = in.readLine();
            std::stringstream sstr(line.toStdString());
             std::string a,b;
             sstr >> a >>b;
             //usr_passwd_tab.insert(a,b);
             usr_passwd_tab.insert(QString::fromStdString(a),QString::fromStdString (b));
        }

    }

}

QString Logcheck::user_id()
{
    return _user_id;
}
QString Logcheck::password()
{
    return _password;
}
qint8 Logcheck::check_type()
{
    return _check_type;
}

void Logcheck::set_user_id(QString str)
{
    if (_user_id != str)
    {
        _user_id = str;
        emit sig_user_id_changed();
    }
}
void Logcheck::set_password(QString str)
{
    _password = str;
}
void Logcheck::set_check_type(qint8 itype)
{
  _check_type = itype;
}

//login request
void Logcheck::slot_login_req()
{
    Login_Counter = 0;
    timer->start(INTERVAL_LOGIN);
    slot_tick();
}
void Logcheck::slot_login_ack(QByteArray data)
{
    Login_Counter = 0;
    timer->stop();
    if( usr_passwd_tab.contains(_user_id) )
    {
        if( usr_passwd_tab[_user_id] == _password)
            emit sig_login_result(0);
        else
            sig_login_result(1);
    }
    else
        emit sig_login_result(1);
}


void Logcheck::slot_tick()
{
    QByteArray frame;
    bool ok;

    Login_Counter++;
    if(Login_Counter > NUM_LOGIN)
    {
#ifdef DEBUG
        qDebug() << "Fail to login, maximum : " << NUM_LOGIN;
#endif
        Login_Counter = 0;
        timer->stop();
        //
        emit sig_login_result(2);
        return;
    }
    //sending request message
    frame.clear();
    //frame.push_back(_user_id);
#ifdef DEBUG
    qDebug() << "sending frame: request";
#endif
    //emit sig_net_tx_frame_with_id((quint32)_user_id.toInt(&ok),(quint32)_password.toInt(&ok),CMD_USER_LOGIN_REQUEST,0,frame);
    emit sig_net_tx_frame_with_id( frame );
}

//void Logcheck::sig_net_tx_frame_with_id(quint32 id, quint32 password, int cmd ,quint16 index,QByteArray frame)
//{
//}

Logcheck::~Logcheck()
{

}
