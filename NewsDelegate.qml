import QtQuick 2.2

Column {
    id: delegate
    width: delegate.ListView.view.width
    spacing: 8

    Item { height: 8; width: delegate.width }

    Row {
        width: parent.width
        spacing: 8

        Column {
            Item {
                width: 4
                height: titleText.font.pixelSize / 4
            }

            Image {
                id: titleImage
                source: image
            }
        }

        Column {
        Text {
            id: titleText

            text: title
            width: delegate.width - titleImage.width
            wrapMode: Text.WordWrap
            font.pixelSize: 22
            font.bold: true
        }

        Text {
            width: delegate.width
            font.pixelSize: 12
            textFormat: Text.RichText
            font.italic: true
            color: "gray"

            text: timeSinceEvent(pubDate)
        }
        }
    }



//    Text {
//        id: descriptionText

//        text: description
//        width: parent.width
//        wrapMode: Text.WordWrap
//        font.pixelSize: 14
//        textFormat: Text.StyledText
//        horizontalAlignment: Qt.AlignLeft
//    }

    // Returns a string representing how long ago an event occurred
    function timeSinceEvent(pubDate) {
        var result = pubDate;

        // We need to modify the pubDate read from the RSS feed
        // so the JavaScript Date object can interpret it
        var d = pubDate.replace(',','').split(' ');
        if (d.length != 6)
            return result;

        var date = new Date([d[0], d[2], d[1], d[3], d[4], 'GMT' + d[5]].join(' '));

        if (!isNaN(date.getDate())) {
            var age = new Date() - date;
            var minutes = Math.floor(Number(age) / 60000);
            if (minutes < 1440) {
                if (minutes < 2)
                    result = qsTr("Just now");
                else if (minutes < 60)
                    result = '' + minutes + ' ' + qsTr("minutes ago")
                else if (minutes < 120)
                    result = qsTr("1 hour ago");
                else
                    result = '' + Math.floor(minutes/60) + ' ' + qsTr("hours ago");
            }
            else {
                result = date.toDateString();
            }
        }
        return result;
    }
}
