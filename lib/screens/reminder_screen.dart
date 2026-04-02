import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/reminder_provider.dart';
import '../widgets/web_max_width_container.dart';

class ReminderScreen extends StatelessWidget {
  const ReminderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final reminderProvider = Provider.of<ReminderProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Reminders'),
        automaticallyImplyLeading: false,
      ),
      body: WebMaxWidthContainer(
        child: reminderProvider.reminders.isEmpty
            ? Center(
                child: Text(
                  'No reminders set.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 16),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(20.0),
                itemCount: reminderProvider.reminders.length,
                itemBuilder: (context, index) {
                  final reminder = reminderProvider.reminders[index];
                  bool isUrgent = reminder.dueDate.isBefore(DateTime.now().add(const Duration(days: 3))) && !reminder.isCompleted;
                  Color statusColor = reminder.isCompleted 
                      ? const Color(0xFF22C55E)
                      : (isUrgent ? const Color(0xFFEF4444) : const Color(0xFFEAB308));
                  
                  String statusText = reminder.isCompleted ? 'Completed' : (isUrgent ? 'Urgent' : 'Upcoming');

                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 15,
                          offset: const Offset(0, 6),
                        )
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            if (!reminder.isCompleted) {
                              reminderProvider.markAsCompleted(reminder.id);
                            }
                          },
                          child: Container(
                            height: 28,
                            width: 28,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: reminder.isCompleted ? const Color(0xFF22C55E) : Colors.white,
                              border: Border.all(
                                color: reminder.isCompleted ? const Color(0xFF22C55E) : Colors.grey.shade400,
                                width: 2,
                              ),
                            ),
                            child: reminder.isCompleted ? const Icon(Icons.check, size: 18, color: Colors.white) : null,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                reminder.title,
                                style: TextStyle(
                                  fontSize: 18, 
                                  fontWeight: FontWeight.bold, 
                                  color: Colors.black87,
                                  decoration: reminder.isCompleted ? TextDecoration.lineThrough : null,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  const Icon(Icons.event, size: 14, color: Colors.grey),
                                  const SizedBox(width: 4),
                                  Text(
                                    DateFormat.yMMMd().format(reminder.dueDate),
                                    style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: statusColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            statusText, 
                            style: TextStyle(color: statusColor, fontSize: 13, fontWeight: FontWeight.bold)
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
