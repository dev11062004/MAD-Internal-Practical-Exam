# 🚗 Vehicle Service & Maintenance Tracker

> A comprehensive, flutter-based mobile application designed to simplify the management of personal vehicles, service schedules, and maintenance expenses.

---

## 📖 Overview

Keeping track of multiple vehicles, monitoring routine service schedules, and analyzing maintenance expenses can quickly become tedious and prone to human error. **Vehicle Service & Maintenance Tracker** is a dedicated solution built to solve these problems by providing users with an intuitive interface to effectively catalog their vehicles, receive timely reminders for upcoming services, and visualize their maintenance expenditure.

---

## ✨ Features

- **🚘 Vehicle Management**: Easily add, edit, and keep a digital garage of your vehicles with details like Registration Number, Make, Model, and purchase date.
- **🛠️ Service History Tracking**: Log dedicated entries for every service interaction including cost metrics, service centers, and technical notes.
- **⏰ Reminder System**: Intelligent alerts for upcoming services or renewals to never miss a due date again.
- **📊 Expense Analytics**: Comprehensive charting visualizer mapping your expenditures month-to-month and categorically.
- **🏪 Service Center Booking**: Easily locate and request appointments with mocked local mechanic and garaging centers.
- **🔌 Offline Support**: Fully capable architecture powered by an embedded local persistence layer so zero cloud interactions are required out-of-the-box.

---

## 📱 Screenshots

These represent the application's core functionality including analytics, logging history, and the dashboard.

| Dashboard Interface | Profile & Services |
| :---: | :---: |
| ![Dashboard](screenshots/dashboard.jpg) | ![Profile Services](screenshots/profile_booking.jpg) |

| Vehicle Detail (Honda Civic) | Add Service Record |
| :---: | :---: |
| ![Vehicle Detail](screenshots/vehicle_detail.jpg) | ![Add Service](screenshots/add_service.jpg) |

---

## 💻 Tech Stack

- **Framework**: [Flutter](https://flutter.dev/) (Cross-Platform Execution)
- **Language**: [Dart](https://dart.dev/)
- **Local Database**: [Hive](https://pub.dev/packages/hive) / SQLite (NoSQL / SQL Abstraction)
- **State Management**: [Provider](https://pub.dev/packages/provider)
- **Charting**: [fl_chart](https://pub.dev/packages/fl_chart)

---

## 📂 Project Structure

```text
lib/
 ├── models/          # Data schemas (Vehicle, Expense, Reminder, etc.)
 ├── screens/         # UI Screen displays (Dashboard, Analytics, etc.)
 ├── services/        # Logic handlers and external module interactions
 ├── widgets/         # Reusable UI components (Containers, Cards, etc.)
 └── main.dart        # Core initialization & Routing
```

---

## 🚀 Installation & Setup

Want to run the project locally? Follow these simple steps:

1. **Clone the repository:**
   ```bash
   git clone https://github.com/yourusername/MAD-Internal-Practical-Exam.git
   cd MAD-Internal-Practical-Exam
   ```

2. **Fetch all dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run the application:**
   You can run this project flawlessly locally in a web preview.
   ```bash
   flutter run -d chrome
   ```

---

## 📝 GitHub Commit Structure

This project was built out in a modular execution format to ensure stability across features. The commit evolution reflects:

1. **Initialization**: Scaffolding directories, packages configuration, and theme engine.
2. **Vehicle Module**: Architecture modeling, Hive injection, and `VehicleList`/`Detail` UI hooks.
3. **Reminder System**: Core CRUD features for time-based reminder notifications.
4. **Analytics & UI**: Integration of the `fl_chart` mechanics, aesthetic overhauls, and the master `DashboardScreen`.

---

## 🔮 Future Enhancements

- ☁️ **Cloud Sync**: Optional Firebase hooking for cross-device authentication and data syncing.
- 🔔 **Push Notifications**: Native background triggers utilizing FCM (Firebase Cloud Messaging) or native device reminders.
- 🗺️ **Live API Integration**: Auto-fetching true vehicle data through VIN endpoints and live geolocation mapping for service centers.

---

## 👤 Author

**Name**: User
**Course**: IT366 Mobile Application Development
