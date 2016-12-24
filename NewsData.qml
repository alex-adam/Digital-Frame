import QtQuick 2.0
import QtQuick.XmlListModel 2.0

import QtGraphicalEffects 1.0

Item {
    id: root

    property string currentFeed: "news.yahoo.com/rss/world"
    property bool loading: feedModel.status === XmlListModel.Loading

    onLoadingChanged: {
        if (feedModel.status == XmlListModel.Ready) {
            list.positionViewAtBeginning();
        }
    }

    XmlListModel {
        id: feedModel

        source: "http://" + root.currentFeed
        query: "/rss/channel/item[child::media:content]"
        namespaceDeclarations: "declare namespace media = 'http://search.yahoo.com/mrss/';"

        XmlRole { name: "title"; query: "title/string()" }
        // Remove any links from the description
        XmlRole { name: "description"; query: "fn:replace(description/string(), '\&lt;a href=.*\/a\&gt;', '')" }
        XmlRole { name: "image"; query: "media:content/@url/string()" }
        XmlRole { name: "link"; query: "link/string()" }
        XmlRole { name: "pubDate"; query: "pubDate/string()" }

        onStatusChanged:{
            if(status == XmlListModel.Loading) {
                console.log("loading...")
            }
            if(status === XmlListModel.Ready) {
                console.log("loaded: " + source)
                errorTimer.start();
            }
            if(status === XmlListModel.Error) {
                console.log("Error: " + errorString())
            }
        }
    }

    Timer {
        id: errorTimer

        interval: 6000
        onTriggered: {
            if (list.count === 0) {
                console.log("Attempt to reload due to error")
                errorTimer.stop()
                feedModel.reload();
            }
        }
    }

    Timer {
        running: true; repeat: true;
        interval: 1800000
        onTriggered: {
            console.log("Reloading news due to timer");
            feedModel.reload();
        }
    }

    Rectangle {
        id: _background

        anchors.fill: root
        opacity: 0.4
    }

    ListView {
        id: list

        anchors.fill: parent
        anchors.margins: 10

        model: feedModel
        delegate: NewsDelegate {}
    }
}
