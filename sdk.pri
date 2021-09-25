QT += xml printsupport
INCLUDEPATH += $$PWD/display
DEPENDPATH += $$PWD/display

SOURCES += $$PWD/display/dpihandling.cpp \
           $$PWD/display/displaysettings.cpp \
           $$PWD/display/selectionprint.cpp

HEADERS += $$PWD/display/dpihandling.h \
           $$PWD/display/displaysettings.h \
           $$PWD/display/selectionprint.h


RESOURCES +=  $$PWD/widgets/widgets.qrc \
              $$PWD/assets/sdkassets.qrc




