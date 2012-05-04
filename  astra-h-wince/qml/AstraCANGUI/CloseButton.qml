// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle {
    id: closebutton

    property int pheight: parent.height
    property int pwidth: parent.width

    height: 20
    border { width: 2; color: "white" }
    anchors { left: parent.left; right: parent.right; bottom: parent.bottom; margins: 5 }
    radius: 5
    smooth: true
    color: "cornflowerblue"

    Text {
        id: closetext

        width: parent.width
        font { family: "MS Shell Dlg 2"; pointSize: 11 }
        color: "white"
        horizontalAlignment: Text.AlignHCenter
        text: "\"OK\" - закрыть"
    }
}
