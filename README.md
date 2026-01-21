# 🔵 BlueConnect
### Flutter BLE Scanner with Secure Spring Boot Authentication


**BlueConnect** is a production-ready Flutter mobile application that scans and connects to **Bluetooth Low Energy (BLE) devices**, integrated with a **Spring Boot backend** featuring **secure JWT authentication** and **MySQL database**, deployed on **Railway**.

This project showcases **full-stack mobile + backend integration**, secure API communication, and release APK deployment for real-world production use.

## 🚀 Key Features

### 📱 Flutter Mobile App
- 🔍 BLE device discovery, scanning & connection using `flutter_blue_plus`
- 🔐 Secure user registration & login with JWT token management
- 💾 Secure token storage using `SharedPreferences`
- 🌐 HTTPS API communication with automatic token refresh
- 📦 Production-ready release APK build
- 📱 Optimized for physical Android devices

### 🌐 Spring Boot Backend
- 🔒 Spring Security with JWT authentication & authorization
- 🗄️ MySQL database with JPA/Hibernate ORM
- ⚙️ RESTful API design following best practices
- 🌍 CORS enabled for Flutter cross-origin requests
- 🚀 Deployed on Railway with zero-downtime scaling
- 🛡️ Password hashing with BCrypt

## 🏗️ System Architecture

```
Flutter APK (Android) 
       ↓ HTTPS + JWT
Spring Boot REST API (Railway)
       ↓ JDBC
   MySQL Database (Railway)
```

## 📱 Screenshots

| Login Screen | Register Screen | BLE Scanner | Connected Devices |
|--------------|-----------------|-------------|-------------------|
|  |  |  |  |

*(Replace placeholder URLs with your actual screenshots from `/screenshots/` folder)*

## 🛠️ Tech Stack

| Category | Technologies |
|----------|--------------|
| **Frontend** | Flutter 3.x, Dart, flutter_blue_plus, http, shared_preferences |
| **Backend** | Spring Boot 3.x, Spring Security, JPA/Hibernate, JWT, Java 17+ |
| **Database** | MySQL 8.x |
| **Deployment** | Render (Backend) + Railway (DB), GitHub Actions |
| **Tools** | Postman, Android Studio, VS Code |

## 🔗 API Documentation

### Base URL
```
[https://springboot-register.onrender.com/api]
```

### Authentication Endpoints

#### Register User
```http
POST /api/register
Content-Type: application/json

{
  "firstName": "John",
  "lastName": "Doe", 
  "email": "john@example.com",
  "password": "SecurePass123!"
}
```

#### Login User
```http
POST /api/login
Content-Type: application/json

{
  "username": "john@example.com",
  "password": "SecurePass123!"
}
```
**Response:**
```json
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "type": "Bearer",
  "expiresIn": 86400
}
```

## 🚀 Quick Start

### Backend Setup (Railway - Already Deployed MySQL) & (Render - Deployed Springboot)
```
✅ Live: [https://springboot-register.onrender.com/api]
✅ Database: MySQL 8.x (Railway managed)
```

### Flutter App Setup
```bash
# Clone repository
git clone https://github.com/Sriman-Kabilan/Flutter_BLE_Scanner.git
cd Flutter_BLE_Scanner

# Update base URL in lib/services/api_service.dart
const String baseUrl = [https://springboot-register.onrender.com/api];

# Install dependencies
flutter pub get

# Android permissions (android/app/src/main/AndroidManifest.xml)
flutter build apk --release
```

### Android Permissions Required
```xml
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.BLUETOOTH"/>
<uses-permission android:name="android.permission.BLUETOOTH_ADMIN"/>
<uses-permission android:name="android.permission.BLUETOOTH_SCAN"/>
<uses-permission android:name="android.permission.BLUETOOTH_CONNECT"/>
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
```

## 📦 Build & Deploy

### Release APK
```bash
flutter clean
flutter pub get
flutter build apk --release
```
**Output:** `build/app/outputs/flutter-apk/app-release.apk`

### Backend (Railway)
```
✅ Auto-deployed from GitHub
✅ Environment variables configured
✅ MySQL database provisioned
```

## ✅ Tested On
- ✅ Android Emulator (API 30+)
- ✅ Physical Android devices (API 26+)
- ✅ Postman API testing
- ✅ Release APK installation
- ✅ Network changes (WiFi/Mobile Data)

## 🔐 Security Features
- 🔐 JWT-based stateless authentication
- 🛡️ BCrypt password hashing
- 🔒 HTTPS enforced communication
- 🗝️ Secure token storage (SharedPreferences)
- 🚫 Secrets excluded (.gitignore)
- 🌍 CORS properly configured

## 📂 Repository Structure

```
Flutter_BLE_Scanner/
├── lib/
│   ├── models/         # User, Device models
│   ├── services/       # API, BLE, Auth services
│   ├── screens/        # UI screens
│   └── main.dart
├── android/            # Android configuration
└── pubspec.yaml

springboot-register/
├── src/main/java/      # Controllers, Services, Entities
├── src/main/resources/ # application.yml
└── pom.xml
```

## 🧪 Repositories

| Component | Repository | Status |
|-----------|------------|--------|
| **Flutter App** | [ | Active |
| **Spring Boot** | [ | Active |

## 🌟 Why This Project Stands Out
- ✅ **Production-Ready**: Release APK + Cloud deployment
- ✅ **Secure**: JWT auth, HTTPS, BCrypt hashing
- ✅ **Scalable**: Railway deployment with managed DB
- ✅ **Modern Stack**: Flutter 3.x + Spring Boot 3.x
- ✅ **Real-World**: BLE integration + full auth flow
- ✅ **Clean Code**: Proper architecture & documentation

## 📜 License
This project is licensed under the [MIT License](LICENSE).


## 👨‍💻 Author
**Sriman Kabilan**  



## 🚀 Future Enhancements
- 🔔 Firebase Push Notifications
- 📡 Real-time BLE data streaming
- 🧠 AI-powered device analytics
- 🔄 Refresh token implementation
- 🧪 Automated testing (Flutter + Spring Boot)
- 📱 iOS support

***


  
⭐ **If you found this project helpful, please give it a star on GitHub!** ⭐
