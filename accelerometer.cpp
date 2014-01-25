#include "accelerometer.h"

#include <QVector3D>

#include <wrl.h>
#include <windows.devices.sensors.h>
using namespace Microsoft::WRL;
using namespace Microsoft::WRL::Wrappers;
using namespace ABI::Windows::Foundation;
using namespace ABI::Windows::Devices;

typedef ITypedEventHandler<Sensors::Accelerometer *, Sensors::AccelerometerReadingChangedEventArgs *> AccelerometerReadingHandler;

class AccelerometerPrivate
{
public:
    ComPtr<Sensors::IAccelerometer> accelerometer;

    QVector3D reading;
};

Accelerometer::Accelerometer(QObject *parent) :
    QObject(parent), d(new AccelerometerPrivate)
{
    ComPtr<Sensors::IAccelerometerStatics> accelerometerFactory;
    HRESULT hr = RoGetActivationFactory(HString::MakeReference(RuntimeClass_Windows_Devices_Sensors_Accelerometer).Get(),
                                        IID_PPV_ARGS(&accelerometerFactory));
    hr = accelerometerFactory->GetDefault(&d->accelerometer);
    EventRegistrationToken readingChangedToken;
    hr = d->accelerometer->add_ReadingChanged(Callback<AccelerometerReadingHandler>(this, &Accelerometer::onReadingChanged).Get(), &readingChangedToken);
    hr = d->accelerometer->put_ReportInterval(1);
}

Accelerometer::~Accelerometer()
{
}

QVector3D Accelerometer::reading() const
{
    return d->reading;
}

HRESULT Accelerometer::onReadingChanged(Sensors::IAccelerometer *, Sensors::IAccelerometerReadingChangedEventArgs *args)
{
    ComPtr<Sensors::IAccelerometerReading> reading;
    HRESULT hr = args->get_Reading(&reading);
    DOUBLE x, y, z;
    hr = reading->get_AccelerationX(&x);
    hr = reading->get_AccelerationY(&y);
    hr = reading->get_AccelerationZ(&z);
    d->reading[0] = x;
    d->reading[1] = y;
    d->reading[2] = z;
    emit readingChanged();
    return S_OK;
}
