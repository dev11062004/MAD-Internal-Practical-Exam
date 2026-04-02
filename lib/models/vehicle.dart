import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'vehicle.g.dart';

@HiveType(typeId: 0)
class Vehicle extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String model;

  @HiveField(3)
  String registrationNumber;

  @HiveField(4)
  DateTime purchaseDate;

  @HiveField(5)
  String fuelType;

  Vehicle({
    String? id,
    required this.name,
    required this.model,
    required this.registrationNumber,
    required this.purchaseDate,
    required this.fuelType,
  }) : id = id ?? const Uuid().v4();
}
