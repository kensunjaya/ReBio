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
### Register page UI

![Register](https://github.com/user-attachments/assets/650604e5-4a00-4d06-8191-b57c7e314834)

### Login page UI

![Login](https://github.com/user-attachments/assets/278a93d3-e42e-44c6-9dc4-3c1e6a029c9b)

### Home page UI

![Home](https://github.com/user-attachments/assets/055def16-ff5b-4424-89d3-d01800c9a281)

### Recommendation Page UI

![Recommendation](https://github.com/user-attachments/assets/4a3d2326-a384-4f06-8a1b-de7c83299ba4)

### History Page UI

![History](https://github.com/user-attachments/assets/18dbbaca-b6c5-427f-9d86-66aecc7b1553)

### Fill To Do Page UI

![Fill To Do](https://github.com/user-attachments/assets/65c61b8e-7934-4bb4-ba9a-780d369753c3)

### Profile Page UI

![Profile](https://github.com/user-attachments/assets/36aa00ec-2735-40bf-ac1f-8c343b6f4e96)

### Profile Others

![Profile Others](https://github.com/user-attachments/assets/c97b97c7-0b09-4b5e-b198-418085dfb325)

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
