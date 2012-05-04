// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Image {
    id: etimage

    height: parent.height;
    fillMode: Image.PreserveAspectFit
    anchors { leftMargin: 5; rightMargin: 5 }
    state: ((window.engineTemperatureValue <= 50.0) ? "NORMAL" : "HOT")

    states: [
        State {
            name: "NORMAL"
            PropertyChanges { target: etimage; source: "images/engine_thermometer.png" }
        },
        State {
            name: "HOT"
            PropertyChanges { target: etimage; source: "images/engine_thermometer_hot.png" }
        }

    ]
}
