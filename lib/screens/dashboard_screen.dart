import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/vehicle_provider.dart';
import '../providers/reminder_provider.dart';
import 'package:intl/intl.dart';
import 'add_vehicle_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vehicleProvider = Provider.of<VehicleProvider>(context);
    final reminderProvider = Provider.of<ReminderProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              // Notification center logic if needed
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSummaryCard(context, vehicleProvider.vehicles.length),
            const SizedBox(height: 24),
            Text('Quick Actions', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            _buildQuickActions(context),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('My Vehicles', style: Theme.of(context).textTheme.titleLarge),
              TextButton.icon(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const AddEditVehicleScreen()));
                }, 
                icon: const Icon(Icons.add), 
                label: const Text('Add Vehicle')
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildVehicleList(context, vehicleProvider),
          const SizedBox(height: 24),
          Text('Upcoming Reminders', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          _buildRemindersList(context, reminderProvider),
        ],
      ),
    ),
  );
}

Widget _buildVehicleList(BuildContext context, VehicleProvider provider) {
  if (provider.vehicles.isEmpty) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('No vehicles tracked yet! Add one above.'),
      ),
    );
  }
  return Column(
    children: provider.vehicles.map((v) {
      return Card(
        margin: const EdgeInsets.only(bottom: 8),
        child: ListTile(
          leading: const Icon(Icons.directions_car, color: Colors.blueGrey),
          title: Text('${v.name} (${v.model})'),
          subtitle: Text(v.registrationNumber),
        ),
      );
    }).toList(),
  );
}

  Widget _buildSummaryCard(BuildContext context, int count) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome back!',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'You are tracking $count vehicle${count == 1 ? '' : 's'}.',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _ActionItem(icon: Icons.add, label: 'Add Service', onTap: () {}),
        _ActionItem(icon: Icons.local_gas_station, label: 'Add Fuel', onTap: () {}),
        _ActionItem(icon: Icons.alarm_add, label: 'Reminder', onTap: () {}),
      ],
    );
  }

  Widget _buildRemindersList(BuildContext context, ReminderProvider provider) {
    final pending = provider.reminders.where((r) => !r.isCompleted).toList();
    if (pending.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('No upcoming reminders.'),
        ),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: pending.length,
      itemBuilder: (context, index) {
        final reminder = pending[index];
        return Card(
          elevation: 0,
          color: Theme.of(context).colorScheme.surfaceVariant,
          child: ListTile(
            leading: const Icon(Icons.warning_amber_rounded, color: Colors.orange),
            title: Text(reminder.title),
            subtitle: Text('Due: ${DateFormat.yMMMd().format(reminder.dueDate)}'),
            trailing: IconButton(
              icon: const Icon(Icons.check_circle_outline),
              onPressed: () {
                provider.completeReminder(reminder);
              },
            ),
          ),
        );
      },
    );
  }
}

class _ActionItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionItem({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Column(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            child: Icon(icon, color: Theme.of(context).colorScheme.primary),
          ),
          const SizedBox(height: 8),
          Text(label, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}
