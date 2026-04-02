import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

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
    const Color primaryColor = Color(0xFF4F46E5); // Indigo
    const Color secondaryColor = Color(0xFF22C55E); // Green
    const Color bgColor = Color(0xFFF9FAFB); // Light Grey

    return MaterialApp(
      title: 'Vehicle Service & Maintenance Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: bgColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          primary: primaryColor,
          secondary: secondaryColor,
          surface: Colors.white,
          brightness: Brightness.light,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        appBarTheme: AppBarTheme(
          centerTitle: true,
          elevation: 0,
          backgroundColor: bgColor,
          foregroundColor: Colors.black87,
          titleTextStyle: GoogleFonts.poppins(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      home: const MainScreen(),
    );
  }
}
