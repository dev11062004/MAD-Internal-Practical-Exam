import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/vehicle_provider.dart';
import '../models/vehicle.dart';
import 'add_service_screen.dart';

class VehicleDetailScreen extends StatelessWidget {
  final Vehicle vehicle;

  const VehicleDetailScreen({super.key, required this.vehicle});

  @override
  Widget build(BuildContext context) {
    final vehicleProvider = Provider.of<VehicleProvider>(context);
    final services = vehicleProvider.getServicesForVehicle(vehicle.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(vehicle.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: ListTile(
                title: const Text('Vehicle Details'),
                subtitle: Text('Model: ${vehicle.model}\nReg No: ${vehicle.registrationNumber}\nFuel: ${vehicle.fuelType}'),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Service History', style: Theme.of(context).textTheme.titleLarge),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => AddServiceScreen(vehicleId: vehicle.id)),
                    );
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add Service'),
                )
              ],
            ),
            const SizedBox(height: 16),
            services.isEmpty
                ? const Text('No service completely recorded yet.')
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: services.length,
                    itemBuilder: (context, index) {
                      final service = services[index];
                      return Card(
                        child: ListTile(
                          title: Text(service.serviceType),
                          subtitle: Text(service.notes),
                          trailing: Text('\$${service.cost.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
