cmake_minimum_required(VERSION 3.0)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

if(CMAKE_VERSION VERSION_LESS "3.7.0")
    set(CMAKE_INCLUDE_CURRENT_DIR ON)
endif()

set(QML_PATH ../../QML)

find_package(Qt5 COMPONENTS Qml Quick REQUIRED)
find_package(Qt5QuickCompiler)

qtquick_compiler_add_resources(RESOURCES ${QML_PATH}/qml.qrc)

add_executable(Client
	${QML_PATH}/qml.qrc
	${QML_PATH}/views/main.qml

    main.cpp
)

qt5_use_modules(Client Qml Quick)

target_link_libraries(Client 
    Qt5::Qml
    Qt5::Quick
)
