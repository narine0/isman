#include <QtGui/QGuiApplication>
#include "qtquick2applicationviewer.h"

 #include<QQmlContext>
#include <QtQml>
#include "logcheck.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    qmlRegisterType<Logcheck>("qt.login_check",1,0, "Login_Gui");
    QtQuick2ApplicationViewer viewer;
    viewer.setMainQmlFile(QStringLiteral("qml/isman/main.qml"));
    //viewer.setOpacity(100);
    viewer.setTitle("hello isman");
    viewer.showExpanded();

    viewer.rootContext()->setContextProperty("outwin",&viewer);
    return app.exec();
}
