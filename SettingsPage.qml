import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.15

Item {
    id: root
    property var user: ({})  // From MainWindow

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 20
        width: parent.width * 0.6

        Text {
            text: "Settings"
            font.pixelSize: 24
            font.bold: true
            color: Material.primary
            Layout.alignment: Qt.AlignHCenter
        }

        // Profile image
        Image {
            source: user.profileImage || "default_profile.jpg"
            width: 100
            height: 100
            Layout.alignment: Qt.AlignHCenter
        }

        Button {
            text: "Upload Profile Image"
            Layout.alignment: Qt.AlignHCenter
            onClicked: uploadImage()
        }

        Button {
            text: "Remove Profile Image"
            Layout.alignment: Qt.AlignHCenter
            onClicked: removeImage()
        }

        TextField {
            id: firstNameField
            text: user.firstName
            Layout.fillWidth: true
        }

        TextField {
            id: lastNameField
            text: user.lastName
            Layout.fillWidth: true
        }

        Button {
            text: "Update Profile"
            Layout.alignment: Qt.AlignHCenter
            onClicked: updateProfile()
        }

        TextField {
            id: currentPassword
            placeholderText: "Current Password"
            echoMode: TextInput.Password
            Layout.fillWidth: true
        }

        TextField {
            id: newPassword
            placeholderText: "New Password"
            echoMode: TextInput.Password
            Layout.fillWidth: true
        }

        Button {
            text: "Change Password"
            Layout.alignment: Qt.AlignHCenter
            onClicked: changePasswordFunction()
        }
    }

    BusyIndicator {
        id: loadingIndicator
        running: false
        anchors.centerIn: parent
    }

    function updateProfile() {
        var data = {
            "firstName": firstNameField.text,
            "lastName": lastNameField.text
        }
        loadingIndicator.running = true
        apiClient.put(ApiEndpoints.profile, data, function(response) {
            loadingIndicator.running = false
            if (response.success) {
                user.firstName = firstNameField.text
                user.lastName = lastNameField.text
                console.log("Profile updated")
            } else {
                console.log("Update failed: " + response.message)
            }
        })
    }

    function uploadImage() {
        // File picker implementation (use FileDialog from QtQuick.Dialogs)
        console.log("Upload logic - PUT /api/user/profile-image with form data")
    }

    function removeImage() {
        loadingIndicator.running = true
        apiClient.deleteMethod(ApiEndpoints.removeProfileImage, function(response) {
            loadingIndicator.running = false
            if (response.success) {
                user.profileImage = ""
                console.log("Image removed")
            } else {
                console.log("Remove failed: " + response.message)
            }
        })
    }

    function changePasswordFunction() {
        var data = {
            "currentPassword": currentPassword.text,
            "newPassword": newPassword.text
        }
        loadingIndicator.running = true
        apiClient.post(ApiEndpoints.changePassword, data, function(response) {
            loadingIndicator.running = false
            if (response.success) {
                currentPassword.text = ""
                newPassword.text = ""
                console.log("Password changed")
            } else {
                console.log("Change failed: " + response.message)
            }
        })
    }
}
