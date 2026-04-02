import 'package:flutter/material.dart';
import '../widgets/web_max_width_container.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
        title: const Text('Profile & Services'),
        automaticallyImplyLeading: false,
      ),
      body: WebMaxWidthContainer(
        child: ListView(
          padding: const EdgeInsets.all(24.0),
          children: [
            _buildProfileCard(context),
            const SizedBox(height: 32),
            Text('Nearby Service Centers', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ...serviceCenters.map((center) {
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 15, offset: const Offset(0, 6))],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            center['name']!,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: Colors.black87),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.star, color: Color(0xFFF59E0B), size: 18),
                              const SizedBox(width: 4),
                              Text(center['rating']!, style: const TextStyle(fontWeight: FontWeight.bold)),
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
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {
                            _showBookingConfirmation(context, center['name']!);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4F46E5),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            elevation: 0,
                          ),
                          child: const Text('Book Appointment'),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF4F46E5).withValues(alpha: 0.1),
            ),
            child: const Icon(Icons.person, color: Color(0xFF4F46E5), size: 40),
          ),
          const SizedBox(width: 24),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Test User', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87)),
              const SizedBox(height: 4),
              Text('Premium Driver', style: TextStyle(color: Colors.grey.shade600, fontSize: 14)),
            ],
          )
        ],
      ),
    );
  }

  void _showBookingConfirmation(BuildContext context, String garageName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text('Booking Confirmed', style: TextStyle(fontWeight: FontWeight.bold)),
        content: Text('Your appointment at $garageName has been successfully requested. They will contact you shortly.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close', style: TextStyle(color: Color(0xFF4F46E5))),
          ),
        ],
      ),
    );
  }
}
