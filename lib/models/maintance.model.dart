class MaintenanceRecord {
  final String mileage;
  final String nextServiceMileage;
  final String feedback;

  MaintenanceRecord({
    required this.mileage,
    required this.nextServiceMileage,
    required this.feedback,
  });

  // Optionally, you can add methods to convert this data to/from JSON
  Map<String, dynamic> toJson() {
    return {
      'mileage': mileage,
      'nextServiceMileage': nextServiceMileage,
      'feedback': feedback,
    };
  }

  factory MaintenanceRecord.fromJson(Map<String, dynamic> json) {
    return MaintenanceRecord(
      mileage: json['mileage'],
      nextServiceMileage: json['nextServiceMileage'],
      feedback: json['feedback'],
    );
  }
}
