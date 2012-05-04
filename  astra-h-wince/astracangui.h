#ifndef SYSTEMTIME_H
#define SYSTEMTIME_H

#include <QObject>
#include <QGraphicsObject>
#include "decoder.h"
#include "screenmanager.h"

class AstraCanGui : public QObject
{
    Q_OBJECT
public:
    AstraCanGui(QGraphicsObject *wind, QObject *parent = 0);
    
signals:
    
private slots:
    void showTime();
    void generateMessage();

private:
    QTimer *timer;
};

#endif // SYSTEMTIME_H
