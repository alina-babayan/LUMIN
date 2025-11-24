import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.15
import QtQuick.Dialogs 1.3
Item {
    id: root
    Material.theme: Material.Light
    Material.accent: Material.Green
    ColumnLayout {
        anchors.centerIn: parent
        spacing: 20
        width: parent.width * 0.6
        Text {
            text: "Reset Password"
            font.pixelSize: 24
            font.bold: true
            color: Material.primary
            Layout.alignment: Qt.AlignHCenter
        }
        Text {
            text: "Enter your email to receive a password reset link"
            font.pixelSize: 16
            color: Material.foreground
            Layout.alignment: Qt.AlignHCenter
        }
        TextField {
            id: emailField
            placeholderText: "Email"
            Layout.fillWidth: true
            property bool isValid: text.includes("@") && text.length > 0
        }
        Text {
            id: errorText
            text: ""
            color: "red"
            font.pixelSize: 14
            Layout.alignment: Qt.AlignHCenter
            visible: text !== ""
        }
        Button {
            text: "Send Reset Link"
            Layout.fillWidth: true
            Layout.maximumWidth: 200
            Layout.alignment: Qt.AlignHCenter
            onClicked: submitFunction()
            Material.elevation: 2
        }
    }
    BusyIndicator {
        id: loadingIndicator
        running: false
        anchors.centerIn: parent
    }
    MessageDialog {
        id: successDialog
        title: "Success"
        text: "Success! Check your email for reset link."
        visible: false
        onAccepted: navigateBack()
    }
    function submitFunction() {
        errorText.text = ""
        if (emailField.text === "") {
            errorText.text = "Please enter your email"
            return
        }
        if (!emailField.isValid) {
            errorText.text = "Invalid email format"
            return
        }
        var requestData = {
            "email": emailField.text
        }
        loadingIndicator.running = true
        apiClient.post(ApiEndpoints.FORGOT_PASSWORD_URL, requestData, function(response) {
            loadingIndicator.running = false
            if (response.success) {
                successDialog.visible = true
            } else {
                errorText.text = response.message || "Request failed"
            }
        })
    }
    function navigateBack() {
        if (stackView) {
            stackView.pop()
        } else {
            console.log("Navigate back to Login")
        }
    }
}
