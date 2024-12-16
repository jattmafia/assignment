# **Flutter App Documentation**

## **Overview**
This is a Flutter-based app that includes a login feature, profile display, dropdown for city selection, and integration with Hive for local storage. The app is built with clean architecture principles and uses state management to provide a seamless user experience.

---

## **How to Run the App**

### **Prerequisites**
1. Ensure you have Flutter installed on your system. Refer to the [Flutter installation guide](https://flutter.dev/docs/get-started/install).
2. Verify installation by running:
   ```bash
   flutter doctor

3. Run flutter run


## **Assumptions made**

1. User Authentication:

The app assumes either a phone number or email can be used for login.
Password validation is done locally, and no backend integration is included in this version.

2. City Dropdown:

The dropdown includes a predefined list of Indian cities.
The list is static and does not fetch data dynamically from a remote source.

3. Hive Storage:

User data is saved locally using Hive.
The key for Hive storage is assumed to be the user's email for identifying unique users.

3. Date of Birth:

The dob field is a string in YYYY-MM-DD format. Date validation is done manually if needed.

4. State Management:

The app uses the Provider package for managing state.

## **State Management Approach**

The app employs Provider for state management.

## Why Provider?

Simple to use and integrates seamlessly with Flutter.
Ideal for managing app-wide states like user login status, profile data, and other dynamic states.

## Implementation:

AuthProvider: Handles authentication logic (e.g., login, logout).

ProfileProvider: Manages user profile data.

## How It Works
Login Screen:

Uses AuthProvider to validate the user and set the logged-in state.

Profile Screen:

Retrieves user data from ProfileProvider.

City Dropdown:

No state management required as it is handled locally within the widget.



