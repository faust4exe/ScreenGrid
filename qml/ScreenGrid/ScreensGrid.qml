import QtQuick 1.1

Column{
    id: grid

    property int columnsNumber: 3
    property int rowsNumber: 3

    property int curCol: 0
    property int curRow: 0

    property bool isAnimating: false
    property bool isCycle: false

    property bool scaled: false
    property double scaleFactor: grid.scaled ? 1/columnsNumber : 1.0

    transform: Scale{
        xScale: grid.scaled ? 1/columnsNumber : 1
        yScale: grid.scaled ? 1/rowsNumber : 1
//        origin.x: curCol * main.width * grid.scaleFactor
//        origin.y: curRow * main.width * grid.scaleFactor
//        origin.x: main.width * grid.scaleFactor
//        origin.y: main.height * grid.scaleFactor

//        Behavior on xScale {
////            enabled: grid.isAnimating
//             NumberAnimation {duration: 250; easing.type: Easing.InCubic }
//        }

//        Behavior on yScale {
////            enabled: grid.isAnimating
//             NumberAnimation {duration: 250; easing.type: Easing.InCubic }
//        }
    }

    Behavior on x {
        enabled: grid.isAnimating
         NumberAnimation {
            duration: 250
             easing {
                 type: Easing.InCubic
             }
         }
     }

    Behavior on y {
        enabled: grid.isAnimating
         NumberAnimation {
             duration: 250
             easing {
                 type: Easing.InCubic
             }
         }
     }

    Behavior on scale {
        enabled: grid.isAnimating
         NumberAnimation {
             duration: 250
             easing {
                 type: Easing.InCubic
             }
         }
     }

    function moveBy(x, y)
    {
        grid.isAnimating = false
        grid.x = grid.x - x
        grid.y = grid.y - y
        grid.isAnimating = true
    }

    function swipeUp()
    {
        if (curRow < maxRowIndex()) {
            curRow++
        }
        else if (grid.isCycle) {
            curRow = 0
            moveBy(0, -grid.rowsNumber * main.height)
        }

        updatePosition()
    }

    function swipeDown()
    {
        if (curRow != 0) {
            curRow--
        }
        else if (grid.isCycle) {
            curRow = grid.rowsNumber-1
            moveBy(0, grid.rowsNumber * main.height)
        }

        updatePosition()
    }

    function swipeLeft()
    {
        if (curCol < maxColIndex()) {
            curCol++
        }
        else if (grid.isCycle) {
            curCol = 0
            moveBy(-grid.columnsNumber * main.width, 0)
        }

        updatePosition()
    }

    function swipeRight()
    {
        if (curCol != 0) {
            curCol--

        }
        else if (grid.isCycle) {
            curCol = columnsNumber - 1
            moveBy(grid.columnsNumber * main.width, 0)
        }

        updatePosition()
    }

    function updatePosition()
    {
        if (grid.scaled) {
            grid.x = 0
            grid.y = 0
        } else {
            grid.x = (-curCol * main.width) * grid.scaleFactor
            grid.y = (-curRow * main.height) * grid.scaleFactor
        }

        if(grid.isCycle) {
            updateCicleVisibility()
        }
    }

    function updateCicleVisibility()
    {
        resetCicleVisibility()

        if (grid.scaled)
            return

        if(grid.curCol == grid.columnsNumber - 1) {
            grid.children[grid.curRow].children[0].translateX = main.width * grid.columnsNumber
        }

        if(grid.curCol == 0) {
            grid.children[grid.curRow].children[grid.columnsNumber - 1].translateX = -main.width * grid.columnsNumber
        }

        if(grid.curRow == grid.rowsNumber - 1) {
            grid.children[0].children[grid.curCol].translateY = main.height * grid.rowsNumber
        }

        if(grid.curRow == 0) {
            grid.children[grid.rowsNumber - 1].children[grid.curCol].translateY = -main.height * grid.rowsNumber
        }
    }

    function resetCicleVisibility()
    {
        for (var i = 0; i < grid.children.length ; ++i) {
            for (var j = 0; j < grid.children[i].children.length ; ++j) {
                grid.children[i].children[j].translateX = 0
                grid.children[i].children[j].translateY = 0
            }
        }
    }

    function updateCicleVisibilityState()
    {
        if (grid.isCycle)
            updateCicleVisibility()
        else
            resetCicleVisibility()
    }

    function maxRowIndex()
    {
        if (grid.scaled)
            return grid.rowsNumber - 2
        else
            return grid.rowsNumber - 1
    }

    function maxColIndex()
    {
        if (grid.scaled)
            return grid.columnsNumber - 2
        else
            return grid.columnsNumber - 1
    }
}
