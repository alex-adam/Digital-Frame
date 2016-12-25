import QtQuick 2.6
import QtQuick.Window 2.2


// add nightmode: after 10pm - 6pm black screen
// add icons on corners for opening screens
// TimeData as singleton
// news: automatic scrolling

// Settings panel:
// see logs, variables like time, daytime, and restart video playback
// always show time/date
// always show weather

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

            x: -width
            anchors.top: _window.top
            height: _window.height
            width: _window.width / 2

            NewsData {
                anchors.fill: parent
            }

            Behavior on x {
                NumberAnimation {
                    duration: 250; easing.type: Easing.OutCubic
                }
            }
        }

        Rectangle {
            id: _leftTouch

            x: anchors.left
            anchors.verticalCenter: _window.verticalCenter
            height: _window.height / 2
            width: _window.width / 6

            color: "transparent"

            MouseArea {
                id: _leftTouchArea

                anchors.fill: parent

                onClicked: {
                    _newsArea.x === 0 ? _newsArea.x = -_newsArea.width : _newsArea.x = 0;
                }
            }
        }



        RightSide {
            id: _rightSide

            x: _window.width
            anchors.top: _window.top
            height: _window.height
            width: _window.width / 3.5

            Behavior on x {
                NumberAnimation {
                    duration: 250; easing.type: Easing.OutCubic
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
                    _rightSide.x === _window.width ? _rightSide.x = _window.width - _rightSide.width : _rightSide.x = _window.width;
                }
            }
        }
    }
}
