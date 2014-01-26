#ifndef ACCELEROMETER_H
#define ACCELEROMETER_H

#include <QObject>
#include <QVector3D>
#include <QScopedPointer>
#include <qt_windows.h>

namespace ABI {
    namespace Windows {
        namespace Devices {
            namespace Sensors {
                struct IAccelerometer;
                struct IAccelerometerReadingChangedEventArgs;
            }
        }
    }
}

class AccelerometerPrivate;
class Accelerometer : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool active READ active WRITE setActive)
    //alwaysOn : bool
    //availableDataRates : list<Range>
    //axesOrientationMode : Sensor::AxesOrientationMode
    //bufferSize : int
    //busy : bool
    //connectedToBackend : bool
    //currentOrientation : int
    Q_PROPERTY(int dataRate READ dataRate WRITE setDataRate NOTIFY dataRateChanged)
    //description : string
    //efficientBufferSize : int
    //error : int
    //identifier : string
    //maxBufferSize : int
    //outputRange : int
    //outputRanges : list<OutputRange>
    Q_PROPERTY(/*SensorReading*/QVector3D reading READ reading NOTIFY readingChanged)
    //skipDuplicates : bool
    //type : string
    //userOrientation : int
public:
    explicit Accelerometer(QObject *parent = 0);
    ~Accelerometer();

    bool active() const;
    void setActive(bool active);

    QVector3D reading() const;

    int dataRate() const;
    void setDataRate(int dataRate);

signals:
    void readingChanged();
    void dataRateChanged();
    void activeChanged();

private:
    HRESULT __stdcall onReadingChanged(ABI::Windows::Devices::Sensors::IAccelerometer *,
                                       ABI::Windows::Devices::Sensors::IAccelerometerReadingChangedEventArgs *);

    QScopedPointer<AccelerometerPrivate> d;
};

#endif // ACCELEROMETER_H
