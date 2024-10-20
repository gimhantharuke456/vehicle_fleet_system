import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class OilLevelView extends StatelessWidget {
  const OilLevelView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Oil Level'),
      ),
      body: StreamBuilder(
        stream: FirebaseDatabase.instance
            .ref()
            .child('vehicle_sensors/oilLevel')
            .onValue,
        builder: (context, snapshot) {
          if (snapshot.hasData && !snapshot.hasError) {
            var event = snapshot.data as DatabaseEvent;
            var oilLevel = event.snapshot.value as int? ?? 0;
            return Center(
              child: SizedBox(
                width: 200,
                height: 300,
                child: CustomPaint(
                  painter: OilLevelPainter(oilLevel),
                  child: Center(
                    child: Text(
                      'Oil Level\n$oilLevel',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
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

class OilLevelPainter extends CustomPainter {
  final int oilLevel;

  OilLevelPainter(this.oilLevel);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Draw the outer container
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        const Radius.circular(20),
      ),
      paint,
    );

    // Draw the oil level
    final fillPaint = Paint()
      ..color = oilLevel <= 255 ? Colors.red : Colors.amber
      ..style = PaintingStyle.fill;

    final fillHeight = (oilLevel / 500) * size.height;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, size.height - fillHeight, size.width, fillHeight),
        const Radius.circular(20),
      ),
      fillPaint,
    );

    // Draw level lines
    for (int i = 1; i < 5; i++) {
      final y = size.height * (1 - i / 5);
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width * 0.2, y),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
