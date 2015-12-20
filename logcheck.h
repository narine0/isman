#ifndef LOGCHECK_H
#define LOGCHECK_H

#include <QObject>
#include <QTimer>    
#include <QTime>  

//#include<tr1/unordered_map>
/*********************************************************************
*                               interval of login_req
*UINT :ms
**********************************************************************/

#define INTERVAL_LOGIN        500

/*********************************************************************
*                               MAX of login requset.
**********************************************************************/
#define NUM_LOGIN   5

/******************************************************
 *Command: 
 * requset 1;
 * 
 * *****************************************************/
#define CMD_USER_LOGIN_REQUEST 1

class Logcheck : public QObject
{
    Q_OBJECT

    //property: usrname
    Q_PROPERTY(QString user_id READ user_id WRITE set_user_id NOTIFY sig_user_id_changed)
    //property:password
    Q_PROPERTY(QString password READ password WRITE set_password NOTIFY sig_password_changed)
    //property:check type(local file, sql)
    Q_PROPERTY(qint8 check_type READ check_type WRITE set_check_type NOTIFY sig_check_type_changed)
public:
    //explicit Logcheck(QObject *parent = 0);
    //structure function
    Logcheck();
    ~Logcheck();


    //read property : usr_id
    QString user_id();
    //read property : password
    QString password();
    //read property : check_type
    qint8 check_type();
    //write property: user_id
    void set_user_id(QString str);
    //write property: password
    void set_password(QString str);
    //write property: check_type
    void set_check_type(qint8 itype);

signals:
    // signal of property changed: usr_id
    void sig_user_id_changed();
    //signal of property changed: password
    void sig_password_changed();
    //signal of propertychanged:check_type
    void sig_check_type_changed();
    //********************
    //sigal of login result
    //params:result 0: successful;
    //                       1: Usr or password is wrong
    //                       2: Maximum number of login.
    //********************
    void sig_login_result(int result);  
    //********************
    //sending network frame
    //params:id : usr_id
    //             cmd: frame command
    //             index: sending index
    //             frame: message of sending
    //********************
    //void sig_net_tx_frame_with_id(quint32 id, quint32 password, int cmd ,quint16 index,QByteArray frame);
    void sig_net_tx_frame_with_id(QByteArray frame);
public slots:
    //Initialise..
    void initialise();
    // request of login:
    void slot_login_req();
    // response of login
    void slot_login_ack(QByteArray data);  
private slots:
    //pulse
    void slot_tick(); 


private:
    //user id:
    QString _user_id;
    // user password
    QString _password; 
    // passwd configfile
    QString _cfg;
    // check_type:
    qint8 _check_type;
    //timer:
    QTimer *timer;  
    //login counter
    int Login_Counter; 

    //data base of usr/passwd:
    //QMap<std::string, std::string> passwd_tab;
    QHash<QString,QString> usr_passwd_tab;
    //std::map<std::string,std::string> passwd_tab;
    //std::tr1::unordered_map<std::string, std::string> usr_passwd_tab;
};

#endif // LOGCHECK_H
