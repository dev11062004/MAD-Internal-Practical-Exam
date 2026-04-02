import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'service_record.g.dart';

@HiveType(typeId: 1)
class ServiceRecord extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String vehicleId;

  @HiveField(2)
  DateTime serviceDate;

  @HiveField(3)
  String serviceType;

  @HiveField(4)
  String notes;

  @HiveField(5)
  double cost;

  ServiceRecord({
    String? id,
    required this.vehicleId,
    required this.serviceDate,
    required this.serviceType,
    required this.notes,
    required this.cost,
  }) : id = id ?? const Uuid().v4();
}
