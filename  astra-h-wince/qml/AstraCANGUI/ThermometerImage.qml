// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Image {
    id: timage

    height: parent.height
    fillMode: Image.PreserveAspectFit
    anchors { leftMargin: 5; rightMargin: 5 }
    state: ((window.streetTemperatureValue <= 3.0) ? "COLD" : "HOT")

    states: [
        State {
            name: "COLD"
            PropertyChanges { target: timage; source: "images/thermometer_cold.png" }
        },
        State {
            name: "HOT"
            PropertyChanges { target: timage; source: "images/thermometer_hot.png" }
        }

    ]
}
