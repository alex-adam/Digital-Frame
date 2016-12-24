import QtQuick 2.0

Item {
    id: root

    TimeData {id: _timeData}

    Rectangle {
        id: _background

        anchors.fill: parent
        opacity: 0.5
    }

    Text {
        id: _date

        anchors.top: root.top
        anchors.right: root.right
        anchors.margins: 20
        color: "#333333"

        text: _timeData.weekday + ", " + _timeData.date
    }

    Text {
        id: _time

        anchors.top: _date.bottom
        anchors.right: root.right
        anchors.rightMargin: 17

        text: _timeData.time

        font.pixelSize: 32
        color: "#333333"
    }

    WeatherDelegate {
        anchors.bottom: root.bottom
        anchors.bottomMargin: 20

        width: parent.width
        height: 50
    }
}
