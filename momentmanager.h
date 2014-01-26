#ifndef MOMENTMANAGER_H
#define MOMENTMANAGER_H

#include <QObject>
#include <QQmlListProperty>
#include <QScopedPointer>

class MomentPrivate;
class Moment : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool on READ on WRITE setOn NOTIFY onChanged)
    Q_PROPERTY(int start READ start WRITE setStart NOTIFY startChanged)
    Q_PROPERTY(int end READ end WRITE setEnd NOTIFY endChanged)
    Q_PROPERTY(int twerkGoal READ twerkGoal WRITE setTwerkGoal NOTIFY twerkGoalChanged)
    Q_PROPERTY(int twerkPolicy READ twerkPolicy WRITE setTwerkPolicy NOTIFY twerkPolicyChanged)
public:
    explicit Moment();
    ~Moment();

    bool on() const;
    void setOn(bool on);

    int start() const;
    void setStart(int start);

    int end() const;
    void setEnd(int end);

    int twerkGoal() const;
    void setTwerkGoal(int twerkGoal);

    int twerkPolicy() const;
    void setTwerkPolicy(int twerkPolicy);

signals:
    void onChanged();
    void startChanged();
    void endChanged();
    void twerkGoalChanged();
    void twerkPolicyChanged();

private slots:
    void onSensorReading();

private:
    QScopedPointer<MomentPrivate> d;
    friend class MomentManager;
};

class MomentManagerPrivate;
class MomentManager : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QQmlListProperty<Moment> moments READ moments CONSTANT)
    Q_PROPERTY(QObject *sensor READ sensor WRITE setSensor NOTIFY sensorChanged)
    Q_PROPERTY(int score READ score NOTIFY scoreChanged)
    Q_PROPERTY(int peakScore READ peakScore NOTIFY peakScoreChanged)
    Q_PROPERTY(int negativeScore READ negativeScore NOTIFY negativeScoreChanged)
    Q_PROPERTY(int negativePeakScore READ negativePeakScore NOTIFY negativePeakScoreChanged)
public:
    explicit MomentManager();
    ~MomentManager();

    QQmlListProperty<Moment> moments();

    QObject *sensor() const;
    void setSensor(QObject *sensor);

    int score() const;
    int peakScore() const;
    int negativeScore() const;
    int negativePeakScore() const;
    Q_INVOKABLE void resetScore();

signals:
    void sensorChanged();
    void scoreChanged();
    void peakScoreChanged();
    void negativeScoreChanged();
    void negativePeakScoreChanged();
    void moved();

private:
    void setScore(int score);
    void setPeakScore(int peakScore);
    void setNegativeScore(int score);
    void setNegativePeakScore(int peakScore);

    static void momentAppend(QQmlListProperty<Moment> *property, Moment *moment);
    static int momentCount(QQmlListProperty<Moment> *property);
    static Moment *momentAt(QQmlListProperty<Moment> *property, int index);
    static void momentClear(QQmlListProperty<Moment> *property);

    QScopedPointer<MomentManagerPrivate> d;
    friend class Moment;
};

#endif // MOMENTMANAGER_H
