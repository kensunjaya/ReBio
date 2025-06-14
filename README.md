# 🌱 ReBio

ReBio is a mobile application built with Flutter and Firebase for Eco-Enzyme Monitoring System integrated with IoT technology. A smart and eco-friendly solution to transform organic waste into valuable products like eco-enzyme and biogas


## 🚀 Features
🔒 Firebase Authentication integration

📊 History Log: Automatically track your eco-enzyme progress and activity timeline — never lose sight of your past records.

💡 Personalized Recommendations: Get intelligent suggestions on what to do next based on your current eco-enzyme condition and activity logs.

🔍 Smart Monitoring System: Monitor your eco-enzyme’s fermentation status, progress, and estimated readiness using a built-in tracking assistant.

## 🛠 Tech Stack
- Dart
- Flutter 3+
- Firebase Auth (via firebase_auth)

## 📸 Snapshots
Register page UI
![Screenshot 2025-06-14 195155](https://github.com/user-attachments/assets/b8438fd2-b375-40b9-b4db-e04c52df2ecf)
Login page UI
![Screenshot 2025-06-14 195204](https://github.com/user-attachments/assets/54c6d533-471a-4479-bec2-e2241a8b2f52)
Home page UI
![Screenshot 2025-06-14 195228](https://github.com/user-attachments/assets/c59b2478-48bd-4718-b26c-abf2649a456c)


## 📦 Setup
1. Clone the repository:
   ```
   git clone https://github.com/kensunjaya/ReBio.git
   cd ReBio
   ```
2. Install dependencies:
   ```
   flutter pub get
   ```
3. Connect to Firebase:

    - Create a Firebase project at https://console.firebase.google.com

    - Add an Android/iOS app and configure your app's google-services.json / GoogleService-Info.plist

    - Enable "Email/Password" and optionally Google/Facebook/Apple providers in Firebase Authentication
4. Run the app
   ```
   flutter run
   ```
## 📁 Project Structure
| File / Folder        | Description                                           |
|----------------------|-------------------------------------------------------|
`lib/`
|├─ auth.dart          | Firebase authentication logic
|├─ main.dart          | App entry point
|├─ login.dart         | Login page UI
|├─ register.dart      | Registration UI
|├─ home.dart          | Monitoring system from the eco enzyme station
|├─ recommendation.dart          | Recommendation Page
|├─ history.dart          | See user contribution log
|└─ FillToDo.dart          | User To Do list

## 🧑‍💻 Contributing
  - Create a branch: `git checkout -b my-feature`

  - Commit changes: `git commit -am 'Add new feature'`

  - Push to branch: `git push origin my-feature`

  - Open a Pull Request
