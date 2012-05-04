#include "screenmanager.h"

QGraphicsObject *ScreenManager::window;
bool ScreenManager::initialized = false;

void ScreenManager::init(QGraphicsObject *wind)
{
    if (initialized)
        return;
    window = wind;
    initialized = true;
}

void ScreenManager::restoreIcons()
{
    if (!initialized)
        return;

    QSettings settings;
    settings.beginGroup("icons");
    window->setProperty("asIconOn", settings.value("asIcon", false).toBool());
    window->setProperty("rdsIconOn", settings.value("rdsIcon", false).toBool());
    window->setProperty("cdIconOn", settings.value("cdIcon", false).toBool());
    window->setProperty("tpIconStatus", settings.value("tpIcon", 0).toInt());
    window->setProperty("mp3IconOn", settings.value("mp3Icon", false).toBool());
    window->setProperty("rdmIconOn", settings.value("rdmIcon", false).toBool());
    settings.endGroup();
}

void ScreenManager::displayTime(QString timeStr)
{
    if (!initialized)
        return;
    window->setProperty("time", timeStr);
}

void ScreenManager::setMainTextCentered(bool isCentered)
{
    if (!initialized)
        return;
    window->setProperty("alignMainTextCenter", isCentered);
}

void ScreenManager::setPopupTextCentered(bool isCentered)
{
    if (!initialized)
        return;
    window->setProperty("alignPopupTextCenter", isCentered);
}

void ScreenManager::displayEHUText(QString text)
{
    if (!initialized)
        return;
    window->setProperty("ehuLabelText", text);
}

void ScreenManager::displayPopupText(QString text)
{
    if (!initialized)
        return;
    window->setProperty("mainPopupText", text);
    window->setProperty("mainPopupTextVisible", true);
}

void ScreenManager::switchOffIcons()
{
    if (!initialized)
        return;
    switchASIcon(false);
    switchRDSIcon(false);
    switchCDinIcon(false);
    switchTPIcon(0);
    switchMP3Icon(false);
    switchRDMIcon(false);
}

void ScreenManager::switchASIcon(bool sw)
{
    if (!initialized)
        return;
    window->setProperty("asIconOn", sw);

    QSettings settings;
    settings.setValue("icons/asIcon", sw);
}

void ScreenManager::switchRDSIcon(bool sw)
{
    if (!initialized)
        return;
    window->setProperty("rdsIconOn", sw);

    QSettings settings;
    settings.setValue("icons/rdsIcon", sw);
}

void ScreenManager::switchCDinIcon(bool sw)
{
    if (!initialized)
        return;
    window->setProperty("cdIconOn", sw);

    QSettings settings;
    settings.setValue("icons/cdIcon", sw);
}

void ScreenManager::switchTPIcon(int sw)
{
    if (!initialized)
        return;
    window->setProperty("tpIconStatus", sw);

    QSettings settings;
    settings.setValue("icons/tpIcon", sw);
}

void ScreenManager::switchMP3Icon(bool sw)
{
    if (!initialized)
        return;
    window->setProperty("mp3IconOn", sw);

    QSettings settings;
    settings.setValue("icons/mp3Icon", sw);
}

void ScreenManager::switchRDMIcon(bool sw)
{
    if (!initialized)
        return;
    window->setProperty("rdmIconOn", sw);

    QSettings settings;
    settings.setValue("icons/rdmIcon", sw);
}
