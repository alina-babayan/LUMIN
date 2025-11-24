import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
Window {
    id: window
    visible: true
    width: 360
    height: 640
    title: "Lumin - Online Learning"
    Material.theme: Material.Light
    Material.accent: Material.Green
    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: "qrc:/pages/LoginPage.qml"
        // Component.onCompleted: {
        //     if (apiClient.hasValidToken()) {
        //         stackView.replace("qrc:/pages/MainDashboard.qml")
        //     }
        // }
    }
}
