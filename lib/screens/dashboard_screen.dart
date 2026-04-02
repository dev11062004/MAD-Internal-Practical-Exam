import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/vehicle_provider.dart';
import '../providers/reminder_provider.dart';
import '../providers/expense_provider.dart';
import '../widgets/web_max_width_container.dart';
import 'package:intl/intl.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vehicleProvider = Provider.of<VehicleProvider>(context);
    final reminderProvider = Provider.of<ReminderProvider>(context);
    final expenseProvider = Provider.of<ExpenseProvider>(context);
    
    double totalExpenses = expenseProvider.expenses.fold(0.0, (sum, exp) => sum + exp.amount);

    return Scaffold(
      body: SafeArea(
        child: WebMaxWidthContainer(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 100), // extra bottom padding for floating bar
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTopSection(context),
                const SizedBox(height: 32),
                _buildSummaryCards(context, vehicleProvider.vehicles.length, reminderProvider.reminders.length, totalExpenses),
                const SizedBox(height: 32),
                Text('Upcoming Reminders', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                _buildRemindersList(context, reminderProvider),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Good Morning,', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey.shade600)),
            Text('User', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold, color: Colors.black87)),
          ],
        ),
        Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              )
            ]
          ),
          child: const Icon(Icons.person, color: Color(0xFF4F46E5)),
        ),
      ],
    );
  }

  Widget _buildSummaryCards(BuildContext context, int vehicles, int upcomingServices, double expenses) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      clipBehavior: Clip.none,
      child: Row(
        children: [
          _buildGradientCard(
            context, 
            title: 'Total\nVehicles', 
            val: '$vehicles', 
            icon: Icons.directions_car, 
            colors: [const Color(0xFF4F46E5), const Color(0xFF818CF8)]
          ),
          const SizedBox(width: 16),
          _buildGradientCard(
            context, 
            title: 'Upcoming\nServices', 
            val: '$upcomingServices', 
            icon: Icons.build_circle, 
            colors: [const Color(0xFF22C55E), const Color(0xFF4ADE80)]
          ),
          const SizedBox(width: 16),
          _buildGradientCard(
            context, 
            title: 'Total\nExpenses', 
            val: '\$${expenses.toStringAsFixed(0)}', 
            icon: Icons.account_balance_wallet, 
            colors: [const Color(0xFFF59E0B), const Color(0xFFFCD34D)]
          ),
        ],
      ),
    );
  }

  Widget _buildGradientCard(BuildContext context, {required String title, required String val, required IconData icon, required List<Color> colors}) {
    return Container(
      width: 140,
      height: 160,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: colors[0].withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          )
        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(height: 12),
          Text(title, style: const TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w500)),
          Text(val, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildRemindersList(BuildContext context, ReminderProvider provider) {
    final pending = provider.reminders.where((r) => !r.isCompleted).toList();
    if (pending.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 10, offset: const Offset(0, 4))]
        ),
        child: const Center(child: Text('All caught up!', style: TextStyle(color: Colors.grey))),
      );
    }
    return Column(
      children: pending.map((reminder) {
        bool isUrgent = reminder.dueDate.isBefore(DateTime.now().add(const Duration(days: 3)));
        return _buildReminderStyledCard(context, reminder.title, DateFormat.yMMMd().format(reminder.dueDate), isUrgent);
      }).toList(),
    );
  }

  Widget _buildReminderStyledCard(BuildContext context, String title, String date, bool isUrgent) {
    Color statusColor = isUrgent ? const Color(0xFFEF4444) : const Color(0xFFEAB308); // Red = Urgent, Yellow = Upcoming
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 10, offset: const Offset(0, 4))]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(width: 4, height: 40, decoration: BoxDecoration(color: statusColor, borderRadius: BorderRadius.circular(4))),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 4),
                  Text('Due: $date', style: const TextStyle(color: Colors.grey, fontSize: 13)),
                ],
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(isUrgent ? 'Urgent' : 'Upcoming', style: TextStyle(color: statusColor, fontSize: 12, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }
}
