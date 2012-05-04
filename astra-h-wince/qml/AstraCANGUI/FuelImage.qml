// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Image {
    id: fimage

    height: parent.height;
    fillMode: Image.PreserveAspectFit
    anchors { leftMargin: 5; rightMargin: 5 }
    state: ((window.rangeValue <= 50) ? "LOW" : "NORMAL")

    states: [
        State {
            name: "NORMAL"
            PropertyChanges { target: fimage; source: "images/fuel_range.png" }
        },
        State {
            name: "LOW"
            PropertyChanges { target: fimage; source: "images/low_fuel_range.png" }
        }
    ]
}
