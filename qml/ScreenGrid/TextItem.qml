import QtQuick 1.1

Text {
    id:textItem
    font.pixelSize: 32
    font.bold: true
    z:1
    anchors.centerIn: parent

    SequentialAnimation{
        running: true
        loops: Animation.Infinite
        PropertyAnimation {
            target:textItem;
            property: "color" ;
            from: "white";
            to: "black";
            duration: 1000
        }
        PropertyAnimation {
            target:textItem;
            property: "color" ;
            from: "black";
            to: "white";
            duration: 1000
        }
    }
}
