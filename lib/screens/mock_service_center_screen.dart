import 'package:flutter/material.dart';

class MockServiceCenterScreen extends StatelessWidget {
  const MockServiceCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy static data for service centers
    final serviceCenters = [
      {'name': 'AutoCare Pro Garage', 'distance': '2.5 km', 'rating': '4.8'},
      {'name': 'Speedy Lube & Service', 'distance': '4.0 km', 'rating': '4.5'},
      {'name': 'Elite Motors Workshop', 'distance': '6.2 km', 'rating': '4.9'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearby Service Centers'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: serviceCenters.length,
        itemBuilder: (context, index) {
          final center = serviceCenters[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        center['name']!,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          const SizedBox(width: 4),
                          Text(center['rating']!),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(center['distance']!, style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        _showBookingConfirmation(context, center['name']!);
                      },
                      child: const Text('Book Appointment'),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showBookingConfirmation(BuildContext context, String garageName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Booking Confirmed'),
        content: Text('Your appointment at $garageName has been successfully requested. They will contact you shortly.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
