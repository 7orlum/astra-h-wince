// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle {
    id: menubutton

    property string label: "Button"
    property string icon: ""
    property color buttonColor: "cornflowerblue"
    property color onHoverBorderColor: "gold"
    property color borderColor: "white"
    property bool pressed: false

    signal menuButtonClick()

    height: 40;
    border { width: 2; color: borderColor }
    anchors { left: parent.left; right: parent.right; margins: 5 }
    radius: 5
    smooth: true
    color: buttonColor

    Image {
        id: buttonicon

        height: parent.height;
        fillMode: Image.PreserveAspectFit
        source: icon
        anchors { left: parent.left; margins: 5 }
    }

    Text {
        id: buttontext

        height: parent.height; width: parent.width
        anchors { left: buttonicon.right; margins: 5 }
        font { family: "MS Shell Dlg 2"; pointSize: 14 }
        color: borderColor
        horizontalAlignment: Text.AlignLeft; verticalAlignment: Text.AlignVCenter
        text: label
    }

    MouseArea {
        id: mousearea

        anchors.fill: parent
        onClicked: menuButtonClick()
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
            buttontext.color = onHoverBorderColor;
        }
        onReleased: {
            parent.pressed = false;
            parent.border.color = mousearea.containsMouse ? onHoverBorderColor : borderColor
            parent.color = mousearea.containsMouse ? Qt.darker(buttonColor, 1.2) : buttonColor;
            buttontext.color = borderColor;
        }
    }
}
