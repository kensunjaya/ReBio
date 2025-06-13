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
