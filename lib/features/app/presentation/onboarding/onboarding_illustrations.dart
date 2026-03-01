import 'package:flutter/material.dart';

/// Cartoon-style illustration for Welcome page - Fish tank with bubbles
class WelcomeIllustration extends StatelessWidget {
  const WelcomeIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final secondary = Theme.of(context).colorScheme.secondary;

    return SizedBox(
      width: 280,
      height: 280,
      child: CustomPaint(
        painter: _WelcomePainter(primary: primary, secondary: secondary),
      ),
    );
  }
}

class _WelcomePainter extends CustomPainter {
  final Color primary;
  final Color secondary;

  _WelcomePainter({required this.primary, required this.secondary});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    // Tank body (rounded rectangle)
    final tankPaint = Paint()
      ..color = primary.withValues(alpha: 0.2)
      ..style = PaintingStyle.fill;

    final tankRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: center, width: 200, height: 160),
      const Radius.circular(16),
    );
    canvas.drawRRect(tankRect, tankPaint);

    // Tank border
    final borderPaint = Paint()
      ..color = primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    canvas.drawRRect(tankRect, borderPaint);

    // Water
    final waterPaint = Paint()
      ..color = Colors.lightBlue.withValues(alpha: 0.4)
      ..style = PaintingStyle.fill;

    final waterRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(center.dx - 96, center.dy - 50, 192, 120),
      const Radius.circular(12),
    );
    canvas.drawRRect(waterRect, waterPaint);

    // Fish 1
    _drawFish(canvas, Offset(center.dx - 40, center.dy), Colors.orange, 30);
    // Fish 2
    _drawFish(
      canvas,
      Offset(center.dx + 50, center.dy + 20),
      secondary,
      25,
      flip: true,
    );
    // Fish 3
    _drawFish(
      canvas,
      Offset(center.dx + 10, center.dy - 30),
      Colors.red.shade400,
      20,
    );

    // Bubbles
    final bubblePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.7)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(center.dx - 60, center.dy - 40), 8, bubblePaint);
    canvas.drawCircle(Offset(center.dx - 70, center.dy - 55), 5, bubblePaint);
    canvas.drawCircle(Offset(center.dx + 70, center.dy - 35), 6, bubblePaint);
    canvas.drawCircle(Offset(center.dx + 60, center.dy - 50), 4, bubblePaint);

    // Plants
    _drawPlant(canvas, Offset(center.dx - 70, center.dy + 60), Colors.green);
    _drawPlant(
      canvas,
      Offset(center.dx + 60, center.dy + 60),
      Colors.green.shade700,
    );

    // Gravel
    final gravelPaint = Paint()
      ..color = Colors.brown.shade300
      ..style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(center.dx - 96, center.dy + 55, 192, 15),
        const Radius.circular(4),
      ),
      gravelPaint,
    );
  }

  void _drawFish(
    Canvas canvas,
    Offset pos,
    Color color,
    double size, {
    bool flip = false,
  }) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    final dir = flip ? -1.0 : 1.0;

    // Body (ellipse)
    canvas.drawOval(
      Rect.fromCenter(center: pos, width: size * 1.5, height: size),
      paint,
    );

    // Tail
    path.moveTo(pos.dx - dir * size * 0.6, pos.dy);
    path.lineTo(pos.dx - dir * size * 1.1, pos.dy - size * 0.5);
    path.lineTo(pos.dx - dir * size * 1.1, pos.dy + size * 0.5);
    path.close();
    canvas.drawPath(path, paint);

    // Eye
    final eyePaint = Paint()..color = Colors.white;
    canvas.drawCircle(
      Offset(pos.dx + dir * size * 0.3, pos.dy - size * 0.1),
      size * 0.2,
      eyePaint,
    );
    final pupilPaint = Paint()..color = Colors.black;
    canvas.drawCircle(
      Offset(pos.dx + dir * size * 0.35, pos.dy - size * 0.1),
      size * 0.1,
      pupilPaint,
    );
  }

  void _drawPlant(Canvas canvas, Offset base, Color color) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    for (var i = 0; i < 3; i++) {
      final path = Path();
      path.moveTo(base.dx + (i - 1) * 8, base.dy);
      path.quadraticBezierTo(
        base.dx + (i - 1) * 12,
        base.dy - 40,
        base.dx + (i - 1) * 6,
        base.dy - 50,
      );
      path.quadraticBezierTo(
        base.dx + (i - 1) * 4,
        base.dy - 40,
        base.dx + (i - 1) * 8,
        base.dy,
      );
      path.close();
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Cartoon-style illustration for Tank Management page
class TankManagementIllustration extends StatelessWidget {
  const TankManagementIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return SizedBox(
      width: 280,
      height: 280,
      child: CustomPaint(painter: _TankManagementPainter(primary: primary)),
    );
  }
}

class _TankManagementPainter extends CustomPainter {
  final Color primary;

  _TankManagementPainter({required this.primary});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    // Multiple tanks representation
    _drawMiniTank(canvas, Offset(center.dx - 70, center.dy - 30), primary, 80);
    _drawMiniTank(
      canvas,
      Offset(center.dx + 50, center.dy + 10),
      Colors.teal,
      100,
    );
    _drawMiniTank(
      canvas,
      Offset(center.dx - 20, center.dy + 50),
      Colors.cyan,
      70,
    );

    // Connection lines (management concept)
    final linePaint = Paint()
      ..color = primary.withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawLine(
      Offset(center.dx - 30, center.dy - 30),
      Offset(center.dx, center.dy - 60),
      linePaint,
    );
    canvas.drawLine(
      Offset(center.dx + 50, center.dy - 20),
      Offset(center.dx, center.dy - 60),
      linePaint,
    );
    canvas.drawLine(
      Offset(center.dx - 20, center.dy + 20),
      Offset(center.dx, center.dy - 60),
      linePaint,
    );

    // Central hub (phone/app icon)
    final hubPaint = Paint()
      ..color = primary
      ..style = PaintingStyle.fill;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(center.dx, center.dy - 60),
          width: 40,
          height: 60,
        ),
        const Radius.circular(8),
      ),
      hubPaint,
    );

    // Phone screen
    final screenPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.9)
      ..style = PaintingStyle.fill;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(center.dx, center.dy - 62),
          width: 32,
          height: 45,
        ),
        const Radius.circular(4),
      ),
      screenPaint,
    );

    // Check marks on screen
    final checkPaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    _drawCheck(canvas, Offset(center.dx, center.dy - 72), checkPaint);
    _drawCheck(canvas, Offset(center.dx, center.dy - 60), checkPaint);
  }

  void _drawMiniTank(Canvas canvas, Offset pos, Color color, double width) {
    final tankPaint = Paint()
      ..color = color.withValues(alpha: 0.3)
      ..style = PaintingStyle.fill;

    final tankRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: pos, width: width, height: width * 0.6),
      const Radius.circular(8),
    );
    canvas.drawRRect(tankRect, tankPaint);

    final borderPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawRRect(tankRect, borderPaint);

    // Water waves
    final wavePaint = Paint()
      ..color = Colors.lightBlue.withValues(alpha: 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final path = Path();
    path.moveTo(pos.dx - width * 0.35, pos.dy);
    path.quadraticBezierTo(pos.dx - width * 0.2, pos.dy - 5, pos.dx, pos.dy);
    path.quadraticBezierTo(
      pos.dx + width * 0.2,
      pos.dy + 5,
      pos.dx + width * 0.35,
      pos.dy,
    );
    canvas.drawPath(path, wavePaint);
  }

  void _drawCheck(Canvas canvas, Offset pos, Paint paint) {
    canvas.drawLine(
      Offset(pos.dx - 5, pos.dy),
      Offset(pos.dx - 1, pos.dy + 4),
      paint,
    );
    canvas.drawLine(
      Offset(pos.dx - 1, pos.dy + 4),
      Offset(pos.dx + 6, pos.dy - 4),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Cartoon-style illustration for Monitoring page
class MonitoringIllustration extends StatelessWidget {
  const MonitoringIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return SizedBox(
      width: 280,
      height: 280,
      child: CustomPaint(painter: _MonitoringPainter(primary: primary)),
    );
  }
}

class _MonitoringPainter extends CustomPainter {
  final Color primary;

  _MonitoringPainter({required this.primary});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    // Chart background
    final bgPaint = Paint()
      ..color = primary.withValues(alpha: 0.1)
      ..style = PaintingStyle.fill;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: center, width: 220, height: 180),
        const Radius.circular(16),
      ),
      bgPaint,
    );

    // Grid lines
    final gridPaint = Paint()
      ..color = Colors.grey.withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    for (var i = 0; i < 5; i++) {
      final y = center.dy - 60 + i * 30;
      canvas.drawLine(
        Offset(center.dx - 90, y),
        Offset(center.dx + 90, y),
        gridPaint,
      );
    }

    // Chart line (water parameters trend)
    final chartPaint = Paint()
      ..color = primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final chartPath = Path();
    chartPath.moveTo(center.dx - 80, center.dy + 20);
    chartPath.lineTo(center.dx - 50, center.dy);
    chartPath.lineTo(center.dx - 20, center.dy + 30);
    chartPath.lineTo(center.dx + 10, center.dy - 10);
    chartPath.lineTo(center.dx + 40, center.dy + 10);
    chartPath.lineTo(center.dx + 70, center.dy - 30);
    canvas.drawPath(chartPath, chartPaint);

    // Data points
    final pointPaint = Paint()
      ..color = primary
      ..style = PaintingStyle.fill;

    final pointBgPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final points = [
      Offset(center.dx - 80, center.dy + 20),
      Offset(center.dx - 50, center.dy),
      Offset(center.dx - 20, center.dy + 30),
      Offset(center.dx + 10, center.dy - 10),
      Offset(center.dx + 40, center.dy + 10),
      Offset(center.dx + 70, center.dy - 30),
    ];

    for (final point in points) {
      canvas.drawCircle(point, 6, pointBgPaint);
      canvas.drawCircle(point, 4, pointPaint);
    }

    // Parameter labels
    _drawLabel(
      canvas,
      Offset(center.dx - 90, center.dy - 75),
      'pH',
      Colors.blue,
    );
    _drawLabel(
      canvas,
      Offset(center.dx - 30, center.dy - 75),
      'NH₃',
      Colors.orange,
    );
    _drawLabel(
      canvas,
      Offset(center.dx + 30, center.dy - 75),
      'NO₃',
      Colors.red,
    );
    _drawLabel(
      canvas,
      Offset(center.dx + 75, center.dy - 75),
      '°C',
      Colors.green,
    );
  }

  void _drawLabel(Canvas canvas, Offset pos, String text, Color color) {
    final bgPaint = Paint()
      ..color = color.withValues(alpha: 0.2)
      ..style = PaintingStyle.fill;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: pos, width: 35, height: 22),
        const Radius.circular(6),
      ),
      bgPaint,
    );

    final borderPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: pos, width: 35, height: 22),
        const Radius.circular(6),
      ),
      borderPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Cartoon-style illustration for Reminders page
class RemindersIllustration extends StatelessWidget {
  const RemindersIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return SizedBox(
      width: 280,
      height: 280,
      child: CustomPaint(painter: _RemindersPainter(primary: primary)),
    );
  }
}

class _RemindersPainter extends CustomPainter {
  final Color primary;

  _RemindersPainter({required this.primary});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    // Bell background circle
    final bgPaint = Paint()
      ..color = primary.withValues(alpha: 0.15)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, 100, bgPaint);

    // Bell body
    final bellPaint = Paint()
      ..color = Colors.amber
      ..style = PaintingStyle.fill;

    final bellPath = Path();
    bellPath.moveTo(center.dx - 50, center.dy + 20);
    bellPath.quadraticBezierTo(
      center.dx - 55,
      center.dy - 20,
      center.dx - 40,
      center.dy - 50,
    );
    bellPath.quadraticBezierTo(
      center.dx - 30,
      center.dy - 80,
      center.dx,
      center.dy - 85,
    );
    bellPath.quadraticBezierTo(
      center.dx + 30,
      center.dy - 80,
      center.dx + 40,
      center.dy - 50,
    );
    bellPath.quadraticBezierTo(
      center.dx + 55,
      center.dy - 20,
      center.dx + 50,
      center.dy + 20,
    );
    bellPath.close();
    canvas.drawPath(bellPath, bellPaint);

    // Bell rim
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(center.dx, center.dy + 28),
          width: 120,
          height: 16,
        ),
        const Radius.circular(8),
      ),
      bellPaint,
    );

    // Bell top (handle)
    final handlePaint = Paint()
      ..color = Colors.amber.shade700
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;

    final handlePath = Path();
    handlePath.moveTo(center.dx - 15, center.dy - 85);
    handlePath.quadraticBezierTo(
      center.dx,
      center.dy - 100,
      center.dx + 15,
      center.dy - 85,
    );
    canvas.drawPath(handlePath, handlePaint);

    // Bell clapper
    canvas.drawCircle(
      Offset(center.dx, center.dy + 42),
      10,
      Paint()..color = Colors.amber.shade800,
    );

    // Notification badges
    _drawBadge(
      canvas,
      Offset(center.dx + 60, center.dy - 70),
      '💧',
      Colors.blue,
    );
    _drawBadge(
      canvas,
      Offset(center.dx - 65, center.dy - 40),
      '🍽️',
      Colors.orange,
    );
    _drawBadge(
      canvas,
      Offset(center.dx + 70, center.dy + 10),
      '🧪',
      Colors.purple,
    );

    // Motion lines
    final motionPaint = Paint()
      ..color = Colors.amber.withValues(alpha: 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    // Left motion lines
    canvas.drawLine(
      Offset(center.dx - 70, center.dy - 60),
      Offset(center.dx - 85, center.dy - 75),
      motionPaint,
    );
    canvas.drawLine(
      Offset(center.dx - 75, center.dy - 40),
      Offset(center.dx - 90, center.dy - 45),
      motionPaint,
    );

    // Right motion lines
    canvas.drawLine(
      Offset(center.dx + 70, center.dy - 60),
      Offset(center.dx + 85, center.dy - 75),
      motionPaint,
    );
    canvas.drawLine(
      Offset(center.dx + 75, center.dy - 40),
      Offset(center.dx + 90, center.dy - 45),
      motionPaint,
    );
  }

  void _drawBadge(Canvas canvas, Offset pos, String emoji, Color color) {
    final bgPaint = Paint()
      ..color = color.withValues(alpha: 0.2)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(pos, 22, bgPaint);

    final borderPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawCircle(pos, 22, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
