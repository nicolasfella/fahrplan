# Define Name
APP_NAME = Fahrplan

# Define Version
VERSION = 2.0.32-2

MOC_DIR = tmp
UI_DIR = tmp
OBJECTS_DIR = tmp
RCC_DIR = tmp

DEFINES += FAHRPLAN_VERSION=\\\"1\\\"
DEFINES += FAHRPLAN_SETTINGS_NAMESPACE=\\\"fp\\\"

ubuntu {
    APP_ID = openstore.fahrplan2
    MAINTAINER_UBUNTU = Michael Stevens <mail@michael-stevens.de>
    DEFINES += FAHRPLAN_VERSION=\\\"$$VERSION\\\"
    DEFINES += FAHRPLAN_SETTINGS_NAMESPACE=\\\"$$APP_ID\\\"
}

QT += network xml

QT += quick qml concurrent
DEFINES += BUILD_FOR_QT5

blackberry: QT += opengl
maemo5:QT += maemo5

!maemo5:!blackberry: CONFIG += mobility

!blackberry: MOBILITY += location organizer

TRANSLATIONS += \
    translations/fahrplan_ar.ts \
    translations/fahrplan_ca.ts \
    translations/fahrplan_de.ts \
    translations/fahrplan_el.ts \
    translations/fahrplan_en.ts \
    translations/fahrplan_es.ts \
    translations/fahrplan_fa_IR.ts \
    translations/fahrplan_fr.ts \
    translations/fahrplan_hu.ts \
    translations/fahrplan_nb.ts \
    translations/fahrplan_nl_NL.ts \
    translations/fahrplan_pl.ts \
    translations/fahrplan_ro_RO.ts \
    translations/fahrplan_ru.ts \
    translations/fahrplan_sl_SI.ts \
    translations/fahrplan_sv_SE.ts \
    translations/fahrplan_uk.ts
CODECFORTR = UTF-8

OTHER_FILES += \
    data/fahrplan2.svg \
    data/fahrplan2_64.png \
    data/fahrplan2_80.png \
    date/fahrplan2_150.png \
    src/gui/about.js \
    src/gui/ubuntu/components/CustomListItem.qml

RESOURCES += \
    translations_res.qrc

INCLUDEPATH += src
# Zlib todo for other systems ugly hack
unix:!symbian: LIBS += -lz

HEADERS += \
    src/parser/parser_hafasxml.h \
    src/parser/parser_abstract.h \
    src/parser/parser_definitions.h \
    src/parser/parser_xmlsbbch.h \
    src/parser/parser_xmlrejseplanendk.h \
    src/parser/parser_xmloebbat.h \
    src/parser/parser_xmlvasttrafikse.h \
    src/fahrplan.h \
    src/fahrplan_backend_manager.h \
    src/parser/parser_mobilebahnde.h \
    src/calendarthreadwrapper.h \
    src/parser/parser_xmlnri.h \
    src/parser/parser_hafasbinary.h \
    src/fahrplan_parser_thread.h \
    src/fahrplan_calendar_manager.h \
    src/models/stationslistmodel.h \
    src/models/favorites.h \
    src/models/stationsearchresults.h \
    src/models/timetable.h \
    src/models/trainrestrictions.h \
    src/parser/parser_ptvvicgovau.h \
    src/parser/parser_efa.h \
    src/parser/parser_ireland_efa.h \
    src/parser/parser_sydney_efa.h \
    src/parser/parser_sf_bay_efa.h \
    src/parser/parser_dubai_efa.h \
    src/parser/parser_ninetwo.h \
    src/parser/parser_munich_efa.h \
    src/parser/parser_salzburg_efa.h \
    src/parser/parser_resrobot.h \
    src/parser/parser_finland_matka.h \
    src/models/backends.h

SOURCES += src/main.cpp \
    src/parser/parser_hafasxml.cpp \
    src/parser/parser_abstract.cpp \
    src/parser/parser_definitions.cpp \
    src/parser/parser_xmlsbbch.cpp \
    src/parser/parser_xmlrejseplanendk.cpp \
    src/parser/parser_xmloebbat.cpp \
    src/parser/parser_xmlvasttrafikse.cpp \
    src/fahrplan.cpp \
    src/fahrplan_backend_manager.cpp \
    src/parser/parser_mobilebahnde.cpp \
    src/calendarthreadwrapper.cpp \
    src/parser/parser_xmlnri.cpp \
    src/parser/parser_hafasbinary.cpp \
    src/fahrplan_parser_thread.cpp \
    src/fahrplan_calendar_manager.cpp \
    src/models/stationslistmodel.cpp \
    src/models/favorites.cpp \
    src/models/stationsearchresults.cpp \
    src/models/timetable.cpp \
    src/models/trainrestrictions.cpp \
    src/parser/parser_ptvvicgovau.cpp \
    src/parser/parser_efa.cpp \
    src/parser/parser_ireland_efa.cpp \
    src/parser/parser_sydney_efa.cpp \
    src/parser/parser_sf_bay_efa.cpp \
    src/parser/parser_dubai_efa.cpp \
    src/parser/parser_ninetwo.cpp \
    src/parser/parser_munich_efa.cpp \
    src/parser/parser_salzburg_efa.cpp \
    src/parser/parser_resrobot.cpp \
    src/parser/parser_finland_matka.cpp \
    src/models/backends.cpp

LIBS += $$PWD/3rdparty/gauss-kruger-cpp/gausskruger.cpp

# This hack is needed for lupdate to pick up texts from QML files
translate_hack {
    SOURCES += \
        src/gui/fremantle/*.qml \
        src/gui/fremantle/components/*.qml \
        src/gui/fremantle/hildon/*.qml \
        src/gui/harmattan/*.qml \
        src/gui/harmattan/components/*.qml \
        src/gui/harmattan/delegates/*.qml \
        src/gui/harmattan/pages/*.qml \
        src/gui/symbian/*.qml \
        src/gui/symbian/components/*.qml \
        src/gui/symbian/delegates/*.qml \
        src/gui/symbian/pages/*.qml \
        src/gui/ubuntu/*.qml \
        src/gui/ubuntu/components/*.qml \
        src/gui/sailfishos/*.qml  \
        src/gui/sailfishos/components/*.qml \
        src/gui/sailfishos/delegates/*.qml \
        src/gui/sailfishos/pages/*.qml \
        src/gui/about.js
}

ubuntu: {
    message("Ubuntu build")
    RESOURCES += ubuntu_res.qrc

    HEADERS += \
        3rdparty/qcustomnetworkreply/qcustomnetworkreply.h \
        3rdparty/QtCUrl/QtCUrl.h

    SOURCES += \
        3rdparty/qcustomnetworkreply/qcustomnetworkreply.cpp \
        3rdparty/QtCUrl/QtCUrl.cpp

    LIBS += -lcurl
	
    OTHER_FILES += \
        src/gui/ubuntu/MainPage.qml \
        src/gui/ubuntu/JourneyResultsPage.qml \
        src/gui/ubuntu/JourneyDetailsResultsPage.qml \
        src/gui/ubuntu/TimeTableResultsPage.qml \
        src/gui/ubuntu/main.qml \
        src/gui/ubuntu/components/StationSelect.qml \
        src/gui/ubuntu/components/DatePicker.qml \
        src/gui/ubuntu/components/TimePicker.qml \
        src/gui/ubuntu/AboutPage.qml \
        src/gui/ubuntu/SettingsPage.qml \
        data/fahrplan2_ubuntu.desktop \
        qtc_packaging/ubuntu/changelog \
        qtc_packaging/ubuntu/compat \
        qtc_packaging/ubuntu/control \
        qtc_packaging/ubuntu/copyright \
        qtc_packaging/ubuntu/rules \
        qtc_packaging/ubuntu/source/format

    DEFINES += BUILD_FOR_UBUNTU
}


win32|unix:!simulator:!maemo5:!contains(MEEGO_EDITION,harmattan):!symbian:!exists("/usr/include/sailfishapp/sailfishapp.h"):!ubuntu:!blackberry {
    QT += widgets
    DEFINES += BUILD_FOR_DESKTOP
    RESOURCES += desktop_res.qrc
    SOURCES += src/gui/desktop-test/mainwindow.cpp
    HEADERS += src/gui/desktop-test/mainwindow.h
    FORMS += src/gui/desktop-test/mainwindow.ui
}



# Please do not modify the following two lines. Required for deployment.
# include(deployment.pri)
# qtcAddDeployment()

# We need to generate translations before building.
# Either way, translations_res.qrc won't compile.
translations.name = Translations
translations.input = TRANSLATIONS
translations.output = $$_PRO_FILE_PWD_/translations/${QMAKE_FILE_BASE}.qm
freebsd-* {
    translations.commands = $$[QT_INSTALL_BINS]/lrelease-qt$${QT_MAJOR_VERSION} ${QMAKE_FILE_IN}
} else {
    translations.commands = $$[QT_INSTALL_BINS]/lrelease ${QMAKE_FILE_IN}
}
translations.CONFIG = no_link
QMAKE_EXTRA_COMPILERS += translations
PRE_TARGETDEPS += compiler_translations_make_all

