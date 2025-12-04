import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
Window {
    id: window
    visible: true
    width: 800
    height: 600
    title: "Lumin - Online Learning"
    Material.theme: Material.Light
    Material.accent: Material.Green
    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: "qrc:/new/prefix1/LoginPage.qml"
        // Component.onCompleted: {
        //     if (apiClient.hasValidToken()) {
        //         stackView.replace("qrc:/pages/MainDashboard.qml")
        //     }
        // }
    }
}
/*
import QtQuick 2.15
import QtQuick.Window 2.15

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Qt QML App")

    // Add your QML content here
}*/
