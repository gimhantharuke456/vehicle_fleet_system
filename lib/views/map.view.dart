import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_database/firebase_database.dart';

class AppMapView extends StatefulWidget {
  const AppMapView({Key? key}) : super(key: key);

  @override
  _AppMapViewState createState() => _AppMapViewState();
}

class _AppMapViewState extends State<AppMapView> {
  late GoogleMapController mapController;
  Set<Marker> markers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehicle Location'),
      ),
      body: StreamBuilder(
        stream:
            FirebaseDatabase.instance.ref().child('vehicle_sensors').onValue,
        builder: (context, snapshot) {
          if (snapshot.hasData && !snapshot.hasError) {
            var event = snapshot.data as DatabaseEvent;
            var data = event.snapshot.value as Map<dynamic, dynamic>?;

            if (data != null &&
                data['latitude'] != null &&
                data['longitude'] != null) {
              double latitude = data['latitude'];
              double longitude = data['longitude'];

              LatLng position = LatLng(latitude, longitude);

              markers.clear();
              markers.add(Marker(
                markerId: const MarkerId('vehicleLocation'),
                position: position,
                infoWindow: const InfoWindow(title: 'Vehicle Location'),
              ));

              return GoogleMap(
                onMapCreated: (GoogleMapController controller) {
                  mapController = controller;
                },
                initialCameraPosition: CameraPosition(
                  target: position,
                  zoom: 15,
                ),
                markers: markers,
              );
            }
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
