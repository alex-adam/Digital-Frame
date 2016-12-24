import QtQuick 2.0
import QtQuick.XmlListModel 2.0

Item {
    id: root

    property string maxTemp: "value"
    property string minTemp: "value"
    property string curTemp: "value"
    property string condition: "value"
    property string weatherId: "value"

    property string currentFeed: "api.openweathermap.org/data/2.5/weather?q=Sunnyvale,CA&mode=xml&"
    property bool loading: feedModel.status === XmlListModel.Loading

    property string appKey: "appid=0196e2962586661b1472e4254bb2ba9c"

    signal dataLoaded

    onLoadingChanged: {
        if (feedModel.status === XmlListModel.Ready) {
            console.log("Weather loaded");
            setData();
        }
        else {
            console.log("Weather " + feedModel.status);
        }
    }

    XmlListModel {
        id: feedModel

        source: "http://" + root.currentFeed + appKey
        query: "/current"

        XmlRole { name: "sunrise"; query: "city/sun/@rise/string()" }
        XmlRole { name: "sunset"; query: "city/sun/@set/string()" }

        XmlRole { name: "curTemp"; query: "temperature/@value/string()" }
        XmlRole { name: "maxTemp"; query: "temperature/@max/string()" }
        XmlRole { name: "minTemp"; query: "temperature/@min/string()" }

        XmlRole { name: "humidity"; query: "humidity/@value/string()" }
        XmlRole { name: "wind"; query: "wind/speed/@name/string()" }

        XmlRole { name: "cloud"; query: "clouds/@name/string()" }

        XmlRole { name: "id"; query: "weather/@number/string()" }
        XmlRole { name: "condition"; query: "weather/@value/string()" }
    }

    function setData() {
        root.maxTemp = getCelsius(feedModel.get(0).maxTemp);
        root.minTemp = getCelsius(feedModel.get(0).minTemp);
        root.curTemp = getCelsius(feedModel.get(0).curTemp);
        root.condition = feedModel.get(0).condition;
        root.weatherId = feedModel.get(0).id;
        root.dataLoaded();
    }

    function getCelsius(kelvin) {
        return Math.round(kelvin - 273.15);
    }
}
