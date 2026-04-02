import 'package:flutter/material.dart';
import '../models/vehicle.dart';
import '../models/service_record.dart';
import '../services/hive_service.dart';

class VehicleProvider with ChangeNotifier {
  List<Vehicle> _vehicles = [];
  List<ServiceRecord> _serviceRecords = [];

  List<Vehicle> get vehicles => _vehicles;
  List<ServiceRecord> get serviceRecords => _serviceRecords;

  VehicleProvider() {
    _loadData();
  }

  void _loadData() {
    _vehicles = HiveService.vehiclesBox.values.toList();
    _serviceRecords = HiveService.serviceRecordsBox.values.toList();
    
    if (_vehicles.isEmpty) {
      _addDummyData();
    }
    notifyListeners();
  }

  void _addDummyData() {
    final dummyVehicle = Vehicle(
      name: 'Honda Civic',
      model: '2022',
      registrationNumber: 'AB-12-CD-3456',
      purchaseDate: DateTime.now().subtract(const Duration(days: 365)),
      fuelType: 'Petrol',
    );
    addVehicle(dummyVehicle);
    
    final dummyService = ServiceRecord(
      vehicleId: dummyVehicle.id,
      serviceDate: DateTime.now().subtract(const Duration(days: 30)),
      serviceType: 'Oil Change',
      notes: 'Standard synthetic oil replacement.',
      cost: 55.0,
    );
    addServiceRecord(dummyService);
  }

  Future<void> addVehicle(Vehicle vehicle) async {
    await HiveService.vehiclesBox.put(vehicle.id, vehicle);
    _vehicles.add(vehicle);
    notifyListeners();
  }

  Future<void> updateVehicle(Vehicle vehicle) async {
    await vehicle.save();
    notifyListeners();
  }

  Future<void> deleteVehicle(Vehicle vehicle) async {
    await vehicle.delete();
    // Cascade delete services
    final relatedServices = _serviceRecords.where((s) => s.vehicleId == vehicle.id).toList();
    for (var s in relatedServices) {
      await s.delete();
      _serviceRecords.remove(s);
    }
    _vehicles.remove(vehicle);
    notifyListeners();
  }

  List<ServiceRecord> getServicesForVehicle(String vehicleId) {
    return _serviceRecords.where((s) => s.vehicleId == vehicleId).toList();
  }

  Future<void> addServiceRecord(ServiceRecord record) async {
    await HiveService.serviceRecordsBox.put(record.id, record);
    _serviceRecords.add(record);
    notifyListeners();
  }
}
