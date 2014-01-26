#include "momentmanager.h"

#include <QVector3D>
#include <QPointer>

class MomentPrivate
{
public:
    MomentPrivate() : on(false), start(0), end(0), twerkGoal(0), twerkPolicy(0),
        peakTwerkCount(0), twerkCount(0), twerkForce(0), amplitude(0), samples(0), onPeak(false) { }
    bool on;
    int start;
    int end;
    int twerkGoal;
    int twerkPolicy;

    // Accumulated twerk data
    int peakTwerkCount;
    int twerkCount;
    qreal twerkForce;
    qreal amplitude;
    int samples;

    QVector3D previousValue;

    bool onPeak;

    QPointer<MomentManager> manager;
};

Moment::Moment()
    : QObject(), d(new MomentPrivate)
{
}

Moment::~Moment()
{
}

bool Moment::on() const
{
    return d->on;
}

void Moment::setOn(bool on)
{
    if (on == d->on)
        return;

    d->on = on;
    emit onChanged();

    if (d->on) {
        qDebug("[Moment] start: %d, end: %d, set to on: %d, policy is %d", d->start, d->end, d->on, d->twerkPolicy);
        // connect to sensor reading signal...
        connect(d->manager->sensor(), SIGNAL(readingChanged()), this, SLOT(onSensorReading()));
    }

    if (!d->on) {
        qDebug("[Moment] ended: Twerk count: %d, Accumulated Twerk Force: %f", d->twerkCount, d->twerkForce);
        d->manager->sensor()->disconnect(this);

        // Case 0:
        // We don't care about your twerking
        if (d->twerkPolicy == 0)
            return;

        // Case 1:
        // We want to see you shake your ass
        if (d->twerkPolicy == 1) {
            qDebug("setting score %d", d->manager->score() + d->twerkCount);
            d->manager->setScore(d->manager->score() + d->twerkCount);
            d->manager->setPeakScore(d->manager->peakScore() + d->peakTwerkCount);
            return;
        }

        // Case 2:
        // Hold your ass still
        // Play boos
        d->manager->setNegativeScore(d->manager->negativeScore() + d->twerkCount);
        d->manager->setNegativePeakScore(d->manager->peakScore() + d->peakTwerkCount);
    }
}

int Moment::start() const
{
    return d->start;
}

void Moment::setStart(int start)
{
    if (start == d->start)
        return;

    d->start = start;
    emit startChanged();
}

int Moment::end() const
{
    return d->end;
}

void Moment::setEnd(int end)
{
    if (end == d->end)
        return;

    d->end = end;
    emit endChanged();
}

int Moment::twerkGoal() const
{
    return d->twerkGoal;
}

void Moment::setTwerkGoal(int twerkGoal)
{
    if (twerkGoal == d->twerkGoal)
        return;

    d->twerkGoal = twerkGoal;
    emit twerkGoalChanged();
}

int Moment::twerkPolicy() const
{
    return d->twerkPolicy;
}

void Moment::setTwerkPolicy(int twerkPolicy)
{
    if (twerkPolicy == d->twerkPolicy)
        return;

    d->twerkPolicy = twerkPolicy;
    emit twerkPolicyChanged();
}

void Moment::onSensorReading()
{
    QVariant reading = d->manager->sensor()->property("reading");
    QVector3D value;
    if (QObject *object = reading.value<QObject *>()) {
        value[0] = object->property("x").toFloat();
        value[1] = object->property("y").toFloat();
        value[2] = object->property("z").toFloat();
    } else {
        value = reading.value<QVector3D>();
    }

    float valueLength = value.length();
    float previousLength = d->previousValue.length();

    // Dot twerk
    if (QVector3D::dotProduct(value, d->previousValue) < 0) {
        d->twerkForce += d->amplitude; //Somehow multiply this by the sampling interval?
        ++d->twerkCount;
        emit d->manager->moved();
        qDebug("[Moment] Classing Twerk");
    }

    // Cross twerk
    int cross = QVector3D::crossProduct(value, d->previousValue).length();
    if (cross > 0.25)
        qDebug("[Moment] Cross Twerk");

    // Amplitude twerk
    if (valueLength > previousLength) {
        if (valueLength > 12) {
            if (!d->onPeak)
                d->onPeak = true;
        }
    }
    if (valueLength < previousLength) {
        if (valueLength < 12) {
            if (d->onPeak) {
                qDebug("[Moment] Amplitude Twerk");
                d->onPeak = false;
                ++d->peakTwerkCount;
            }
        }
    }
    d->previousValue = value;
    d->amplitude += valueLength;
    ++d->samples;
}

class MomentManagerPrivate
{
public:
    MomentManagerPrivate() : score(0), peakScore(0), negativeScore(0), negativePeakScore(0) { }
    QList<Moment *> moments;
    QPointer<QObject> sensor;
    int score;
    int peakScore;
    int negativeScore;
    int negativePeakScore;
};

void MomentManager::momentAppend(QQmlListProperty<Moment> *property, Moment *moment)
{
    moment->d->manager = static_cast<MomentManager *>(property->object);
    static_cast<MomentManagerPrivate *>(property->data)->moments.append(moment);
}

int MomentManager::momentCount(QQmlListProperty<Moment> *property)
{
    return static_cast<MomentManagerPrivate *>(property->data)->moments.count();
}

Moment *MomentManager::momentAt(QQmlListProperty<Moment> *property, int index)
{
    return static_cast<MomentManagerPrivate *>(property->data)->moments.at(index);
}

void MomentManager::momentClear(QQmlListProperty<Moment> *property)
{
    static_cast<MomentManagerPrivate *>(property->data)->moments.clear();
}

MomentManager::MomentManager()
    : QObject(), d(new MomentManagerPrivate)
{
}

MomentManager::~MomentManager()
{
}

QObject *MomentManager::sensor() const
{
    return d->sensor.data();
}

void MomentManager::setSensor(QObject *sensor)
{
    if (sensor == d->sensor)
        return;

    d->sensor = sensor;
    emit sensorChanged();
}

QQmlListProperty<Moment> MomentManager::moments()
{
    return QQmlListProperty<Moment>(this, d.data(), &MomentManager::momentAppend, &MomentManager::momentCount,
                                    &MomentManager::momentAt, &MomentManager::momentClear);
}

int MomentManager::score() const
{
    return d->score;
}

void MomentManager::setScore(int score)
{
    if (score == d->score)
        return;

    d->score = score;
    emit scoreChanged();
}

int MomentManager::peakScore() const
{
    return d->peakScore;
}

void MomentManager::setPeakScore(int peakScore)
{
    if (peakScore == d->peakScore)
        return;

    d->peakScore = peakScore;
    emit peakScoreChanged();
}

int MomentManager::negativeScore() const
{
    return d->negativeScore;
}

void MomentManager::setNegativeScore(int negativeScore)
{
    if (negativeScore == d->negativeScore)
        return;

    d->negativeScore = negativeScore;
    emit negativeScoreChanged();
}

int MomentManager::negativePeakScore() const
{
    return d->negativePeakScore;
}

void MomentManager::setNegativePeakScore(int negativePeakScore)
{
    if (negativePeakScore == d->negativePeakScore)
        return;

    d->negativePeakScore = negativePeakScore;
    emit negativePeakScoreChanged();
}

void MomentManager::resetScore()
{
    d->score = d->peakScore /*= d->negativeScore = d->negativePeakScore*/ = 0;
}
