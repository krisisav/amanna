import 'dart:math';

import 'package:flutter/material.dart';

class DialogPainter extends CustomPainter {
  final Color color;
  final double circleRadius;
  final double edgeRadius;

  Radius get edgeCurve => Radius.circular(edgeRadius);

  const DialogPainter({
    required this.color, 
    required  this.circleRadius, 
    this.edgeRadius = 16.0,
  });

  void _drawDialog(Canvas canvas, Rect shapeBounds, Rect circleBounds) {
    final paint = Paint()..color = color;
    final backgroundPath = Path()
      ..moveTo(shapeBounds.left, shapeBounds.top + edgeRadius)
      ..arcToPoint(Offset(shapeBounds.left + edgeRadius, shapeBounds.top), radius: edgeCurve)
      ..arcTo(circleBounds, -pi, -pi, false)
      ..lineTo(shapeBounds.right - edgeRadius, shapeBounds.top)
      ..arcToPoint(Offset(shapeBounds.right, shapeBounds.top + edgeRadius), radius: edgeCurve)
      ..lineTo(shapeBounds.bottomRight.dx, shapeBounds.bottom - edgeRadius)
      ..arcToPoint(Offset(shapeBounds.bottomRight.dx - edgeRadius, shapeBounds.bottom), radius: edgeCurve)
      ..lineTo(shapeBounds.bottomLeft.dx + edgeRadius, shapeBounds.bottomLeft.dy)
      ..arcToPoint(Offset(shapeBounds.bottomLeft.dx, shapeBounds.bottomLeft.dy - edgeRadius), radius: edgeCurve)
      ..close();

    canvas
      ..save()
      ..translate(4, 4)
      ..drawShadow(backgroundPath, Colors.black, sqrt(12.0), true)
      ..translate(-4, -4)
      ..drawPath(backgroundPath, paint)
      ..restore();
  }

  @override
  void paint(Canvas canvas, Size size) {
    final shapeBounds = Rect.fromLTRB(0, 0, size.width, size.height - circleRadius);
    final centerCircle = Offset(shapeBounds.center.dx, shapeBounds.top);
    final circleBounds = Rect.fromCircle(
      center: centerCircle,
      radius: circleRadius,
    ).inflate(6);

    _drawDialog(canvas, shapeBounds, circleBounds);
  }

  @override
  bool shouldRepaint(DialogPainter oldDelegate) {
    return false;
  }
}