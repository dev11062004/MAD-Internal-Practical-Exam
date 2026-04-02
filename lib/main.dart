import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'services/hive_service.dart';
import 'services/notification_service.dart';
import 'providers/vehicle_provider.dart';
import 'providers/expense_provider.dart';
import 'providers/reminder_provider.dart';
import 'screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Local Notifications and Timezone
  await NotificationService.init();

  // Initialize Hive
  await HiveService.initHive();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => VehicleProvider()),
        ChangeNotifierProvider(create: (_) => ExpenseProvider()),
        ChangeNotifierProvider(create: (_) => ReminderProvider()),
      ],
      child: const VehicleMaintenanceApp(),
    ),
  );
}

class VehicleMaintenanceApp extends StatelessWidget {
  const VehicleMaintenanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vehicle Service & Maintenance Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue.shade800,
          brightness: Brightness.light,
        ),
        fontFamily: 'Inter',
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue.shade800,
          brightness: Brightness.dark,
        ),
        fontFamily: 'Inter',
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
        ),
      ),
      home: const MainScreen(),
    );
  }
}
