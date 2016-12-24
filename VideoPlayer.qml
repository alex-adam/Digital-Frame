import QtQuick 2.0
import QtMultimedia 5.5

Video {
    id: root

    property string time
    property string daytime: "day"

    property string prefix: "file:///Users/adaalex/Development/RaspberryPi/data/drones/"
    property string movie

    property int dayMedia: 9
    property int sunsetMedia: 3
    property int nightMedia: 4

    property int curMedia: 3

    anchors.fill: parent
    fillMode: VideoOutput.PreserveAspectCrop
    autoPlay: true

    source: "none.mov"

    onStatusChanged: {
        console.log("Video: " + root.status);

        if (status === MediaPlayer.EndOfMedia || status === MediaPlayer.NoMedia || status === MediaPlayer.InvalidMedia) {
            setSource();
            play();
        }
    }

    function setSource() {
        //check via time
        console.log("Video: setting Source");
        setDaytime();
        root.source = prefix + daytime + "/" + Math.floor((Math.random() * curMedia) + 1) + ".mp4"
        console.log("Video Source: " + root.source);
    }

    function setDaytime() {
        console.log("Video set Daytime");
        time = new Date().toLocaleTimeString(Qt.locale(), "hh");

        if (time > 17 || time < 7) {
            daytime = "night";
            curMedia = nightMedia;
        }
        else if (time === 17) {
            daytime = "sunset";
            curMedia = sunsetMedia;
        }
        else {
            daytime = "day";
            curMedia = dayMedia;
        }
        console.log("Video time: " + time + ", daytime: " + daytime);
    }
}
