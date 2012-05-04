// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Text {
    id: tpicon

    function getState(val)
    {
        switch (val) {
        case 0:
            return "OFF";
        case 1:
            return "AVAILABLE";
        case 2:
            return "SEARCHING";
        case 3:
            return "FOUND";
        default:
            return "OFF";
        }
    }

    height: mainscreen.hpart; width: mainscreen.wiconpartition
    font { family: "MS Shell Dlg 2"; pointSize: 14 }
    horizontalAlignment: Text.Center
    color: "white"
    state: "OFF"

    states: [
        State {
            name: "OFF"
            PropertyChanges { target: tpicon; text: "[  ]"; color: "#408be1" }
        },
        State {
            name: "AVAILABLE"
            PropertyChanges { target: tpicon; text: "TP" }
        },
        State {
            name: "SEARCHING"
            PropertyChanges { target: tpicon; text: "[  ]" }
        },
        State {
            name: "FOUND"
            PropertyChanges { target: tpicon; text: "[TP]" }
        }
    ]
}
