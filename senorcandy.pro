QT += core gui quick qml

android: QT += multimedia sensors

SOURCES = main.cpp \
    momentmanager.cpp

HEADERS += \
    momentmanager.h

winrt {
    HEADERS += accelerometer.h audio.h
    SOURCES += accelerometer.cpp audio.cpp
    LIBS += MFPlat.lib
    winphone: WINRT_MANIFEST.capabilities += ID_CAP_SENSORS ID_CAP_MEDIALIB_PLAYBACK
}

OTHER_FILES = \
    main.qml \
    Button.qml \
    TwerkEngine.qml \
    Candy.qml

fonts.files = fonts/*
fonts.path = /fonts
DEPLOYMENT += fonts

audio.files = audio/*.wav
audio.path = /audio
DEPLOYMENT += audio

RESOURCES += \
    resources.qrc
