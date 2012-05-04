// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Image {
    id: nimage

    property string label: ""

    fillMode: Image.PreserveAspectFit
    asynchronous: true
    anchors { horizontalCenter: parent.horizontalCenter; top: parent.top; margins: 5 }
    state: "OFF"

    Text {
        id: speedvalue

        text: label
        font { family: "MS Shell Dlg 2"; pointSize: 20; bold: true }
        color: "black"
        anchors { horizontalCenter: parent.horizontalCenter; verticalCenter: parent.verticalCenter }
        visible: false
    }

    states: [
        State {
            name: "OFF"
            PropertyChanges { target: nimage; source: "images/car.png" }
        },
        State {
            name: "DRIVER_DOOR_OPEN"
            PropertyChanges { target: nimage; source: "images/car_driver_door_open.png" }
        },
        State {
            name: "PASS_DOOR_OPEN"
            PropertyChanges { target: nimage; source: "images/car_pass_door_open.png" }
        },
        State {
            name: "REAR_DOOR_OPEN"
            PropertyChanges { target: nimage; source: "images/car_rear_door_open.png" }
        },
        State {
            name: "DRIVER_PASS_DOORS_OPEN"
            PropertyChanges { target: nimage; source: "images/car_driver_pass_doors_open.png" }
        },
        State {
            name: "DRIVER_REAR_DOORS_OPEN"
            PropertyChanges { target: nimage; source: "images/car_driver_rear_doors_open.png" }
        },
        State {
            name: "PASS_REAR_DOORS_OPEN"
            PropertyChanges { target: nimage; source: "images/car_pass_rear_doors_open.png" }
        },
        State {
            name: "ALL_DOORS_OPEN"
            PropertyChanges { target: nimage; source: "images/car_all_doors_open.png" }
        },
        State {
            name: "HANDBRAKE"
            PropertyChanges { target: nimage; source: "images/handbrake.png" }
        },
        State {
            name: "SPEED_LIMIT"
            PropertyChanges { target: nimage; source: "images/sign.png" }
            PropertyChanges { target: speedvalue; visible: true }
        },
        State {
            name: "STROBES"
            PropertyChanges { target: nimage; source: "images/car_strobes_on.png" }
        }
    ]
}
