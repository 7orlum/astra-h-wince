// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Text {
    id: ehuicon

    height: mainscreen.hpart; width: mainscreen.wiconpartition
    font { family: "MS Shell Dlg 2"; pointSize: 14 }
    horizontalAlignment: Text.Center
    state: "OFF"

    states: [
        State {
            name: "OFF"
            PropertyChanges { target: ehuicon; color: "#408be1" }
        },
        State {
            name: "ON"
            PropertyChanges { target: ehuicon; color: "white" }
        }
    ]
}
