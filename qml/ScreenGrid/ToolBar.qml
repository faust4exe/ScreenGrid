import QtQuick 1.1

Rectangle{
    id: toolBar
    anchors.bottom: parent.bottom
    anchors.left: parent.left
    anchors.right: parent.right
    height: 30
    border.color: "black"
    border.width: 1

    anchors.bottomMargin: !mainGrid.scaled ? 0 : -height

    Behavior on anchors.bottomMargin {
         NumberAnimation {duration: 250; easing.type: Easing.InCubic }
    }

    Row{
        anchors.fill: parent
        anchors.leftMargin: 5
        spacing: 10

        Rectangle{
            width: 20
            height: 20
            anchors.verticalCenter: parent.verticalCenter
            border.color: "black"
            color: mainGrid.isCycle ? "black" : "white"

            MouseArea{
                anchors.fill: parent

                onClicked: {
                    mainGrid.isCycle = !mainGrid.isCycle

                    mainGrid.updateCicleVisibilityState()
                }
            }
        }

        Text {
            text: "is cycle"
            anchors.verticalCenter: parent.verticalCenter
        }

        Rectangle{
            width: 75
            height: 25
            border.color: "black"
            border.width: 1
            color: area.isClicked ? "grey" : "white"
            radius: 5
            anchors.verticalCenter: parent.verticalCenter
            Text{
                anchors.fill: parent
                text: "Zoom Out"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            MouseArea{
                id: area
                anchors.fill: parent
                property bool isClicked: false

                onPressed: isClicked = true
                onReleased: {
                    isClicked = false

                    mainGrid.scaled = !mainGrid.scaled
                    mainGrid.isAnimating = false
                    mainGrid.updatePosition()
                    mainGrid.isAnimating = true

                    console.debug("Scale " + mainGrid.scaleFactor)
                }
            }
        }
    }
}
