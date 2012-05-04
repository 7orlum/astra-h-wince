// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Text {
    id: ntext

    text: "Уведомление"
    width: parent.width
    wrapMode: Text.WordWrap
    font { family: "MS Shell Dlg 2"; pointSize: 12 }
    color: "white"
    horizontalAlignment: Text.AlignHCenter
    anchors { bottom: closenotifybutton.top; left: parent.left; right: parent.right; margins: 5 }
    state: "OFF"

    states: [
        State {
            name: "OFF"
            PropertyChanges { target: ntext; text: ""; }
            PropertyChanges { target: notifyimage; state: "OFF" }
        },
        State {
            name: "DRIVER_DOOR_OPEN"
            PropertyChanges { target: ntext; text: "Открыта дверь водителя"; }
            PropertyChanges { target: notifyimage; state: "DRIVER_DOOR_OPEN" }
        },
        State {
            name: "PASS_DOOR_OPEN"
            PropertyChanges { target: ntext; text: "Открыта дверь пассажира"; }
            PropertyChanges { target: notifyimage; state: "PASS_DOOR_OPEN" }
        },
        State {
            name: "REAR_DOOR_OPEN"
            PropertyChanges { target: ntext; text: "Открыт багажник"; }
            PropertyChanges { target: notifyimage; state: "REAR_DOOR_OPEN" }
        },
        State {
            name: "DRIVER_PASS_DOORS_OPEN"
            PropertyChanges { target: ntext; text: "Открыты двери водителя и пассажира"; }
            PropertyChanges { target: notifyimage; state: "DRIVER_PASS_DOORS_OPEN" }
        },
        State {
            name: "DRIVER_REAR_DOORS_OPEN"
            PropertyChanges { target: ntext; text: "Открыты дверь водителя и багажник"; }
            PropertyChanges { target: notifyimage; state: "DRIVER_REAR_DOORS_OPEN" }
        },
        State {
            name: "PASS_REAR_DOORS_OPEN"
            PropertyChanges { target: ntext; text: "Открыты дверь пассажира и багажник"; }
            PropertyChanges { target: notifyimage; state: "PASS_REAR_DOORS_OPEN" }
        },
        State {
            name: "ALL_DOORS_OPEN"
            PropertyChanges { target: ntext; text: "Открыты двери водителя и пассажира и багажник"; }
            PropertyChanges { target: notifyimage; state: "ALL_DOORS_OPEN" }
        },
        State {
            name: "HANDBRAKE"
            PropertyChanges { target: ntext; text: "Включен ручной тормоз"; color: "red"; font.bold: true }
            PropertyChanges { target: notifyimage; state: "HANDBRAKE" }
        },
        State {
            name: "SPEED_LIMIT"
            PropertyChanges { target: ntext; text: "Превышение скорости"; color: "red"; font.bold: true }
            PropertyChanges { target: notifyimage; state: "SPEED_LIMIT" }
        },
        State {
            name: "STROBES"
            PropertyChanges { target: ntext; text: "Включены стробоскопы"; color: "gold" }
            PropertyChanges { target: notifyimage; state: "STROBES" }
        }
    ]
}
