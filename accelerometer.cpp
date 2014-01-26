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
    EventRegistrationToken readToken;

    QVector3D reading;
    int dataRate;
    bool active;
};

Accelerometer::Accelerometer(QObject *parent) :
    QObject(parent), d(new AccelerometerPrivate)
{
    d->active = false;
    ComPtr<Sensors::IAccelerometerStatics> accelerometerFactory;
    HRESULT hr = RoGetActivationFactory(HString::MakeReference(RuntimeClass_Windows_Devices_Sensors_Accelerometer).Get(),
                                        IID_PPV_ARGS(&accelerometerFactory));
    hr = accelerometerFactory->GetDefault(&d->accelerometer);
    quint32 reportInterval;
    d->accelerometer->get_ReportInterval(&reportInterval);
    d->dataRate = 1000/reportInterval;
}

Accelerometer::~Accelerometer()
{
}

bool Accelerometer::active() const
{
    return d->active;
}

void Accelerometer::setActive(bool active)
{
    if (active == d->active)
        return;

    d->active = active;
    if (d->active)
        HRESULT hr = d->accelerometer->add_ReadingChanged(Callback<AccelerometerReadingHandler>(this, &Accelerometer::onReadingChanged).Get(), &d->readToken);
    else
        HRESULT hr = d->accelerometer->remove_ReadingChanged(d->readToken);

    emit activeChanged();
}

QVector3D Accelerometer::reading() const
{
    return d->reading;
}

int Accelerometer::dataRate() const
{
    return d->dataRate;
}

void Accelerometer::setDataRate(int dataRate)
{
    if (dataRate == d->dataRate)
        return;

    d->dataRate = dataRate;
    d->accelerometer->put_ReportInterval(1000/dataRate); // Hz to ms
    emit dataRateChanged();
}

HRESULT Accelerometer::onReadingChanged(Sensors::IAccelerometer *, Sensors::IAccelerometerReadingChangedEventArgs *args)
{
    ComPtr<Sensors::IAccelerometerReading> reading;
    HRESULT hr = args->get_Reading(&reading);
    DOUBLE x, y, z;
    hr = reading->get_AccelerationX(&x);
    hr = reading->get_AccelerationY(&y);
    hr = reading->get_AccelerationZ(&z);
    d->reading[0] = x * 10;
    d->reading[1] = y * 10;
    d->reading[2] = z * 10;
    emit readingChanged();
    return S_OK;
}
