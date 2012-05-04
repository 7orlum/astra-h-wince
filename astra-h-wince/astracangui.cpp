#include <QtGui>
#include "astracangui.h"

AstraCanGui::AstraCanGui(QGraphicsObject *wind, QObject *parent) :
    QObject(parent)
{
    ScreenManager::init(wind);
    ScreenManager::restoreIcons();
    timer = new QTimer(this);
    connect(timer, SIGNAL(timeout()), this, SLOT(showTime()));
    timer->start(1000);
    showTime();

    Decoder::init();

    QTimer *generator = new QTimer(this);
    connect(generator, SIGNAL(timeout()), this, SLOT(generateMessage()));
    generator->start(2000);
}

void AstraCanGui::showTime()
{
    QTime time = QTime::currentTime();
    ScreenManager::displayTime(time.toString("hh:mm"));
    int ms = (60 - time.second()) * 1000;
    timer->setInterval(ms);
}

void AstraCanGui::generateMessage()
{
    unsigned char packet1[] = {
                    0x06, 0xC1,             // ID - info from EHU
                    0xC0,                   // Block type - current station text
                    0x00, 0x1F,             // Block length
                    0x03,                   // Not decoded
                    0x10,                   // Text on main screen
                    0x0E,                   // Text length
                    0x00, 0x1B,             // Text start
                    0x00, 0x5B, 0x00, 0x66,
                    0x00, 0x53, 0x00, 0x5F,
                    0x00, 0x67, 0x00, 0x6D,
                    0x00, 0x1B, 0x00, 0x5B,
                    0x00, 0x63, 0x00, 0x6D,
                    0x00, 0x41, 0x00, 0x75,
                    0x00, 0x78 };           // Text end
    unsigned char packet2[] = {
                    0x06, 0xC1,             // ID - info from EHU
                    0x40,                   // Block type - change station text
                    0x00, 0x6D,             // Block length
                    0x03,                   // Not decoded
                    0x10,                   // Text1 - on main screen
                    0x1A,                   // Text1 length
                    0x00, 0x1B,             // Text1 start
                    0x00, 0x5B, 0x00, 0x66,
                    0x00, 0x53, 0x00, 0x5F,
                    0x00, 0x64, 0x00, 0x6D,
                    0x00, 0x46, 0x00, 0x4D,
                    0x27, 0x81, 0x00, 0x1B,
                    0x00, 0x5B, 0x00, 0x66,
                    0x00, 0x53, 0x00, 0x5F,
                    0x00, 0x67, 0x00, 0x6D,
                    0x00, 0x20, 0x00, 0x20,
                    0x00, 0x20, 0x00, 0x20,
                    0x00, 0x44, 0x00, 0x46,
                    0x00, 0x4D, 0x00, 0x20,
                    0x00, 0x20,             // Text1 end
                    0x90,                   // Text2 - on popup screen
                    0x1A,                   // Text 2 length
                    0x00, 0x1B, 0x00, 0x5B, // Text2 start
                    0x00, 0x66, 0x00, 0x53,
                    0x00, 0x5F, 0x00, 0x64,
                    0x00, 0x6D, 0x00, 0x46,
                    0x00, 0x4D, 0x27, 0x81,
                    0x00, 0x1B, 0x00, 0x5B,
                    0x00, 0x66, 0x00, 0x53,
                    0x00, 0x5F, 0x00, 0x67,
                    0x00, 0x6D, 0x00, 0x20,
                    0x00, 0x20, 0x00, 0x20,
                    0x00, 0x20, 0x00, 0x44,
                    0x00, 0x46, 0x00, 0x4D,
                    0x00, 0x20, 0x00, 0x20 }; // Text2 end
    unsigned char packet3[] = {
                    0x06, 0xC1,             // ID - info from EHU
                    0x50,                   // Block type - icons state change
                    0x00, 0x0D,             // Block length
                    0x03,                   // Not decoded
                    0x01, 0x01, 0x01,       // AS icon will be on
                    0x01, 0x02, 0x02,       // RDS icon will be on
                    0x02, 0x01, 0x01,       // CDin icon will be on
                    0x03, 0x80, 0x02 };     // TP icon will be in state: '[ ]'
                    //0x80, 0x01,           // MP3 icon will be off
                    //0x83, 0x01 ;         // RDM icon will be off
    unsigned char packet4[] = {
                    0x06, 0xC1,             // ID - info from EHU
                    0x50,                   // Block type - icons state change
                    0x00, 0x08,             // Block length
                    0x03,                   // Not decoded
                    //0x01, 0x01, 0x01,     // AS icon will be off
                    //0x01, 0x02, 0x02,     // RDS icon will be off
                    0x02, 0x01, 0x01,       // CDin icon will be on
                    //0x03, 0x80, 0x01,     // TP icon will be off
                    0x80, 0x01,             // MP3 icon will be on
                    0x83, 0x01 };           // RDM icon will be on
    qsrand(QTime(0,0,0).secsTo(QTime::currentTime()));
    int r = qrand()%4+1;
    switch (r) {
    case 1:
        Decoder::decodeMessage(packet1);
        break;
    case 2:
        Decoder::decodeMessage(packet2);
        break;
    case 3:
        Decoder::decodeMessage(packet3);
        break;
    case 4:
        Decoder::decodeMessage(packet4);
        break;
    }
}

