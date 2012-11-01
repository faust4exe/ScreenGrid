// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle {
    id: main
    width: 360
    height: 640

    Rectangle{
        anchors.fill: parent
        color: "black"

        ScreensGrid {
            id: mainGrid

            Component.onCompleted: {
                mainGrid.columnsNumber = mainGrid.children.length
            }

            ScreensRow{
                id: row

                Component.onCompleted: {
                    mainGrid.rowsNumber = row.children.length
                }

                ScreenItem {
                    TextItem {
                        text: qsTr("Screen 1")
                    }
                    Image {
                        anchors.fill: parent
                        source: "qrc:/images/1.png"
                    }
                }

                ScreenItem {
                    TextItem {
                        text: qsTr("Screen 2")
                    }
                    Image {
                        anchors.fill: parent
                        source: "qrc:/images/2.png"
                    }
                }

                ScreenItem {
                    TextItem {
                        text: qsTr("Screen 3")
                    }
                    Image {
                        anchors.fill: parent
                        source: "qrc:/images/3.png"
                    }
                }
            }

            ScreensRow{
                ScreenItem {
                    TextItem {
                        text: qsTr("Screen 4")
                    }
                    Image {
                        anchors.fill: parent
                        source: "qrc:/images/4.png"
                    }
                }

                ScreenItem {
                    TextItem {
                        text: qsTr("Screen 5")
                    }
                    Image {
                        anchors.fill: parent
                        source: "qrc:/images/5.png"
                    }
                }

                ScreenItem {
                    TextItem {
                        text: qsTr("Screen 6")
                    }
                    Image {
                        anchors.fill: parent
                        source: "qrc:/images/6.png"
                    }
                }
            }

            ScreensRow{
                ScreenItem {
                    TextItem {
                        text: qsTr("Screen 7")
                    }
                    Image {
                        anchors.fill: parent
                        source: "qrc:/images/7.png"
                    }
                }



                ScreenItem {
                    TextItem {
                        text: qsTr("Screen 8")
                    }
                    Image {
                        anchors.fill: parent
                        source: "qrc:/images/8.png"
                    }
                }

                ScreenItem {
                    TextItem {
                        text: qsTr("Screen 9")
                    }
                    Image {
                        anchors.fill: parent
                        source: "qrc:/images/9.png"
                    }
                }
            }
        }

        TextItem {
            id: infoText
            visible: mainGrid.scaled
            text: "Press And Hold\n   to Select"
            color: "white"
        }

        SequentialAnimation{
            running: mainGrid.scaled
            loops: Animation.Infinite
            NumberAnimation{
                target: infoText
                property: "opacity"
                from: 0
                to: 0.5
                duration: 500
            }
            NumberAnimation{
                target: infoText
                property: "opacity"
                from: 0.5
                to: 0
                duration: 500
            }
        }
    }

    ToolBar {
        id: toolBar
    }
}
