import 'package:hive_flutter/hive_flutter.dart';
import '../models/vehicle.dart';
import '../models/service_record.dart';
import '../models/expense.dart';
import '../models/reminder.dart';

class HiveService {
  static const String vehiclesBoxName = 'vehicles';
  static const String serviceRecordsBoxName = 'serviceRecords';
  static const String expensesBoxName = 'expenses';
  static const String remindersBoxName = 'reminders';

  static Future<void> initHive() async {
    await Hive.initFlutter();
    
    // Register Adapters
    Hive.registerAdapter(VehicleAdapter());
    Hive.registerAdapter(ServiceRecordAdapter());
    Hive.registerAdapter(ExpenseAdapter());
    Hive.registerAdapter(ReminderAdapter());

    // Open Boxes
    await Hive.openBox<Vehicle>(vehiclesBoxName);
    await Hive.openBox<ServiceRecord>(serviceRecordsBoxName);
    await Hive.openBox<Expense>(expensesBoxName);
    await Hive.openBox<Reminder>(remindersBoxName);
  }

  // Get Boxes
  static Box<Vehicle> get vehiclesBox => Hive.box<Vehicle>(vehiclesBoxName);
  static Box<ServiceRecord> get serviceRecordsBox => Hive.box<ServiceRecord>(serviceRecordsBoxName);
  static Box<Expense> get expensesBox => Hive.box<Expense>(expensesBoxName);
  static Box<Reminder> get remindersBox => Hive.box<Reminder>(remindersBoxName);
}
