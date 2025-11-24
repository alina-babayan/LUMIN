import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.15
Item {
    id: root
    Material.theme: Material.Light
    Material.accent: Material.Green
    // Background image
    Image {
        source: "qrc:/images/student_background.jpg"
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        opacity: 0.7
    }
    Rectangle {
        anchors.fill: parent
        color: "#FFFFFF"
        opacity: 0.3
    }
    ColumnLayout {
        anchors.centerIn: parent
        spacing: 20
        width: parent.width * 0.6
        Text {
            text: "Welcome to Lumin"
            font.pixelSize: 24
            font.bold: true
            color: Material.primary
            Layout.alignment: Qt.AlignHCenter
        }
        TextField {
            id: emailField
            placeholderText: "Email"
            Layout.fillWidth: true
            onAccepted: passwordField.forceActiveFocus()
            property bool isValid: text.includes("@") && text.length > 0
            Rectangle {
                anchors.fill: parent
                color: "transparent"
                border.color: emailField.isValid ? "transparent" : "red"
                border.width: 1
            }
        }
        TextField {
            id: passwordField
            placeholderText: "Password"
            echoMode: TextInput.Password
            Layout.fillWidth: true
            onAccepted: loginFunction()
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
            text: "Login"
            Layout.fillWidth: true
            Layout.maximumWidth: 200
            Layout.alignment: Qt.AlignHCenter
            onClicked: loginFunction()
            Material.elevation: 2
        }
        RowLayout {
            spacing: 20
            Layout.alignment: Qt.AlignHCenter
            Text {
                text: "Forgot Password?"
                color: Material.accent
                font.underline: true
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: stackView.push("qrc:/pages/ForgotPasswordPage.qml")
                }
            }
            Text {
                text: "Register as Instructor"
                color: Material.accent
                font.underline: true
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: stackView.push("qrc:/pages/RegisterPage.qml")
                }
            }
        }
    }
    BusyIndicator {
        id: loadingIndicator
        running: false
        anchors.centerIn: parent
    }
    function loginFunction() {
        errorText.text = ""
        if (emailField.text === "" || passwordField.text === "") {
            errorText.text = "Please fill all fields"
            return
        }
        if (!emailField.isValid) {
            errorText.text = "Invalid email format"
            return
        }
        var requestData = {
            "email": emailField.text,
            "password": passwordField.text
        }
        loadingIndicator.running = true
        apiClient.post(ApiEndpoints.LOGIN_URL, requestData, function(response) {
            loadingIndicator.running = false
            if (response.success) {
                var data = response.data
                if (data.requiresVerification) {
                    stackView.push("qrc:/pages/OTPVerificationPage.qml", {
                        maskedEmail: data.maskedEmail,
                        sessionToken: data.sessionToken
                    })
                } else {
                    stackView.replace("qrc:/pages/MainDashboard.qml")
                }
            } else {
                errorText.text = response.message || "Login failed"
            }
        })
    }
}
