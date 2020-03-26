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
	${QML_PATH}/JS/net_helper.js
	${QML_PATH}/models/MessageModel.qml
	${QML_PATH}/views/MainWindow.qml
	${QML_PATH}/views/ChatView.qml
	${QML_PATH}/views/MessageView.qml
	${QML_PATH}/views/LoginView.qml
	${QML_PATH}/views/RegisterView.qml
	${QML_PATH}/controls/MessageBar.qml
	${QML_PATH}/controls/MessageBox.qml
	${QML_PATH}/controls/CustomField.qml
	${QML_PATH}/controls/CustomButton.qml
	${QML_PATH}/singletones/Sizes.qml
	${QML_PATH}/singletones/Colors.qml
	${QML_PATH}/singletones/Strings.qml
	${QML_PATH}/singletones/Fonts.qml

    main.cpp
	Common/QMLTypes.h
	Net/DatagramListener.cpp Net/DatagramListener.h
	Net/ServerAddressProvider.cpp Net/ServerAddressProvider.h
)

qt5_use_modules(Client Qml Quick)

target_include_directories(Client PUBLIC Common)

target_link_libraries(Client 
    Qt5::Qml
    Qt5::Quick
)
