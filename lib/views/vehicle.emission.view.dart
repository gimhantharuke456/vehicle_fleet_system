import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class VehicleEmissionView extends StatefulWidget {
  const VehicleEmissionView({super.key});

  @override
  _VehicleEmissionViewState createState() => _VehicleEmissionViewState();
}

class _VehicleEmissionViewState extends State<VehicleEmissionView> {
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.ref('vehicle_sensors');
  double? methanePPM;
  double? coPPM;

  @override
  void initState() {
    super.initState();
    _fetchMethanePPM();
    _fetchCOPPM();
  }

  void _fetchMethanePPM() {
    _databaseReference
        .child('methanePPM')
        .onValue
        .listen((DatabaseEvent event) {
      final dynamic value = event.snapshot.value;
      if (value != null) {
        setState(() {
          methanePPM = (value / 1.0) as double;
        });
      }
    });
  }

  void _fetchCOPPM() {
    _databaseReference.child('coPPM').onValue.listen((DatabaseEvent event) {
      final dynamic value = event.snapshot.value;
      if (value != null) {
        setState(() {
          coPPM = (value / 1.0) as double;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehicle Emission'),
      ),
      body: Center(
        child: methanePPM == null
            ? const CircularProgressIndicator()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 40),
                    decoration: BoxDecoration(
                      color: methanePPM! > 3000 ? Colors.green : Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'Methane PPM: $methanePPM',
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.white, // Set text color to white
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 40),
                    decoration: BoxDecoration(
                      color: coPPM! > 3000 ? Colors.green : Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'CO PPM: ${coPPM?.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.white, // Set text color to white
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
