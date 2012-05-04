#ifndef SCREENMANAGER_H
#define SCREENMANAGER_H

#include <QGraphicsObject>
#include <QSettings>

class ScreenManager
{
public:
    static void init(QGraphicsObject *wind);
    static void restoreIcons();
    static void displayTime(QString timeStr);
    static void setMainTextCentered(bool isCentered);
    static void setPopupTextCentered(bool isCentered);
    static void displayEHUText(QString text);
    static void displayPopupText(QString text);
    static void switchOffIcons();
    static void switchASIcon(bool sw);
    static void switchRDSIcon(bool sw);
    static void switchCDinIcon(bool sw);
    static void switchTPIcon(int sw);
    static void switchMP3Icon(bool sw);
    static void switchRDMIcon(bool sw);

private:
    static QGraphicsObject *window;
    static bool initialized;
};

#endif // SCREENMANAGER_H
