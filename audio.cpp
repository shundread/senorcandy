#include "audio.h"

#include <mfapi.h>
#include <mfmediaengine.h>

#include <QCoreApplication>
#include <QDir>

#include <wrl.h>
using namespace Microsoft::WRL;


class AudioPrivate : public RuntimeClass<RuntimeClassFlags<ClassicCom>, IMFMediaEngineNotify>
{
public:
    HRESULT __stdcall EventNotify(DWORD event, DWORD_PTR param1, DWORD param2)
    {
        return S_OK;
    }

    ComPtr<IMFMediaEngine> player;
    ComPtr<IMFAttributes> attributes;

    QUrl source;
};

Audio::Audio(QObject *parent) :
    QObject(parent), d(Make<AudioPrivate>().Detach())
{
    HRESULT hr = MFCreateAttributes(&d->attributes, 1);
    d->attributes->SetUnknown(MF_MEDIA_ENGINE_CALLBACK, d.data());
    ComPtr<IMFMediaEngineClassFactory> factory;
    hr = CoCreateInstance(CLSID_MFMediaEngineClassFactory, nullptr, CLSCTX_ALL, IID_PPV_ARGS(&factory));
    hr = factory->CreateInstance(0, d->attributes.Get(), &d->player);
    //hr = d->player->SetLoop(true);
}

Audio::~Audio()
{
}

QUrl Audio::source() const
{
    return d->source;
}

void Audio::setSource(const QUrl &source)
{
    d->source = source;
    QString url;
    if (source.isLocalFile())
        url = source.toLocalFile();
    else // hack. needs a qrc handler
        url = QDir::toNativeSeparators(QCoreApplication::applicationDirPath()
                                       + source.toString(QUrl::RemoveScheme));
    HRESULT hr = d->player->SetSource((BSTR)url.utf16());
    emit sourceChanged();
}

int Audio::position() const
{
    return 0;
}

void Audio::play()
{
    HRESULT hr = d->player->Play();
}

void Audio::stop()
{
    HRESULT hr = d->player->Shutdown();
}
