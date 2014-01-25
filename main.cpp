#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <qqml.h>

#ifdef Q_OS_WINRT
#include "accelerometer.h"
#include "audio.h"
#endif

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

#ifdef Q_OS_WINRT
    qmlRegisterType<Accelerometer>("QtSensors", 5, 0, "Accelerometer");
    qmlRegisterType<Audio>("QtMultimedia", 5, 0, "Audio");
#endif

    QQmlApplicationEngine engine;
    engine.load(QUrl("qrc:/main.qml"));

    return app.exec();
}
