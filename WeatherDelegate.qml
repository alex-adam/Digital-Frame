import QtQuick 2.2
import QtQuick.XmlListModel 2.0

Rectangle {
    id: root

    property XmlListModel model

    color: "transparent"
    property string time
    property bool daytime: true

    property string icon: "error.png"
    property string iconPrefix: "file:///Users/adaalex/Development/RaspberryPi/MagicMirror/weatherIcons/"

    Image {
        id: _weatherIcon

        anchors.verticalCenter: _curTemp.verticalCenter
        anchors.right: _curTemp.left
        anchors.rightMargin: 10

        width: 100
        height: width

        fillMode: Image.PreserveAspectFit
        source: root.iconPrefix + root.icon

        transform: Rotation {id: _rotationAnimation; origin.x: 50; origin.y: 50}

        Timer {
            running: root.icon === "sunny.png"; repeat: true;
            interval: 40
            onTriggered: {
                _rotationAnimation.angle += 1;
            }
        }

        onSourceChanged: {
            _rotationAnimation.angle = 0;
        }
    }

    Text {
        id: _curTemp

        anchors.verticalCenter: parent.verticalCenter
        anchors.right: _minTemp.left
        anchors.rightMargin: 20

        font.pixelSize: 40
        color: "#333333"

        text: _weatherData.curTemp + "º"
    }

    Text {
        id: _maxTemp

        anchors.right: root.right
        anchors.bottom: _minTemp.top
        anchors.rightMargin: 20
        anchors.bottomMargin: 7

        color: "#333333"
        text: _weatherData.maxTemp + "º"
    }

    Text {
        id: _minTemp

        anchors.right: root.right
        anchors.bottom: root.bottom
        anchors.rightMargin: 20
        anchors.bottomMargin: 7

        color: "#333333"
        text: _weatherData.minTemp + "º"
    }

    WeatherData {
        id: _weatherData

        onDataLoaded: {
            setIcon();
        }
    }

    function setDaytime() {
        console.log("Weather set Daytime");
        time = new Date().toLocaleTimeString(Qt.locale(), "hh");

        if (time > 17 || time < 7) {
            daytime = false;
        }
        else {
            daytime = true;
        }
        console.log("Weather time: " + time + ", daytime: " + daytime);
    }

    function setIcon() {
        setDaytime();

        console.log("Weather set Icon + " + _weatherData.weatherId);
        switch(_weatherData.weatherId.substring(0,1)) {
            case "2":
                root.icon = "tstorms.png";
                break;

            case "3":
                root.icon = "drizzle";
                break;

            case "5":
                root.icon = "rain.png";
                break;

            case "6":
                root.icon = "snow.png";
                break;

            case "7":
                root.icon = "atmosphere.png";
                break;

            case "8":
                if (_weatherData.weatherId === "800") {
                    if (daytime) {
                        root.icon = "sunny.png";
                    }
                    else {
                        root.icon = "clear_night.png";
                    }
                }
                else if (_weatherData.weatherId === "801") {
                    if (daytime) {
                        root.icon = "partly_day.png";
                    }
                    else {
                        root.icon = "partly_night.png";
                    }
                }
                else {
                    root.icon = "cloudy.png";
                }
                break;

            default:
            break;
        }
    }
}


