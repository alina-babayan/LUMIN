import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.15
Item {
    id: root
    Material.theme: Material.Light
    Material.accent: Material.Green
    property string maskedEmail: ""
    property string sessionToken: ""
    property int countdown: 60
    Component.onCompleted: timer.start()
    Timer {
        id: timer
        interval: 1000
        repeat: true
        onTriggered: {
            countdown--;
            if (countdown <= 0) {
                stop();
            }
        }
    }
    ColumnLayout {
        anchors.centerIn: parent
        spacing: 20
        width: parent.width * 0.6
        Text {
            text: "Verify Your Login"
            font.pixelSize: 24
            font.bold: true
            color: Material.primary
            Layout.alignment: Qt.AlignHCenter
        }
        Text {
            text: "Enter the code sent to " + maskedEmail
            font.pixelSize: 16
            color: Material.foreground
            Layout.alignment: Qt.AlignHCenter
        }
        RowLayout {
            spacing: 10
            Layout.alignment: Qt.AlignHCenter
            TextField {
                id: digit1
                width: 40
                horizontalAlignment: TextInput.AlignHCenter
                maximumLength: 1
                validator: IntValidator { bottom: 0; top: 9 }
                onTextChanged: if (length === 1) digit2.forceActiveFocus()
                Keys.onPressed: if (event.key === Qt.Key_Backspace && text === "") { event.accepted = true; }
                focus: true
            }
            TextField {
                id: digit2
                width: 40
                horizontalAlignment: TextInput.AlignHCenter
                maximumLength: 1
                validator: IntValidator { bottom: 0; top: 9 }
                onTextChanged: if (length === 1) digit3.forceActiveFocus()
                Keys.onPressed: if (event.key === Qt.Key_Backspace && text === "") { digit1.forceActiveFocus(); event.accepted = true; }
            }
            TextField {
                id: digit3
                width: 40
                horizontalAlignment: TextInput.AlignHCenter
                maximumLength: 1
                validator: IntValidator { bottom: 0; top: 9 }
                onTextChanged: if (length === 1) digit4.forceActiveFocus()
                Keys.onPressed: if (event.key === Qt.Key_Backspace && text === "") { digit2.forceActiveFocus(); event.accepted = true; }
            }
            TextField {
                id: digit4
                width: 40
                horizontalAlignment: TextInput.AlignHCenter
                maximumLength: 1
                validator: IntValidator { bottom: 0; top: 9 }
                onTextChanged: if (length === 1) digit5.forceActiveFocus()
                Keys.onPressed: if (event.key === Qt.Key_Backspace && text === "") { digit3.forceActiveFocus(); event.accepted = true; }
            }
            TextField {
                id: digit5
                width: 40
                horizontalAlignment: TextInput.AlignHCenter
                maximumLength: 1
                validator: IntValidator { bottom: 0; top: 9 }
                onTextChanged: if (length === 1) digit6.forceActiveFocus()
                Keys.onPressed: if (event.key === Qt.Key_Backspace && text === "") { digit4.forceActiveFocus(); event.accepted = true; }
            }
            TextField {
                id: digit6
                width: 40
                horizontalAlignment: TextInput.AlignHCenter
                maximumLength: 1
                validator: IntValidator { bottom: 0; top: 9 }
                onTextChanged: if (length === 1) verifyFunction()
                Keys.onPressed: if (event.key === Qt.Key_Backspace && text === "") { digit5.forceActiveFocus(); event.accepted = true; }
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
        Text {
            text: "Resend code in " + countdown + " seconds"
            font.pixelSize: 14
            color: Material.foreground
            Layout.alignment: Qt.AlignHCenter
            visible: countdown > 0
        }
        Button {
            text: "Resend Code"
            enabled: countdown <= 0
            Layout.alignment: Qt.AlignHCenter
            onClicked: resendFunction()
            Material.elevation: 2
        }
        Button {
            text: "Verify"
            Layout.fillWidth: true
            Layout.maximumWidth: 200
            Layout.alignment: Qt.AlignHCenter
            onClicked: verifyFunction()
            Material.elevation: 2
        }
    }
    BusyIndicator {
        id: loadingIndicator
        running: false
        anchors.centerIn: parent
    }
    function resendFunction() {
        errorText.text = ""
        countdown = 60
        timer.start()
        console.log("Code resent to " + maskedEmail)
    }
    function verifyFunction() {
        errorText.text = ""
        var code = digit1.text + digit2.text + digit3.text + digit4.text + digit5.text + digit6.text
        if (code.length !== 6) {
            errorText.text = "Please enter a 6-digit code"
            return
        }
        loadingIndicator.running = true
        var requestData = {
            "sessionToken": sessionToken,
            "code": code
        }
        apiClient.post(ApiEndpoints.VERIFY_LOGIN_URL, requestData, function(response) {
            loadingIndicator.running = false
            if (response.success) {
                stackView.replace("qrc:/pages/MainDashboard.qml")
            } else {
                errorText.text = response.message || "Invalid code"
                clearInputs()
            }
        })
    }
    function clearInputs() {
        digit1.text = ""
        digit2.text = ""
        digit3.text = ""
        digit4.text = ""
        digit5.text = ""
        digit6.text = ""
        digit1.forceActiveFocus()
    }
}
