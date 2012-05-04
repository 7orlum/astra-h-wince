// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle {
    id: modebutton

    property string label: "button"
    property color buttonColor: "cornflowerblue"
    property color onHoverBorderColor: "gold"
    property color borderColor: "white"
    property bool pressed: false

    signal modeButtonClick()

    height: parent.height; width: parent.buttonWidth
    border { width: 2; color: borderColor }
    radius: 5
    smooth: true
    color: buttonColor
    state: "NORMAL"

    states: [
        State {
            name: "NORMAL"
            PropertyChanges { target: modebutton; border.color: mousearea.containsMouse ? onHoverBorderColor : borderColor }
        },
        State {
            name: "SELECTED"
            PropertyChanges { target: modebutton; border.color: onHoverBorderColor }
            PropertyChanges { target: modebuttonlabel; color: onHoverBorderColor }
        }
    ]

    Text {
        id: modebuttonlabel

        width: parent.width
        font { family: "MS Shell Dlg 2"; pointSize: 12; bold: true }
        color: borderColor
        horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter
        text: label
    }

    MouseArea {
        id: mousearea

        anchors.fill: parent
        onClicked: modeButtonClick()
        hoverEnabled: true
        onEntered: {
            if (!parent.pressed) {
                parent.border.color = onHoverBorderColor;
                parent.color = Qt.darker(buttonColor, 1.2);
            }
        }
        onExited: {
            if (!parent.pressed) {
                if (parent.state == "NORMAL") {
                    parent.border.color = borderColor
                } else {
                    parent.border.color = onHoverBorderColor;
                }
                parent.color = mousearea.pressed ? Qt.darker(buttonColor, 1.5) : buttonColor;
            }
        }
        onPressed: {
            parent.pressed = true;
            parent.color = Qt.darker(buttonColor, 1.5);
            modebuttonlabel.color = onHoverBorderColor;
        }
        onReleased: {
            parent.pressed = false;
            if (parent.state == "NORMAL") {
                parent.border.color = mousearea.containsMouse ? onHoverBorderColor : borderColor
                modebuttonlabel.color = borderColor;
            }
            parent.color = mousearea.containsMouse ? Qt.darker(buttonColor, 1.2) : buttonColor;
        }
    }
}

