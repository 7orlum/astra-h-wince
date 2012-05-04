// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Text {
    id: text

    text: ""
    font { family: "MS Shell Dlg 2"; pointSize: 30 }
    color: "white"
    anchors { verticalCenter: parent.verticalCenter; left: parent.left; right: parent.right; margins: 5; }
    horizontalAlignment: (window.alignMainTextCenter ? Text.AlignHCenter : Text.AlignLeft)
    elide: Text.ElideRight
}
