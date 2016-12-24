import QtQuick 2.2
import QtQuick.XmlListModel 2.0

Rectangle {
    id: delegate

    property XmlListModel model

    color: "transparent"
    property string time
    property bool daytime: true

    property string icon: "error.png"
    property string iconPrefix: "file:///Users/adaalex/Development/RaspberryPi/MagicMirror/weatherIcons/"

    Image {
        id: _weatherIcon
        anchors.left: parent.left
        anchors.leftMargin: 30
        anchors.verticalCenter: parent.verticalCenter

        width: 100
        height: width

        fillMode: Image.PreserveAspectFit
        source: delegate.iconPrefix + delegate.icon

        transform: Rotation {id: _rotationAnimation; origin.x: 50; origin.y: 50}

        Timer {
            running: delegate.icon === "sunny.png"; repeat: true;
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
        anchors.left: _weatherIcon.right
        anchors.leftMargin: 20

        font.pixelSize: 40
        color: "#333333"

        text: _weatherData.curTemp + "º"
    }

    Text {
        id: _maxTemp

        anchors.left: _curTemp.right
        anchors.top: _curTemp.top
        anchors.margins: 7

        color: "#333333"
        text: _weatherData.maxTemp + "º"
    }

    Text {
        id: _minTemp

        anchors.left: _curTemp.right
        anchors.bottom: _curTemp.bottom
        anchors.margins: 7

        color: "#333333"
        text: _weatherData.minTemp + "º"
    }

//    Text {
//        text: _weatherData.condition
//    }

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
                delegate.icon = "tstorms.png";
                break;

            case "3":
                delegate.icon = "drizzle";
                break;

            case "5":
                delegate.icon = "rain.png";
                break;

            case "6":
                delegate.icon = "snow.png";
                break;

            case "7":
                delegate.icon = "atmosphere.png";
                break;

            case "8":
                if (_weatherData.weatherId === "800") {
                    if (daytime) {
                        delegate.icon = "sunny.png";
                    }
                    else {
                        delegate.icon = "clear_night.png";
                    }
                }
                else if (_weatherData.weatherId === "801") {
                    if (daytime) {
                        delegate.icon = "partly_day.png";
                    }
                    else {
                        delegate.icon = "partly_night.png";
                    }
                }
                else {
                    delegate.icon = "cloudy.png";
                }
                break;

            default:
            break;
        }
    }
}


