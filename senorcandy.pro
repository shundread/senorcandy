QT += core gui quick sensors qml multimedia

SOURCES = main.cpp

winrt {
    HEADERS += accelerometer.h audio.h
    SOURCES += accelerometer.cpp audio.cpp
    winphone: LIBS += MFMediaEngine.lib MFPlat.lib
    winphone: WINRT_MANIFEST.capabilities += ID_CAP_SENSORS ID_CAP_MEDIALIB_PLAYBACK
}

OTHER_FILES = \
    main.qml \
    Button.qml \
    TwerkEngine.qml

fonts.files = fonts/*
fonts.path = /fonts
DEPLOYMENT += fonts

audio.files = audio/*
audio.path = /audio
DEPLOYMENT += audio

INSTALLS += /audio/track1.wav\
            /audio/airhorn.wav

RESOURCES += \
    resources.qrc
