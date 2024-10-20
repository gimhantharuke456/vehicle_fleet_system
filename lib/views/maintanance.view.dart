import 'package:flutter/material.dart';
import 'package:vehicle_fleet_system/models/maintance.model.dart';
import 'package:vehicle_fleet_system/services/maintance.service.dart';
import 'package:vehicle_fleet_system/utils/index.dart';
import 'package:vehicle_fleet_system/views/milage.history.view.dart';
import 'package:vehicle_fleet_system/widgets/custom.filled.button.dart';
import 'package:vehicle_fleet_system/widgets/custom.input.field.dart';

class MaintananceView extends StatefulWidget {
  const MaintananceView({super.key});

  @override
  State<MaintananceView> createState() => _MaintananceViewState();
}

class _MaintananceViewState extends State<MaintananceView> {
  bool loading = false;
  final _milage = TextEditingController();
  final _nextServiceMilage = TextEditingController();
  final _feedback = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Maitanance"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.navigator(context, const MilageHistoryView());
        },
        child: const Icon(Icons.join_inner),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            CustomInputField(
              label: "Maintance Milage",
              hint: "1000km",
              controller: _milage,
              inputType: TextInputType.number,
            ),
            CustomInputField(
              label: "Next Milage",
              hint: "1110km",
              controller: _nextServiceMilage,
              inputType: TextInputType.number,
            ),
            CustomInputField(
              label: "Feedback",
              hint: "Good Service",
              controller: _feedback,
            ),
            CustomButton(
              loading: loading,
              text: "Submit",
              onPressed: () async {
                MaintenanceRecord record = MaintenanceRecord(
                  mileage: _milage.text,
                  nextServiceMileage: _nextServiceMilage.text,
                  feedback: _feedback.text,
                );
                setState(() {
                  loading = true;
                });
                await MaintenanceService()
                    .addMaintenanceRecord(record)
                    .then((result) {
                  context.showSnackBar("Maintance record added successfully");
                  setState(() {
                    loading = false;
                    _feedback.clear();
                    _milage.clear();
                    _nextServiceMilage.clear();
                  });
                }).catchError((error) {
                  context.showSnackBar("Maintance record adding failed");
                  setState(() {
                    loading = false;
                  });
                });
                FocusManager.instance.primaryFocus?.unfocus();
              },
            ),
          ],
        ),
      ),
    );
  }
}
