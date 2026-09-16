import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/morvixa_theme.dart';

class TeaSteepHourglassPainter extends CustomPainter {
  final double progress;
  final bool isSteeping;

  TeaSteepHourglassPainter({required this.progress, required this.isSteeping});

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;

    // Glass teapot carafe outline
    final potPath = Path()
      ..moveTo(width * 0.3, height * 0.25)
      ..lineTo(width * 0.7, height * 0.25)
      ..lineTo(width * 0.78, height * 0.8)
      ..lineTo(width * 0.22, height * 0.8)
      ..close();

    final potPaint = Paint()
      ..color = MorvixaTheme.edge.withValues(alpha: 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;
    canvas.drawPath(potPath, potPaint);

    // Steeping liquor liquid inside pot
    final liquidHeight = (height * 0.52) * progress.clamp(0.08, 1.0);
    final liquidTop = height * 0.8 - liquidHeight;
    final liquidRect = Rect.fromLTRB(width * 0.25, liquidTop, width * 0.75, height * 0.78);

    // Color deepens from light amber to rich tea color
    final teaColor = Color.lerp(
      MorvixaTheme.accentLight.withValues(alpha: 0.35),
      MorvixaTheme.amberTea.withValues(alpha: 0.85),
      progress,
    )!;

    final liquidPaint = Paint()..color = teaColor;
    canvas.drawRRect(RRect.fromRectAndRadius(liquidRect, const Radius.circular(8)), liquidPaint);

    // Infuser basket inside
    final infuserRect = Rect.fromLTRB(width * 0.42, height * 0.25, width * 0.58, height * 0.65);
    final infuserPaint = Paint()
      ..color = const Color(0xFF64748B).withValues(alpha: 0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawRRect(RRect.fromRectAndRadius(infuserRect, const Radius.circular(4)), infuserPaint);

    // Floating loose tea leaves
    final leafPaint = Paint()..color = MorvixaTheme.ink;
    for (int i = 0; i < 6; i++) {
      final leafX = width * 0.32 + (i * 14) + (isSteeping ? sin(progress * 10 + i) * 3 : 0);
      final leafY = height * 0.72 - (i * 6);
      canvas.drawOval(
        Rect.fromCenter(center: Offset(leafX, leafY), width: 6, height: 3),
        leafPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant TeaSteepHourglassPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.isSteeping != isSteeping;
  }
}
