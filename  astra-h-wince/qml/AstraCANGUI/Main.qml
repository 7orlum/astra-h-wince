// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle {
    id: window

    property int hpartition: 30
    property ModeButton activeButton: offmbutton
    property string ehuLabelText: "Добро пожаловать!"
    property string mainPopupText: ""
    property bool alignMainTextCenter: true
    property bool alignPopupTextCenter: false
    property bool mainPopupTextVisible: false
    property int rangeValue: 230
    property double streetTemperatureValue: 20.5
    property double engineTemperatureValue: 43
    property string time: "00:00"
    property bool regIconOn: false
    property bool asIconOn: false
    property bool rdsIconOn: false
    property bool cdIconOn: false
    property bool mp3IconOn: false
    property bool rdmIconOn: false
    property int tpIconStatus: 0

    width: 500; height: 300

    Rectangle {
        id: header

        height: hpartition; width: parent.width
        color: "royalblue"

        FuelImage {
            id: fuelimage

            anchors.left: parent.left
        }
        DisplayText {
            id: rangetext

            anchors.left: fuelimage.right
            text: window.rangeValue + " км"
        }
        VerticalSpoiler {
            id: vspoiler1

            anchors.left: rangetext.right
        }
        DisplayText {
            id: climatetext

            anchors { left: vspoiler1.right; right: vspoiler2.left }
            text: "Климат - инфо"
        }
        VerticalSpoiler {
            id: vspoiler2

            anchors.right: thermoimage.left
        }
        ThermometerImage {
            id: thermoimage

            anchors.right: streettemperatutetext.left
        }
        DisplayText {
            id: streettemperatutetext

            anchors.right: degrees1.left
            text: window.streetTemperatureValue
        }
        DisplayText {
            id: degrees1

            anchors.right: vspoiler3.left
            text: "<sup>0</sup>C"
        }
        VerticalSpoiler {
            id: vspoiler3

            anchors.right: enginethermoimage.left
        }
        EngineThermometerImage {
            id: enginethermoimage

            anchors.right: enginetemperatutetext.left
        }
        DisplayText {
            id: enginetemperatutetext

            anchors.right: degrees2.left
            text: window.engineTemperatureValue
        }
        DisplayText {
            id: degrees2

            anchors.right: vspoiler4.left
            text: "<sup>0</sup>C"
        }
        VerticalSpoiler {
            id: vspoiler4

            anchors.right: timetext.left
        }
        DisplayText {
            id: timetext

            anchors.right: parent.right
            text: window.time
        }
    }

    Rectangle {
        id: screen

        property int wpartition: width / 4

        width: parent.width;
        anchors { top: header.bottom; bottom: footer.top; topMargin: 2; bottomMargin: 2 }

        Rectangle {
            id: notifyscreen

            height: parent.height; width: screen.wpartition;
            radius: 10
            smooth: true
            anchors { right: mainscreen.left; rightMargin: 2 }
            gradient: Gradient {
                GradientStop { position: 0.0; color: "royalblue" }
                GradientStop { position: 0.5; color: "steelblue" }
                GradientStop { position: 1.0; color: "royalblue" }
            }
            state: "HIDDEN"

            NotifyImage {
                id: notifyimage
            }

            NotifyText {
                id: notifytext
            }

            CloseButton {
                id: closenotifybutton
            }

            MouseArea {
                id: notifyscreenmousearea

                anchors.fill: parent

                onClicked: {
                    parent.state = "HIDDEN"
                }
            }

            states: [
                State {
                    name: "HIDDEN"
                    PropertyChanges { target: notifyscreen; visible: false }
                    PropertyChanges { target: mainscreen; width: screen.width; x: 0 }
                },
                State {
                    name: "SHOWN"
                    PropertyChanges { target: notifyscreen; visible: true }
                    PropertyChanges { target: mainscreen; width: screen.wpartition * 3; x: screen.wpartition }
                }
            ]
        }

        Rectangle {
            id: mainscreen

            MouseArea {
                id: tempMouseArea
                anchors.top: parent.top
                height: 20;
                width: parent.width;
                onClicked: {
                    if (notifyscreen.state == "HIDDEN")
                        notifyscreen.state = "SHOWN"
                    if (notifytext.state == "OFF")
                        notifytext.state = "DRIVER_DOOR_OPEN"
                    else if (notifytext.state == "DRIVER_DOOR_OPEN")
                        notifytext.state = "DRIVER_PASS_DOORS_OPEN"
                    else if (notifytext.state == "DRIVER_PASS_DOORS_OPEN")
                        notifytext.state = "PASS_DOOR_OPEN"
                    else if (notifytext.state == "PASS_DOOR_OPEN")
                        notifytext.state = "PASS_REAR_DOORS_OPEN"
                    else if (notifytext.state == "PASS_REAR_DOORS_OPEN")
                        notifytext.state = "ALL_DOORS_OPEN"
                    else if (notifytext.state == "ALL_DOORS_OPEN")
                        notifytext.state = "DRIVER_REAR_DOORS_OPEN"
                    else if (notifytext.state == "DRIVER_REAR_DOORS_OPEN")
                        notifytext.state = "REAR_DOOR_OPEN"
                    else if (notifytext.state == "REAR_DOOR_OPEN")
                        notifytext.state = "HANDBRAKE"
                    else if (notifytext.state == "HANDBRAKE")
                        notifytext.state = "SPEED_LIMIT"
                    else if (notifytext.state == "SPEED_LIMIT")
                        notifytext.state = "STROBES"
                    else if (notifytext.state == "STROBES")
                        notifytext.state = "DRIVER_DOOR_OPEN"
                }
            }

            property int wiconpartition: width / 7
            property int hpart: height / 10

            height: parent.height; width: screen.wpartition * 3
            radius: 10
            smooth: true
            gradient: Gradient {
                GradientStop { position: 0.0; color: "royalblue" }
                GradientStop { position: 0.5; color: "steelblue" }
                GradientStop { position: 1.0; color: "royalblue" }
            }
            EHUIcon {
                id: regicon

                anchors.left: parent.left
                text: "REG"
                state: (window.regIconOn ? "ON" : "OFF")
            }
            EHUIcon {
                id: asicon

                anchors.left: regicon.right
                text: "AS"
                state: (window.asIconOn ? "ON" : "OFF")
            }
            EHUIcon {
                id: rdsicon

                anchors.left: asicon.right
                text: "RDS"
                state: (window.rdsIconOn ? "ON" : "OFF")
            }
            EHUIcon {
                id: cdicon

                anchors.left: rdsicon.right
                text: "CDin"
                state: (window.cdIconOn ? "ON" : "OFF")
            }
            EHUIcon {
                id: mp3icon

                anchors.left: cdicon.right
                text: "MP3"
                state: (window.mp3IconOn ? "ON" : "OFF")
            }
            EHUIcon {
                id: randicon

                anchors.left: mp3icon.right
                text: "RDM"
                state: (window.rdmIconOn ? "ON" : "OFF")
            }
            TPIcon {
                id: tpicon

                anchors { left: randicon.right; right: parent.right }
                state: getState(window.tpIconStatus)
            }
            Rectangle {
                id: ehuinfo

                y: parent.hpart
                height: parent.hpart * 2; width: parent.width
                anchors { top: regicon.bottom; left: parent.left; right: parent.right; margins: 5 }
                border { color: "white"; width: 1 }
                radius: 5
                smooth: true
                color: "cornflowerblue"
                MainText {
                    text: window.ehuLabelText
                }
            }
            Rectangle {
                id: bcinfo
                height: parent.hpart * 5; width: parent.width
                anchors { top: ehuinfo.bottom; left: parent.left; right: parent.right; margins: 5 }
                border { color: "white"; width: 1 }
                radius: 5
                smooth: true
                color: "cornflowerblue"
                BCInfoText {
                    id: bcinfoname1

                    text: "Суточное расст.:"
                    anchors { left: parent.left; top: parent.top; }
                }
                BCInfoText {
                    id: bcinfoval1

                    text: "1 км"
                    anchors { left: parent.horizontalCenter; top: parent.top; leftMargin: 0 }
                }
                BCInfoText {
                    id: bcinfoname2

                    text: "Расход/путь:"
                    anchors { left: parent.left; top: bcinfoname1.bottom; }
                }
                BCInfoText {
                    id: bcinfoval2

                    text: "8.7 л/100 км"
                    anchors { left: parent.horizontalCenter; top: bcinfoval1.bottom; leftMargin: 0 }
                }
                BCInfoText {
                    id: bcinfoname3

                    text: "Момент. расход:"
                    anchors { left: parent.left; top: bcinfoname2.bottom; }
                }
                BCInfoText {
                    id: bcinfoval3

                    text: "15.6 л/100 км"
                    anchors { left: parent.horizontalCenter; top: bcinfoval2.bottom; leftMargin: 0 }
                }
                BCInfoText {
                    id: bcinfoname4

                    text: "Средний расход:"
                    anchors { left: parent.left; top: bcinfoname3.bottom; }
                }
                BCInfoText {
                    id: bcinfoval4

                    text: "9.0 л/100 км"
                    anchors { left: parent.horizontalCenter; top: bcinfoval3.bottom; leftMargin: 0 }
                }
            }
            Row {
                id: controlbuttons

                property int buttonWidth: (width / 11) - 5

                anchors { left: parent.left; top: bcinfo.bottom; right: parent.right; bottom: parent.bottom; margins: 5 }
                spacing: 5

                ControlButton {
                    id: leftcbutton

                    label: "<"

                    onControlButtonClick: {
                        console.log("previous control button clicked");
                    }
                }
                ControlButton {
                    id: onecbutton

                    label: "1"

                    onControlButtonClick: {
                        console.log("one control button clicked");
                    }
                }
                ControlButton {
                    id: twocbutton

                    label: "2"

                    onControlButtonClick: {
                        console.log("two control button clicked");
                    }
                }
                ControlButton {
                    id: threecbutton

                    label: "3"

                    onControlButtonClick: {
                        console.log("three control button clicked");
                    }
                }
                ControlButton {
                    id: fourcbutton

                    label: "4"

                    onControlButtonClick: {
                        console.log("four control button clicked");
                    }
                }
                ControlButton {
                    id: fivecbutton

                    label: "5"

                    onControlButtonClick: {
                        console.log("five control button clicked");
                    }
                }
                ControlButton {
                    id: sixcbutton

                    label: "6"

                    onControlButtonClick: {
                        console.log("six control button clicked");
                    }
                }
                ControlButton {
                    id: sevencbutton

                    label: "7"

                    onControlButtonClick: {
                        console.log("seven control button clicked");
                    }
                }
                ControlButton {
                    id: eightcbutton

                    label: "8"

                    onControlButtonClick: {
                        console.log("eight control button clicked");
                    }
                }
                ControlButton {
                    id: ninecbutton

                    label: "9"

                    onControlButtonClick: {
                        console.log("nine control button clicked");
                    }
                }
                ControlButton {
                    id: rightcbutton

                    label: ">"

                    onControlButtonClick: {
                        console.log("next control button clicked");
                    }
                }
            }
        }
    }

    Rectangle {
        id: mainpopupscreen

        height: hpartition; width: parent.width
        anchors { top: header.bottom; bottom: footer.top; topMargin: 2; bottomMargin: 2 }
        radius: 10
        smooth: true
        visible: window.mainPopupTextVisible
        gradient: Gradient {
            GradientStop { position: 0.0; color: "royalblue" }
            GradientStop { position: 0.5; color: "steelblue" }
            GradientStop { position: 1.0; color: "royalblue" }
        }

        MainPopupText {
            id: mainpopuptext
        }

        CloseButton {
            id: mainpopupclosebutton
        }

        MouseArea {
            id: mainpopupscreenmousearea

            anchors.fill: parent

            onClicked: {
                window.mainPopupTextVisible = false
            }
        }
    }

    Rectangle {
        id: footer

        anchors.bottom: parent.bottom
        height: hpartition * 1; width: parent.width
        color: "royalblue"

        Row {
            id: modebuttons

            property int buttonWidth: (width / 9) - 4

            anchors { left: parent.left; top: parent.top; right: parent.right; bottom: parent.bottom; margins: 5 }
            spacing: 5

            ModeButton {
                id: offmbutton

                label: "Выкл"
                state: (window.activeButton === offmbutton) ? "SELECTED" : "NORMAL"

                onModeButtonClick: {
                    console.log("off mode button clicked");
                    window.activeButton = offmbutton;
                }
            }
            ModeButton {
                id: am1mbutton

                label: "AM1"
                state: (window.activeButton === am1mbutton) ? "SELECTED" : "NORMAL"

                onModeButtonClick: {
                    console.log("AM1 mode button clicked");
                    window.activeButton = am1mbutton;
                }
            }
            ModeButton {
                id: am2mbutton

                label: "AM2"
                state: (window.activeButton === am2mbutton) ? "SELECTED" : "NORMAL"

                onModeButtonClick: {
                    console.log("AM2 mode button clicked");
                    window.activeButton = am2mbutton;
                }
            }
            ModeButton {
                id: fm1mbutton

                label: "FM1"
                state: (window.activeButton === fm1mbutton) ? "SELECTED" : "NORMAL"

                onModeButtonClick: {
                    console.log("FM1 mode button clicked");
                    window.activeButton = fm1mbutton;
                }
            }
            ModeButton {
                id: fm2mbutton

                label: "FM2"
                state: (window.activeButton === fm2mbutton) ? "SELECTED" : "NORMAL"

                onModeButtonClick: {
                    console.log("FM2 mode button clicked");
                    window.activeButton = fm2mbutton;
                }
            }
            ModeButton {
                id: auxmbutton

                label: "AUX"
                state: (window.activeButton === auxmbutton) ? "SELECTED" : "NORMAL"

                onModeButtonClick: {
                    console.log("AUX mode button clicked");
                    window.activeButton = auxmbutton;
                }
            }
            ModeButton {
                id: cdmbutton

                label: "CD"
                state: (window.activeButton === cdmbutton) ? "SELECTED" : "NORMAL"

                onModeButtonClick: {
                    console.log("CD mode button clicked");
                    window.activeButton = cdmbutton;
                }
            }
            ModeButton {
                id: navimbutton

                label: "Нави"
                state: (window.activeButton === navimbutton) ? "SELECTED" : "NORMAL"

                onModeButtonClick: {
                    console.log("Navi mode button clicked");
                    window.activeButton = navimbutton;
                }
            }
            ModeButton {
                id: menumbutton

                label: "Меню"
                onModeButtonClick: {
                    if (mainmenu.state == "HIDDEN") {
                        mainmenu.state = "SHOWN";
                    } else {
                        mainmenu.state = "HIDDEN";
                    }
                }
            }
        }

        Menu {
            id: mainmenu
        }
    }

    MouseArea {
        id: closemenumousearealeft

        enabled: false
        width: parent.width - mainmenu.width;
        anchors { left: parent.left; top: parent.top; bottom: parent.bottom }

        onClicked: {
            mainmenu.state = "HIDDEN";
        }
    }

    MouseArea {
        id: closemenumouseareatop

        height: parent.height - mainmenu.height; width: mainmenu.width;
        anchors { top: parent.top; right: parent.right }
        enabled: false

        onClicked: {
            mainmenu.state = "HIDDEN";
        }
    }
}
