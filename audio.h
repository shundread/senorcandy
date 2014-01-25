#ifndef AUDIO_H
#define AUDIO_H

#include <QObject>
#include <QString>
#include <QUrl>
#include <QScopedPointer>

class AudioPrivate;
class Audio : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QUrl source READ source WRITE setSource NOTIFY sourceChanged)
    Q_PROPERTY(int position READ position /*WRITE setPosition*/ NOTIFY positionChanged)
public:
    explicit Audio(QObject *parent = 0);
    ~Audio();

    QUrl source() const;
    void setSource(const QUrl &source);

    int position() const;

    Q_INVOKABLE void play();

signals:
    void sourceChanged();
    void positionChanged();

private:
    QScopedPointer<AudioPrivate> d;
};

#endif // AUDIO_H
