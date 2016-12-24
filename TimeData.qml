import QtQuick 2.0

Item {
    id: root

    property string time
    property string weekday
    property string date

    property var locale: Qt.locale()

    function updateTime() {
        time = new Date().toLocaleTimeString(locale, "hh:mm");
    }

    function updateDate() {
        weekday = new Date().toLocaleString(locale, "dddd");
        date = new Date().toLocaleString(locale, "dd. MMM yyyy");
    }

    Timer {
        running: true; repeat: true; interval: 9000
        onTriggered: {
            updateTime();
            updateDate();
            console.log(root.time);
        }
    }
}
