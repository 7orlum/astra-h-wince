// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle {
    id: controlbutton

    property string label: "button"
    property color buttonColor: "cornflowerblue"
    property color onHoverBorderColor: "gold"
    property color borderColor: "white"
    property bool pressed: false

    signal controlButtonClick()

    height: parent.height; width: parent.buttonWidth
    border { width: 2; color: borderColor }
    radius: 5
    smooth: true
    color: buttonColor

    Text {
        id: controlbuttonlabel

        height: parent.height; width: parent.width
        font { family: "MS Shell Dlg 2"; pointSize: 12; bold: true }
        color: borderColor
        horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter
        text: label
    }

    MouseArea {
        id: mousearea

        anchors.fill: parent
        onClicked: controlButtonClick()
        hoverEnabled: true
        onEntered: {
            if (!parent.pressed) {
                parent.border.color = onHoverBorderColor;
                parent.color = Qt.darker(buttonColor, 1.2);
            }
        }
        onExited: {
            if (!parent.pressed) {
                parent.border.color = borderColor
                parent.color = mousearea.pressed ? Qt.darker(buttonColor, 1.5) : buttonColor;
            }
        }
        onPressed: {
            parent.pressed = true;
            parent.color = Qt.darker(buttonColor, 1.5);
            controlbuttonlabel.color = onHoverBorderColor;
        }
        onReleased: {
            parent.pressed = false;
            parent.border.color = mousearea.containsMouse ? onHoverBorderColor : borderColor
            parent.color = mousearea.containsMouse ? Qt.darker(buttonColor, 1.2) : buttonColor;
            controlbuttonlabel.color = borderColor;
        }
    }
}
