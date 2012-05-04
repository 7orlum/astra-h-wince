#ifndef DECODER_H
#define DECODER_H

#include <QGraphicsObject>
#include "screenmanager.h"

class Decoder
{
public:
    static void init();
    static void decodeMessage(unsigned char *message);

private:
    static QString pseudoFontSequence;
    static QString normalFontSequence;
    static QString centerSequence;
    static bool pseudoGraphicsEnabled;
    static bool initialized;

    static QString decodeText(unsigned char *text, int length, bool isPopupText);
    static void decodeIcons(unsigned char *text, int length);
};

#endif // DECODER_H
