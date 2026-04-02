import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import 'vehicle_list_screen.dart';
import 'expense_charts_screen.dart';
import 'profile_screen.dart'; // We'll put Reminders List inside the Profile screen or call it Profile.

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const VehicleListScreen(),
    const ExpenseChartsScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      extendBody: true, // For floating bottom nav bar appearance over background
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: NavigationBar(
            selectedIndex: _currentIndex,
            onDestinationSelected: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            backgroundColor: Colors.white,
            indicatorColor: const Color(0xFF4F46E5).withValues(alpha: 0.15),
            elevation: 0,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home, color: Color(0xFF4F46E5)),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.directions_car_filled_outlined),
                selectedIcon: Icon(Icons.directions_car, color: Color(0xFF4F46E5)),
                label: 'Vehicles',
              ),
              NavigationDestination(
                icon: Icon(Icons.account_balance_wallet_outlined),
                selectedIcon: Icon(Icons.account_balance_wallet, color: Color(0xFF4F46E5)),
                label: 'Expenses',
              ),
              NavigationDestination(
                icon: Icon(Icons.person_outline),
                selectedIcon: Icon(Icons.person, color: Color(0xFF4F46E5)),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
