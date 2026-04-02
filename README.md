# Vehicle Service & Maintenance Tracker App

A complete, production-ready Flutter application designed to help vehicle owners manage service schedules, maintenance history, and expenses offline. Built for the 6th Semester B.Tech (IT) Internal Exam Project.

## Features

- **Offline-First Storage**: Uses fast NoSQL Hive database to store all information directly on the device.
- **Vehicle Management**: Add multiple vehicles and track details.
- **Expense Analytics**: Meaningful visual breakdowns of money spent using `fl_chart`.
- **Reminder System**: Tracks upcoming services and pushes local notifications logic.
- **Service Center Booking (Mock)**: Displays mock local garages with booking confirmations.
- **Clean Architecture**: Utilizes `provider` for robust State Management and separate scalable modules for services, screens, and models.

## Setup Steps

1. **Prerequisites**: Ensure you have Flutter SDK installed (tested on standard Flutter stable).
2. **Clone/Unpack Project**: Open the extracted directory in your IDE of choice (VSCode/Android Studio).
3. **Fetch Dependencies**:
   ```bash
   flutter pub get
   ```
4. **Generate Hive Models** (if you modify the existing models later):
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```
5. **Run the Application**:
   ```bash
   flutter run
   ```

## Screenshots Placeholder
*(Replace these text blocks with actual image links after deployment)*
- [Dashboard Screen Screenshot]
- [Vehicle Listing Screenshot]
- [Expense Analytics Chart Screenshot]
- [Service Centers Booking Screen Screenshot]

## Architectural Outline
- **State**: Handled by lightweight, single-responsibility Providers (`VehicleProvider`, `ExpenseProvider`, `ReminderProvider`).
- **Data Layer**: Hive Box definitions are abstracted away behind `HiveService`.
- **UI UX**: Adheres firmly to Material 3 standard theming guidelines (Dark mode responsive).
