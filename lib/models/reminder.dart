import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'reminder.g.dart';

@HiveType(typeId: 3)
class Reminder extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String vehicleId;

  @HiveField(2)
  String title;

  @HiveField(3)
  DateTime dueDate;

  @HiveField(4)
  bool isCompleted;

  Reminder({
    String? id,
    required this.vehicleId,
    required this.title,
    required this.dueDate,
    this.isCompleted = false,
  }) : id = id ?? const Uuid().v4();
}
