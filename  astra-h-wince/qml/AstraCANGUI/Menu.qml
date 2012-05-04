// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle {
    id: menu

    height: 215; width: 260
    color: "royalblue"
    anchors { bottom: parent.bottom; right: parent.right; bottomMargin: parent.height - 1; rightMargin: 2 }
    border { width: 2; color: "white" }
    radius: 5
    smooth: true
    state: "HIDDEN"

    states: [
        State {
            name: "HIDDEN"
            PropertyChanges { target: menu; visible: false }
            PropertyChanges { target: menumbutton; state: "NORMAL" }
        },
        State {
            name: "SHOWN"
            PropertyChanges { target: menumbutton; state: "SELECTED" }
            PropertyChanges { target: closemenumousearealeft; enabled: true }
            PropertyChanges { target: closemenumouseareatop; enabled: true }
        }
    ]

    Text {
        id: title

        text: "Меню"
        font { family: "MS Shell Dlg 2"; pointSize: 14 }
        color: "white"
        anchors { top: parent.top; left: parent.left; margins: 5; }
    }

    Image {
        id: fimage

        height: 24;
        fillMode: Image.PreserveAspectFit
        asynchronous: true
        source: "images/menu_close.png"
        anchors { top: parent.top; right: parent.right; margins: 5 }
    }

    MenuButton {
        id: autosettingsmb

        label: "Настройки авто"
        icon: "images/settings_auto.png"
        anchors.top: title.bottom

        onMenuButtonClick: {
            console.log("Auto Settings Clicked");
        }
    }

    MenuButton {
        id: programsettingsmb

        label: "Настройки программы"
        icon: "images/settings_program.png"
        anchors.top: autosettingsmb.bottom

        onMenuButtonClick: {
            console.log("Program Settings Clicked");
        }
    }

    MenuButton {
        id: hideprogrammb

        label: "Свернуть программу"
        icon: "images/hide_program.png"
        anchors.top: programsettingsmb.bottom

        onMenuButtonClick: {
            console.log("Minimize Clicked");
        }
    }

    MenuButton {
        id: closeprogrammb

        label: "Закрыть программу"
        icon: "images/close_program.png"
        anchors.top: hideprogrammb.bottom

        onMenuButtonClick: {
            Qt.quit();
        }
    }
}
