import 'dart:math';
import 'package:flutter/material.dart';
import 'package:vehicle_fleet_system/utils/index.dart';
import 'package:vehicle_fleet_system/views/battery.voltage.view.dart';
import 'package:vehicle_fleet_system/views/maintanance.view.dart';
import 'package:vehicle_fleet_system/views/map.view.dart';
import 'package:vehicle_fleet_system/views/oil.level.view.dart';
import 'package:vehicle_fleet_system/views/vehicle.emission.view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Color> buttonColors = [
      Colors.blueGrey, // Engine Oil Level - reliable
      Colors.green, // Battery Voltage - energy-related
      Colors.blue, // Map - navigation-related
      Colors.redAccent, // Maintenance - alert or action
      Colors.orangeAccent, // Emission - warning or check
    ];

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 32),
        width: MediaQuery.of(context).size.width,
        child: Wrap(
          alignment: WrapAlignment.center,
          children: [
            homeButton(
              title: "Engine Oil Level",
              onTap: () {
                context.navigator(context, const OilLevelView());
              },
              color: getRandomColor(buttonColors),
              context: context,
            ),
            homeButton(
              title: "Battery Voltage",
              onTap: () {
                context.navigator(context, const BatteryVoltageView());
              },
              color: getRandomColor(buttonColors),
              context: context,
            ),
            homeButton(
              title: "Map",
              onTap: () {
                context.navigator(context, const AppMapView());
              },
              color: getRandomColor(buttonColors),
              context: context,
            ),
            homeButton(
              title: "Maintenance",
              onTap: () {
                context.navigator(context, const MaintananceView());
              },
              color: getRandomColor(buttonColors),
              context: context,
            ),
            homeButton(
              title: "Vehicle Emission",
              onTap: () {
                context.navigator(context, const VehicleEmissionView());
                ;
              },
              color: getRandomColor(buttonColors),
              context: context,
            ),
          ],
        ),
      ),
    );
  }

  // Function to randomize the button color
  Color getRandomColor(List<Color> colors) {
    final random = Random();
    return colors[random.nextInt(colors.length)];
  }

  Widget homeButton({
    required String title,
    required VoidCallback onTap,
    required Color color,
    required BuildContext context,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width / 2.5,
        height: 200,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(8),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
