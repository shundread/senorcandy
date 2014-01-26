#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <qqml.h>

#ifdef Q_OS_WINRT
#include "accelerometer.h"
#include "audio.h"
#endif

#include "momentmanager.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

#ifdef Q_OS_WINRT
    qmlRegisterType<Accelerometer>("QtSensors", 5, 0, "Accelerometer");
    qmlRegisterType<Audio>("QtMultimedia", 5, 0, "Audio");
#endif

    qmlRegisterType<MomentManager>("Moments", 1, 0, "MomentManager");
    qmlRegisterType<Moment>("Moments", 1, 0, "Moment");

    QQmlApplicationEngine engine;
    engine.load(QUrl("qrc:/main.qml"));

    return app.exec();
}
