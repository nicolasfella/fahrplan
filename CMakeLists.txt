cmake_minimum_required(VERSION 3.13)

project(Fahrplan)

find_package(Qt5 REQUIRED COMPONENTS Core Network Xml Quick Concurrent Script)
find_package(ZLIB)

add_executable(fahrplan2
    src/main.cpp
    src/parser/parser_hafasxml.cpp
    src/parser/parser_abstract.cpp
    src/parser/parser_definitions.cpp
    src/parser/parser_xmlsbbch.cpp
    src/parser/parser_xmlrejseplanendk.cpp
    src/parser/parser_xmloebbat.cpp
    src/parser/parser_xmlvasttrafikse.cpp
    src/fahrplan.cpp
    src/fahrplan_backend_manager.cpp
    src/parser/parser_mobilebahnde.cpp
    src/calendarthreadwrapper.cpp
    src/parser/parser_xmlnri.cpp
    src/parser/parser_hafasbinary.cpp
    src/fahrplan_parser_thread.cpp
    src/fahrplan_calendar_manager.cpp
    src/models/stationslistmodel.cpp
    src/models/favorites.cpp
    src/models/stationsearchresults.cpp
    src/models/timetable.cpp
    src/models/trainrestrictions.cpp
    src/parser/parser_ptvvicgovau.cpp
    src/parser/parser_efa.cpp
    src/parser/parser_ireland_efa.cpp
    src/parser/parser_sydney_efa.cpp
    src/parser/parser_sf_bay_efa.cpp
    src/parser/parser_dubai_efa.cpp
    src/parser/parser_ninetwo.cpp
    src/parser/parser_munich_efa.cpp
    src/parser/parser_salzburg_efa.cpp
    src/parser/parser_resrobot.cpp
    src/parser/parser_finland_matka.cpp
    src/models/backends.cpp

    3rdparty/gauss-kruger-cpp/gausskruger.cpp

    3rdparty/qcustomnetworkreply/qcustomnetworkreply.cpp
    3rdparty/QtCUrl/QtCUrl.cpp
)

target_include_directories(fahrplan2 PRIVATE ${CMAKE_SOURCE_DIR} ${CMAKE_SOURCE_DIR}/src)

target_compile_definitions(fahrplan2 PRIVATE BUILD_FOR_QT5 BUILD_FOR_UBUNTU FAHRPLAN_SETTINGS_NAMESPACE="fp" FAHRPLAN_VERSION="1")

target_link_libraries(fahrplan2 Qt5::Core Qt5::Gui Qt5::Network Qt5::Xml Qt5::Concurrent Qt5::Quick Qt5::Script ZLIB::ZLIB)
