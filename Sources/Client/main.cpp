#include <QGuiApplication>
#include <QQuickView>

#include <QMLTypes.h>

void registerTypes();

int main(int argc, char** argv) {
	QGuiApplication app(argc, argv);

	QQuickView view(QUrl("qrc:/views/main.qml"));
	view.setMinimumSize({ 800, 600 });
	view.setResizeMode(QQuickView::ResizeMode::SizeRootObjectToView);
	view.show();

	return app.exec();
}

void registerTypes() {
	std::string modul_name = "HomeChat";
	qmlRegisterType<ServerAddressProvider>(modul_name.c_str(), 1, 0, "ServerAddress");
}
