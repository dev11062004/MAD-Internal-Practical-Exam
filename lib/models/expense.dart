import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'expense.g.dart';

@HiveType(typeId: 2)
class Expense extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String vehicleId;

  @HiveField(2)
  DateTime date;

  @HiveField(3)
  String category;

  @HiveField(4)
  double amount;

  @HiveField(5)
  String description;

  Expense({
    String? id,
    required this.vehicleId,
    required this.date,
    required this.category,
    required this.amount,
    required this.description,
  }) : id = id ?? const Uuid().v4();
}
