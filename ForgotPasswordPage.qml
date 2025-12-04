import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.15

Item {
    id: root
    Material.theme: Material.Light
    Material.accent: Material.Green

    // Back button in top-left
    Button {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: 10
        icon.name: "arrow-back"
        flat: true
        onClicked: stackView.pop()  // Back to login
    }

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

    Popup {
        id: successPopup
        anchors.centerIn: parent
        width: 300
        height: 200
        modal: true
        focus: true

        Column {
            anchors.centerIn: parent
            spacing: 20

            Text {
                text: "Success"
                font.pixelSize: 20
                font.bold: true
                horizontalAlignment: Text.AlignHCenter
            }

            Text {
                text: "Success! Check your email for reset link."
                horizontalAlignment: Text.AlignHCenter
            }

            Button {
                text: "OK"
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    successPopup.close()
                    navigateBack()
                }
            }
        }
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

        apiClient.post(ApiEndpoints.forgotPassword, requestData, function(response) {
            loadingIndicator.running = false
            if (response.success) {
                successPopup.open()
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
