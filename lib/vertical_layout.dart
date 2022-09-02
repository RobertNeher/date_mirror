import 'package:flutter/material.dart';
import 'utils.dart';

class VerticalTimelinePainter extends CustomPainter {
  String eventLabel;
  String mirrorLabel;
  int dayDiff;

  final TextPainter labelPainter = TextPainter(
    textDirection: TextDirection.ltr,
    maxLines: 2,
    textAlign: TextAlign.center,
    textHeightBehavior: const TextHeightBehavior(
        applyHeightToFirstAscent: true, applyHeightToLastDescent: true),
    textScaleFactor: 1,
  );
  final TextStyle labelStyle = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );
  VerticalTimelinePainter(
      {this.eventLabel = "", this.mirrorLabel = "", this.dayDiff = 0});

  @override
  paint(Canvas canvas, Size size) {
    double height = size.height * 0.6;
    double width = size.width;

    Paint paint = Paint()
      ..color = Colors.red
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    // draw base timeline
    double posY = 0;
    double posX = width / 2;

    canvas.drawLine(Offset(posX, 0), Offset(posX, height), paint);

    // mirrorday
    posY = height * 0.0;
    canvas.drawLine(Offset(posX - 5, posY), Offset(posX + 5, posY), paint);
    labelPainter.text = TextSpan(text: mirrorLabel, style: labelStyle);
    labelPainter.layout(minWidth: 0, maxWidth: double.maxFinite);
    labelPainter.paint(
        canvas, Offset(posX + 10, posY - labelPainter.height / 2));

    // mirror day difference
    posY = height * 0.25;
    canvas.drawLine(Offset(posX - 5, posY), Offset(posX + 5, posY), paint);
    labelPainter.text =
        TextSpan(text: 'Distance\n-$dayDiff days', style: labelStyle);
    labelPainter.layout(minWidth: 0, maxWidth: double.maxFinite);
    labelPainter.paint(canvas,
        Offset(posX - labelPainter.width - 10, posY - labelPainter.height / 2));

    // selected Event
    posY = height * 0.5;

    labelPainter.text = TextSpan(text: eventLabel, style: labelStyle);
    canvas.drawLine(Offset(posX - 5, posY), Offset(posX + 5, posY), paint);
    labelPainter.text = TextSpan(text: eventLabel, style: labelStyle);
    labelPainter.layout(minWidth: 0, maxWidth: double.maxFinite);
    labelPainter.paint(
        canvas, Offset(posX + 10, posY - labelPainter.height / 2));

    // day difference
    posY = height * 0.75;
    canvas.drawLine(Offset(posX - 5, posY), Offset(posX + 5, posY), paint);
    labelPainter.text =
        TextSpan(text: 'Distance\n+$dayDiff days', style: labelStyle);
    labelPainter.layout(minWidth: 0, maxWidth: double.maxFinite);
    labelPainter.paint(canvas,
        Offset(posX - labelPainter.width - 10, posY - labelPainter.height / 2));

    // Today
    posY = height;
    labelPainter.text =
        TextSpan(text: 'Today\n${DateTime.now().format()}', style: labelStyle);
    canvas.drawLine(Offset(posX - 5, posY), Offset(posX + 5, posY), paint);
    labelPainter.layout(minWidth: 0, maxWidth: double.maxFinite);
    labelPainter.paint(
        canvas, Offset(posX + 10, posY - labelPainter.height / 2));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
