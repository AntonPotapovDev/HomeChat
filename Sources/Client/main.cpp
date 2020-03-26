#include <QGuiApplication>
#include <QQuickView>

#include <QMLTypes.h>

void registerTypes();

int main(int argc, char** argv) {
	QCoreApplication::setAttribute(Qt::AA_UseOpenGLES);
	QGuiApplication app(argc, argv);

	registerTypes();

	QQuickView view(QUrl("qrc:/views/RegisterView.qml"));
	view.setMinimumSize({ 800, 600 });
	view.setResizeMode(QQuickView::ResizeMode::SizeRootObjectToView);
	view.show();

	return app.exec();
}

void registerTypes() {
	std::string modul_name = "HomeChat";

	//C++ types
	qmlRegisterType<ServerAddressProvider>(modul_name.c_str(), 1, 0, "ServerAddressProvider");

	//Singletones
	qmlRegisterSingletonType(QUrl("qrc:/singletones/Colors.qml"), modul_name.c_str(), 1, 0, "Colors");
	qmlRegisterSingletonType(QUrl("qrc:/singletones/Sizes.qml"), modul_name.c_str(), 1, 0, "Sizes");
	qmlRegisterSingletonType(QUrl("qrc:/singletones/Strings.qml"), modul_name.c_str(), 1, 0, "Strings");
	qmlRegisterSingletonType(QUrl("qrc:/singletones/Fonts.qml"), modul_name.c_str(), 1, 0, "Fonts");
}
