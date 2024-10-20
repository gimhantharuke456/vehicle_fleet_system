import 'package:firebase_database/firebase_database.dart';
import 'package:vehicle_fleet_system/models/maintance.model.dart';

class MaintenanceService {
  final DatabaseReference _dbRef =
      FirebaseDatabase.instance.ref().child('maintenance_records');

  // CREATE - Add a new maintenance record
  Future<void> addMaintenanceRecord(MaintenanceRecord record) async {
    try {
      await _dbRef.push().set(record.toJson());
    } catch (e) {
      print('Error adding record: $e');
    }
  }

  // READ - Get a list of all maintenance records
  Future<List<MaintenanceRecord>> getMaintenanceRecords() async {
    List<MaintenanceRecord> records = [];
    try {
      DataSnapshot snapshot = await _dbRef.get();
      Map<String, dynamic> data = snapshot.value as Map<String, dynamic>;
      data.forEach((key, value) {
        records
            .add(MaintenanceRecord.fromJson(Map<String, dynamic>.from(value)));
      });
    } catch (e) {
      print('Error fetching records: $e');
    }
    return records;
  }

  // UPDATE - Update a specific maintenance record
  Future<void> updateMaintenanceRecord(
      String id, MaintenanceRecord updatedRecord) async {
    try {
      await _dbRef.child(id).update(updatedRecord.toJson());
    } catch (e) {
      print('Error updating record: $e');
    }
  }

  // DELETE - Delete a specific maintenance record
  Future<void> deleteMaintenanceRecord(String id) async {
    try {
      await _dbRef.child(id).remove();
    } catch (e) {
      print('Error deleting record: $e');
    }
  }

  Stream<List<MaintenanceRecord>> getMaintenanceRecordsStream() {
    return _dbRef.onValue.map((event) {
      List<MaintenanceRecord> records = [];
      if (event.snapshot.exists) {
        Map<String, dynamic> data =
            Map<String, dynamic>.from(event.snapshot.value as Map);
        data.forEach((key, value) {
          records.add(
              MaintenanceRecord.fromJson(Map<String, dynamic>.from(value)));
        });
      }
      return records;
    });
  }
}
