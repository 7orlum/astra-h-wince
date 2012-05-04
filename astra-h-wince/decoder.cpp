#include "decoder.h"

QString Decoder::centerSequence;
QString Decoder::pseudoFontSequence;
QString Decoder::normalFontSequence;
bool Decoder::pseudoGraphicsEnabled;
bool Decoder::initialized = false;

void Decoder::init()
{
    if (initialized)
        return;
    // construct the escape sequences
    ushort pseudo_font_sequence_chars[] = { 0x00, 0x1B, 0x00, 0x5B, 0x00, 0x66, 0x00, 0x53, 0x00, 0x5F, 0x00, 0x64, 0x00, 0x6D };
    pseudoFontSequence = QString::fromUtf16(pseudo_font_sequence_chars, 14);
    ushort normal_font_sequence_chars[] = { 0x00, 0x1B, 0x00, 0x5B, 0x00, 0x66, 0x00, 0x53, 0x00, 0x5F, 0x00, 0x67, 0x00, 0x6D };
    normalFontSequence = QString::fromUtf16(normal_font_sequence_chars, 14);
    ushort center_sequence_chars[] = { 0x00, 0x1B, 0x00, 0x5B, 0x00, 0x63, 0x00, 0x6D };
    centerSequence = QString::fromUtf16(center_sequence_chars, 8);
    initialized = true;
}

void Decoder::decodeMessage(unsigned char *message)
{
    if (!initialized)
        return;
    if (message[0] == 0x06 && message[1] == 0xC1) // Message from EHU
    {
        if (message[2] == 0xC0) // Text output of current station
        {
            long length = message[3];
            length = length << 8;
            length |= message[4];
            if (length < 5) // Wrong length - return
                return;
            if (message[5] != 0x03) // Wrong sequence - return
                return;
            if (message[6] == 0x10) // Text on main screen
            {
                int text_length = (message[7] * 2);
                if (length - text_length < 3) // Wrong text_length - return
                {
                    return;
                }
                ScreenManager::displayEHUText(decodeText(message + 8, text_length, false));
            }
            else // Wrong text type
            {
                return;
            }
        }
        else if (message[2] == 0x40) // Text output of changed station
        {
            long length = message[3];
            length = length << 8;
            length |= message[4];
            if (length < 7) // Wrong length - return
                return;
            if (message[5] != 0x03) // Wrong sequence - return
                return;
            if (message[6] == 0x10) // Text on main screen
            {
                int text_length = (message[7] * 2);
                QString decoded_main_text = decodeText(message + 8, text_length, false);
                int offset = 8 + text_length;
                if (message[offset] == 0x90) // Text on popup screen
                {
                    int text_length2 = (message[offset + 1] * 2);
                    if ((length - text_length - text_length2) < 5) // Wrong text length - return
                    {
                        return;
                    }
                    QString decoded_popup_text = decodeText(message + offset + 2, text_length2, true);
                    ScreenManager::displayEHUText(decoded_main_text);
                    if (decoded_main_text != decoded_popup_text)
                    {
                        ScreenManager::displayPopupText(decoded_popup_text);
                    }
                }
                else // Wrong text type
                {
                    return;
                }
            }
            else // Wrong text type
            {
                return;
            }
        }
        else if (message[2] == 0x41) // Not decoded yet - do nothing here
        {
            // Do nothing
        }
        else if (message[2] == 0x50) // Icons display
        {
            long length = message[3];
            length = length << 8;
            length |= message[4];
            if (length < 3) // Wrong length - return
                return;
            if (message[5] != 0x03) // Wrong sequence - return
                return;
            decodeIcons(message + 6, length - 1);
        }
    }
}

QString Decoder::decodeText(unsigned char *text, int length, bool isPopupText)
{
    QString result_text = "";

    // Reset centered text
    if (isPopupText)
        ScreenManager::setPopupTextCentered(false);
    else
        ScreenManager::setMainTextCentered(false);
    pseudoGraphicsEnabled = false;

    // Convert out char array into ushort array (for using fromUtf16 function)
    ushort *prepared_text = new ushort[length];
    for (int i = 0; i < length; i++)
    {
        prepared_text[i] = text[i];
    }
    // Get result text
    result_text = QString::fromUtf16(prepared_text, length);

    delete[] prepared_text;

    // Check if the text contains escape sequences:
    if (result_text.contains(centerSequence)) // Sequence '<ESC>[cm' found - make text centered
    {
        if (isPopupText)
            ScreenManager::setPopupTextCentered(true);
        else
            ScreenManager::setMainTextCentered(true);
        // Remove the sequence from the result text
        result_text.remove(centerSequence);
    }
    if (result_text.contains(pseudoFontSequence)) // Sequence '<ESC>[fS_dm' found - switch to pseudo graphics display
    {
        // What to do with pseudo-graphics?
        pseudoGraphicsEnabled = true;
        // Remove the sequence from the result text
        result_text.remove(pseudoFontSequence);
    }
    if (result_text.contains(normalFontSequence)) // Sequence '<ESC>[fS_gm' found - switch to normal graphics display
    {
        // What to do with pseudo-graphics?
        // Remove the sequence from the result text
        pseudoGraphicsEnabled = false;
        result_text.remove(normalFontSequence);
    }
    return result_text;
}

void Decoder::decodeIcons(unsigned char *text, int length)
{
    ScreenManager::switchOffIcons();
    while (length > 0)
    {
        if (text[0] == 0x01) // Either AS or RDS icons -> length must be at least 3
        {
            if (length < 3) // Wrong length - return
                return;
            if (text[1] == 0x01) // AS icon
            {
                if (text[2] == 0x01) // Enable AS icon
                {
                    ScreenManager::switchASIcon(true);
                }
                else // Disable AS icon
                {
                    ScreenManager::switchASIcon(false);
                }
                length -= 3;
                text = text + 3;
            }
            else if (text[1] == 0x02) // RDS Icon
            {
                if (text[2] == 0x02) // Enable RDS Icon
                {
                    ScreenManager::switchRDSIcon(true);
                }
                else // Disable RDS Icon
                {
                    ScreenManager::switchRDSIcon(false);
                }
                length -= 3;
                text = text + 3;
            }
            else // Wrong sequence - return
            {
                return;
            }
        }
        else if (text[0] == 0x02) // CDin icon -> length must be at least 3
        {
            if (length < 3) // Wrong length - return
                return;
            if (text[1] == 0x01) // CDin icon
            {
                if (text[2] == 0x01) // Enable CDin icon
                {
                    ScreenManager::switchCDinIcon(true);
                }
                else // Disable CDin icon
                {
                    ScreenManager::switchCDinIcon(false);
                }
                length -= 3;
                text = text + 3;
            }
            else // Wrong sequence - return
            {
                return;
            }
        }
        else if (text[0] == 0x03) // TP icon -> length must be at least 3
        {
            if (length < 3) // Wrong length - return
                return;
            if (text[1] == 0x80) // TP icon
            {
                if (text[2] == 0x01) // Enable 'TP'
                {
                    ScreenManager::switchTPIcon(1);
                }
                else if (text[2] == 0x02) // Enable '[  ]'
                {
                    ScreenManager::switchTPIcon(2);
                }
                else if (text[2] == 0x03) // Enable '[TP]'
                {
                    ScreenManager::switchTPIcon(3);
                }
                else // Disable TP Icon
                {
                    ScreenManager::switchTPIcon(0);
                }
                length -= 3;
                text = text + 3;
            }
            else // Wrong sequence - return
            {
                return;
            }
        }
        else if (text[0] == 0x80) // MP3 icon -> length must be at least 2
        {
            if (length < 2) // Wrong length - return
                return;
            if (text[1] == 0x01) // Enable MP3 icon
            {
                ScreenManager::switchMP3Icon(true);
            }
            else // Disable MP3 icon
            {
                ScreenManager::switchMP3Icon(false);
            }
            length -= 2;
            text = text + 2;
        }
        else if (text[0] == 0x83) // RDM icon -> length must be at least 2
        {
            if (length < 2) // Wrong length - return
                return;
            if (text[1] == 0x01) // Enable RDM icon
            {
                ScreenManager::switchRDMIcon(true);
            }
            else // Disable RDM icon
            {
                ScreenManager::switchRDMIcon(false);
            }
            length -= 2;
            text = text + 2;
        }
        else // Wrong sequence - return
        {
            return;
        }
    }
}

