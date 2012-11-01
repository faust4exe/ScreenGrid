import QtQuick 1.1

Rectangle {
    id: screen
    width: main.width
    height: main.height

    property int swipeMargin : 20
    property int swipeLimit : 50
    property int pivotX: 0
    property int pivotY: 0
    property int lastX: 0
    property int lastY: 0
    property bool swipeActive: false

    property int translateX:0
    property int translateY:0
    property int scale: 1

    transform: Translate{
            x: screen.translateX
            y: screen.translateY
    }

    // 0 - undefined
    // 1 - horizontal
    // 2 - vertical
    property int direction:0

    property int positionX: 0
    property int positionY: 0

    border.color: "black"
    border.width: 1

    signal swipeBy(int x, int y)
    signal swipeTo(int x, int y)
    signal swipeUp
    signal swipeDown
    signal swipeLeft
    signal swipeRight

    Rectangle{

//        z: mainGrid.scaled ? 1 : 0
        anchors.fill: parent
        anchors.topMargin: swipeMargin
        anchors.bottomMargin: swipeMargin * 2
        anchors.leftMargin: swipeMargin
        anchors.rightMargin: swipeMargin
        border.color: "grey"
        border.width: 1

//        color: mainGrid.scaled ? "grey" : "#00000000"

//        TextItem {
//            visible: mainGrid.scaled
//            text: "Press And Hold\n   to Select"
//        }
    }



    MouseArea{
        anchors.fill: parent

        onPressAndHold: {
            if (!mainGrid.scaled)
                return

            for (var i = 0; i < mainGrid.children.length ; ++i) {
                for (var j = 0; j < mainGrid.children[i].children.length ; ++j) {
                    if (mainGrid.children[i].children[j] == screen) {
                        console.debug("Selected x = " + i + "  y = " + j)
                        mainGrid.curRow = i
                        mainGrid.curCol = j
                        break;
                    }
                }
            }

            mainGrid.scaled = !mainGrid.scaled
            mainGrid.isAnimating = false
            mainGrid.updatePosition()
            mainGrid.isAnimating = true
        }

        onPressed: {
            if (mainGrid.scaled)
                return

            // in future just save the position it will be as pivot
            if (isSwipeMargin(mouse.x, mouse.y)) {
                screen.pivotX = mapToParent(mouse.x, mouse.y).x
                screen.pivotY = mapToParent(mouse.x, mouse.y).y

                lastX = mouse.x
                lastY = mouse.y

                screen.swipeActive = true
            }
        }

        onMousePositionChanged: {
            if (!screen.swipeActive)
                return

            var swypeX = screen.lastX - mouse.x
            var swypeY = screen.lastY - mouse.y

            if (screen.direction == 0) {
                var deltaX = screen.pivotX - mapToParent(mouse.x, mouse.y).x
                var deltaY = screen.pivotY - mapToParent(mouse.x, mouse.y).y

                if (Math.abs(deltaX) != Math.abs(deltaY)) {
                    if (Math.abs(deltaX) > Math.abs(deltaY))
                        screen.direction = 1
                     else
                        screen.direction = 2
                }
            }

            if (screen.direction == 1)
                swypeY = 0
            else
                swypeX = 0

            mainGrid.moveBy(swypeX, swypeY)
        }

        onReleased: {
            if (swipeActive) {
                var deltaX = mapToParent(mouse.x, mouse.y).x - screen.pivotX
                var deltaY = mapToParent(mouse.x, mouse.y).y - screen.pivotY

                var swipeActivated = false
                if (deltaX > screen.swipeLimit && screen.direction == 1) {
                    mainGrid.swipeRight()
                    swipeActivated = true
                }
                if (deltaX < -screen.swipeLimit  && screen.direction == 1) {
                    mainGrid.swipeLeft()
                    swipeActivated = true
                }
                if (deltaY > screen.swipeLimit  && screen.direction == 2) {
                    mainGrid.swipeDown()
                    swipeActivated = true
                }
                if (deltaY < -screen.swipeLimit  && screen.direction == 2) {
                    mainGrid.swipeUp()
                    swipeActivated = true
                }

                if (!swipeActivated)
                    mainGrid.updatePosition()
            }

            screen.swipeActive = false
            screen.direction = 0
        }
    }

    function isSwipeMargin(posx, posy)
    {
        return true
    }

    function mapToParent(x, y)
    {
        return mapToItem (main, x, y)
    }
}
