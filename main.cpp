#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtCharts>
#include <QQmlComponent>
#include <QLocale>

#include <QFontDatabase>
#include <documenthandler.h>

using namespace QtCharts;
int main(int argc, char *argv[])
{

    QApplication app(argc, argv);

    //-- material design configuration --//
    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    //QGuiApplication app(argc, argv);

    //-- material font icons --//
    QFontDatabase::addApplicationFont(":/fonts/materialdesignicons-webfont.ttf");

     qmlRegisterType<DocumentHandler>("io.qt.examples.texteditor", 1, 0, "DocumentHandler");

    //-- QSetting configuration --//
    QCoreApplication::setOrganizationName("MediaSoft");
    QCoreApplication::setOrganizationDomain("MediaSoft.ir");
    QCoreApplication::setApplicationName("ZabanUp");


    qputenv("QT_QUICK_CONTROLS_STYLE", "material");

    QQmlApplicationEngine engine;


    QQmlComponent component(&engine);
//    QQuickWindow::setDefaultAlphaBuffer(true);
    component.loadUrl(QUrl(QStringLiteral("qrc:/main.qml")));
    if ( component.isReady()) {
        component.create();
    }
    else{
        qWarning() << component.errorString();
    }


    //-- windows icon --//
    app.setWindowIcon(QIcon(":/Content/Images/logo_squre.png"));

    QString local1 =  QLocale::languageToString(QLocale::system().language());

    return app.exec();
}
