import QtQuick 2.6
import QtQuick.Window 2.2

import QtMultimedia 5.5

Window {

    visible: true

    width: 800
    height: 480

    flags: "FramelessWindowHint"

    Rectangle {
        id: _window

        anchors.fill: parent
        color: "black"

        VideoPlayer {
            id: _videoPlayer

            anchors.fill: parent
        }

        Item {
            id: _newsArea

            anchors.left: _window.left
            anchors.top: _window.top
            height: _window.height
            width: _window.width / 2

            NewsData {
                anchors.fill: parent
            }

            opacity: 0.0
        }

        RightSide {
            id: _rightSide

            anchors.right: _window.right
            anchors.top: _window.top
            height: _window.height
            width: _window.width / 3.5

            opacity: 0.0
        }


        Rectangle {
            id: _leftTouch

            anchors.left: _window.left
            anchors.verticalCenter: _window.verticalCenter
            height: _window.height / 2
            width: _window.width / 6

            color: "transparent"

            MouseArea {
                id: _leftTouchArea

                anchors.fill: parent

                onClicked: {
                    _newsArea.opacity === 0.0 ? _newsArea.opacity = 1.0 : _newsArea.opacity = 0.0;
                }
            }

        }

        Rectangle {
            id: _rightTouch

            anchors.right: _window.right
            anchors.verticalCenter: _window.verticalCenter
            height: _window.height / 2
            width: _window.width / 6

            color: "transparent"

            MouseArea {
                id: _rightTouchArea

                anchors.fill: parent

                onClicked: {
                    _rightSide.opacity === 0.0 ? _rightSide.opacity = 1.0 : _rightSide.opacity = 0.0;
                }
            }

        }
    }

}
