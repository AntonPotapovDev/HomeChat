#include <QGuiApplication>
#include <QQuickView>

int main(int argc, char** argv) {
	QGuiApplication app(argc, argv);

	QQuickView view(QUrl("qrc:/views/main.qml"));
	view.setMinimumSize({ 800, 600 });
	view.setResizeMode(QQuickView::ResizeMode::SizeRootObjectToView);
	view.show();

	return app.exec();
}
