import 'package:flutter/material.dart';
import 'package:vehicle_fleet_system/models/maintance.model.dart';
import 'package:vehicle_fleet_system/services/maintance.service.dart';

class MilageHistoryView extends StatelessWidget {
  const MilageHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final MaintenanceService _maintenanceService = MaintenanceService();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mileage History"),
      ),
      body: StreamBuilder<List<MaintenanceRecord>>(
        stream: _maintenanceService.getMaintenanceRecordsStream(),
        builder: (context, AsyncSnapshot<List<MaintenanceRecord>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error fetching data'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No mileage history available'));
          }

          // Data is ready
          final List<MaintenanceRecord> records = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: records.length,
            itemBuilder: (context, index) {
              final record = records[index];
              return Container(
                decoration: BoxDecoration(
                  color: Colors.amber[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  title: Text('Mileage: ${record.mileage}'),
                  subtitle: Text(
                      'Next Service: ${record.nextServiceMileage}\nFeedback: ${record.feedback}'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
