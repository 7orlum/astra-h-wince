#include <QtGui/QApplication>
#include "qmlapplicationviewer.h"
#include "astracangui.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QScopedPointer<QApplication> app(createApplication(argc, argv));

    QCoreApplication::setOrganizationName("AstraSoft");
    QCoreApplication::setApplicationName("AstraCanGUI");

    QmlApplicationViewer viewer;
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    viewer.setSource(QUrl("qrc:/qml/AstraCANGUI/Main.qml"));
    viewer.showExpanded();

    new AstraCanGui(viewer.rootObject(), 0);

    return app->exec();
}
