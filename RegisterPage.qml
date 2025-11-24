import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.15
import QtQuick.Dialogs 1.3
Item {
    id: root
    Material.theme: Material.Light
    Material.accent: Material.Green
    property int strengthScore: 0
    property string strengthText: "Weak"
    property color strengthColor: "red"
    property bool lengthOk: false
    property bool uppercaseOk: false
    property bool numberOk: false
    property bool specialOk: false
    property bool passwordsMatch: false
    ColumnLayout {
        anchors.centerIn: parent
        spacing: 20
        width: parent.width * 0.6
        Text {
            text: "Register as Instructor"
            font.pixelSize: 24
            font.bold: true
            color: Material.primary
            Layout.alignment: Qt.AlignHCenter
        }
        TextField {
            id: firstNameField
            placeholderText: "First Name"
            Layout.fillWidth: true
        }
        TextField {
            id: lastNameField
            placeholderText: "Last Name"
            Layout.fillWidth: true
        }
        TextField {
            id: emailField
            placeholderText: "Email"
            Layout.fillWidth: true
            property bool isValid: text.includes("@") && text.length > 0
        }
        TextField {
            id: passwordField
            placeholderText: "Password"
            echoMode: TextInput.Password
            Layout.fillWidth: true
            onTextChanged: calculateStrength()
        }
        TextField {
            id: confirmPasswordField
            placeholderText: "Confirm Password"
            echoMode: TextInput.Password
            Layout.fillWidth: true
            onTextChanged: {
                passwordsMatch = (passwordField.text === confirmPasswordField.text && passwordField.text !== "")
            }
        }
        Text {
            text: passwordsMatch ? "Passwords match" : "Passwords do not match"
            color: passwordsMatch ? "green" : "red"
            font.pixelSize: 14
            Layout.alignment: Qt.AlignHCenter
            visible: confirmPasswordField.text !== ""
        }
        Text {
            text: "Password Strength: " + strengthText
            color: strengthColor
            font.pixelSize: 14
            Layout.alignment: Qt.AlignHCenter
        }
        Column {
            spacing: 5
            Layout.alignment: Qt.AlignHCenter
            Text {
                text: (lengthOk ? "✓" : "✗") + " Min 8 characters"
                color: lengthOk ? "green" : "red"
            }
            Text {
                text: (uppercaseOk ? "✓" : "✗") + " Contains uppercase"
                color: uppercaseOk ? "green" : "red"
            }
            Text {
                text: (numberOk ? "✓" : "✗") + " Contains number"
                color: numberOk ? "green" : "red"
            }
            Text {
                text: (specialOk ? "✓" : "✗") + " Contains special character"
                color: specialOk ? "green" : "red"
            }
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
            text: "Register"
            Layout.fillWidth: true
            Layout.maximumWidth: 200
            Layout.alignment: Qt.AlignHCenter
            onClicked: registerFunction()
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
        text: "Registration submitted! Pending admin approval."
        visible: false
        onAccepted: navigateBack()
    }
    function calculateStrength() {
        var pass = passwordField.text
        lengthOk = pass.length >= 8
        uppercaseOk = /[A-Z]/.test(pass)
        numberOk = /\d/.test(pass)
        specialOk = /[^A-Za-z0-9]/.test(pass)
        strengthScore = (lengthOk ? 1 : 0) + (uppercaseOk ? 1 : 0) + (numberOk ? 1 : 0) + (specialOk ? 1 : 0)
        if (strengthScore < 2) {
            strengthText = "Weak"
            strengthColor = "red"
        } else if (strengthScore < 4) {
            strengthText = "Medium"
            strengthColor = "orange"
        } else {
            strengthText = "Strong"
            strengthColor = "green"
        }
    }
    function registerFunction() {
        errorText.text = ""
        if (firstNameField.text === "" || lastNameField.text === "" || emailField.text === "" || passwordField.text === "" || confirmPasswordField.text === "") {
            errorText.text = "Please fill all fields"
            return
        }
        if (!emailField.isValid) {
            errorText.text = "Invalid email format"
            return
        }
        if (!passwordsMatch) {
            errorText.text = "Passwords do not match"
            return
        }
        if (strengthScore < 4) {
            errorText.text = "Password must meet all requirements"
            return
        }
        var requestData = {
            "firstName": firstNameField.text,
            "lastName": lastNameField.text,
            "email": emailField.text,
            "password": passwordField.text
        }
        loadingIndicator.running = true
        apiClient.post(ApiEndpoints.REGISTER_URL, requestData, function(response) {
            loadingIndicator.running = false
            if (response.success) {
                successDialog.visible = true
            } else {
                errorText.text = response.message || "Registration failed"
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
