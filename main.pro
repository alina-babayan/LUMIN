
    QT += quick network charts qml gui

    CONFIG += c++17

    TARGET = MyQtApp
    TEMPLATE = app
    HEADERS += \
        ApiEndPoints.h \
        QmlTypes.h \
        TokenStorage.h \
        apiclient.h

    SOURCES += \
        QmlTypes.cpp \
        TokenStorage.cpp \
        apiclient.cpp \
        main.cpp

    RESOURCES += \
        qml.qrc
