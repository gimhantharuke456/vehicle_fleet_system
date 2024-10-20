import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:math' as math;

class BatteryVoltageView extends StatelessWidget {
  const BatteryVoltageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Battery Voltage'),
      ),
      body: StreamBuilder(
        stream: FirebaseDatabase.instance
            .ref()
            .child('vehicle_sensors/voltage')
            .onValue,
        builder: (context, snapshot) {
          if (snapshot.hasData && !snapshot.hasError) {
            var event = snapshot.data as DatabaseEvent;
            double voltage = 0.0;
            double displayVoltage = 0.0;
            if (event.snapshot.exists) {
              if (snapshot.data != null) {
                voltage = double.parse(event.snapshot.value.toString());
                displayVoltage = double.parse(event.snapshot.value.toString());
                if (voltage > 15) {
                  voltage = 15;
                }
                if (voltage < 0) {
                  voltage = 0;
                }
              }
            }

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 300,
                    height: 200,
                    child: CustomPaint(
                      painter: BatteryVoltagePainter(voltage),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Battery: ${displayVoltage.toStringAsFixed(2)} V',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading data'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class BatteryVoltagePainter extends CustomPainter {
  final double voltage;

  BatteryVoltagePainter(this.voltage);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height);
    final radius = size.width / 2;

    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    // Draw the arc
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi,
      math.pi,
      false,
      paint,
    );

    // Draw the needle
    final needlePaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final angle = mapVoltageToAngle(voltage.toDouble());
    final needleLength = radius * 0.8;
    final needleEnd = Offset(
      center.dx + needleLength * math.cos(angle),
      center.dy + needleLength * math.sin(angle),
    );

    canvas.drawLine(center, needleEnd, needlePaint);

    // Draw voltage markings
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    for (var v = 0.0; v <= 15.0; v += 3.0) {
      final markAngle = mapVoltageToAngle(v);
      final markStart = Offset(
        center.dx + (radius - 20) * math.cos(markAngle),
        center.dy + (radius - 20) * math.sin(markAngle),
      );
      final markEnd = Offset(
        center.dx + radius * math.cos(markAngle),
        center.dy + radius * math.sin(markAngle),
      );

      canvas.drawLine(markStart, markEnd, paint);

      textPainter.text = TextSpan(
        text: v.toStringAsFixed(0),
        style: const TextStyle(color: Colors.black, fontSize: 12),
      );
      textPainter.layout();
      final textOffset = Offset(
        center.dx + (radius - 40) * math.cos(markAngle) - textPainter.width / 2,
        center.dy +
            (radius - 40) * math.sin(markAngle) -
            textPainter.height / 2,
      );
      textPainter.paint(canvas, textOffset);
    }
  }

  double mapVoltageToAngle(double voltage) {
    return math.pi + (voltage / 15.0) * math.pi;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
