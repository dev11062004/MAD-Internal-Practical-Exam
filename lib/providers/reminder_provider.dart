import 'package:flutter/material.dart';
import '../models/reminder.dart';
import '../services/hive_service.dart';
import '../services/notification_service.dart';

class ReminderProvider with ChangeNotifier {
  List<Reminder> _reminders = [];

  List<Reminder> get reminders => _reminders;

  ReminderProvider() {
    _loadData();
  }

  void _loadData() {
    _reminders = HiveService.remindersBox.values.toList();
    if (_reminders.isEmpty) {
      _addDummyData();
    }
    notifyListeners();
  }

  void _addDummyData() {
    final r1 = Reminder(
      vehicleId: 'dummy_vehicle_1',
      title: 'Oil Change',
      dueDate: DateTime.now().add(const Duration(days: 10)),
    );
    addReminder(r1);
  }

  Future<void> addReminder(Reminder reminder) async {
    await HiveService.remindersBox.put(reminder.id, reminder);
    _reminders.add(reminder);
    
    // Schedule generic notification
    final notifId = reminder.id.hashCode;
    if (reminder.dueDate.isAfter(DateTime.now())) {
      await NotificationService.scheduleNotification(
        id: notifId, 
        title: 'Vehicle Reminder: ${reminder.title}', 
        body: 'Your service is due soon!', 
        scheduledDate: reminder.dueDate,
      );
    }
    notifyListeners();
  }

  Future<void> completeReminder(Reminder reminder) async {
    reminder.isCompleted = true;
    await reminder.save();
    // Cancel notification could be implemented here if storing the ID
    notifyListeners();
  }
}
