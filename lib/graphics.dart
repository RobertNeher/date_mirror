import 'package:flutter/material.dart';
import 'utils.dart';

class DateLinePainter extends CustomPainter {
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
  DateLinePainter(
      {this.eventLabel = "", this.mirrorLabel = "", this.dayDiff = 0});

  @override
  paint(Canvas canvas, Size size) {
    double height = size.height;
    double width = size.width;

    Paint paint = Paint()
      ..color = Colors.green
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    canvas.drawLine(
        Offset(0, height * 0.1), Offset(width, height * 0.1), paint);

    // labelPainter
    canvas.drawLine(Offset(width / 2, 0), Offset(width / 2, 10), paint);
    labelPainter.text =
        TextSpan(text: 'Today\n${DateTime.now().format()}', style: labelStyle);
    labelPainter.layout(minWidth: 0, maxWidth: double.maxFinite);
    labelPainter.paint(
        canvas,
        Offset(
            width / 2 - labelPainter.width / 2, 10 + labelPainter.height / 4));

    // day difference
    double posX = width * 0.7;
    canvas.drawLine(Offset(posX, 0), Offset(posX, 10), paint);
    labelPainter.text =
        TextSpan(text: 'Distance\n+${dayDiff} days', style: labelStyle);
    labelPainter.layout(minWidth: 0, maxWidth: double.maxFinite);
    labelPainter.paint(canvas,
        Offset(posX - labelPainter.width / 2, 10 + labelPainter.height / 4));

    // Selected event
    posX = width * 0.9;
    labelPainter.text = TextSpan(
        text: '$eventLabel\n${DateTime.now().format()}', style: labelStyle);
    canvas.drawLine(Offset(posX, 0), Offset(posX, 10), paint);
    labelPainter.text = TextSpan(text: eventLabel, style: labelStyle);
    labelPainter.layout(minWidth: 0, maxWidth: double.maxFinite);
    labelPainter.paint(canvas,
        Offset(posX - (labelPainter.width / 2), 10 + labelPainter.height / 4));

    // mirror day difference
    posX = width * 0.3;
    canvas.drawLine(Offset(posX, 0), Offset(posX, 10), paint);
    labelPainter.text =
        TextSpan(text: 'Distance\n-${dayDiff} days', style: labelStyle);
    labelPainter.layout(minWidth: 0, maxWidth: double.maxFinite);
    labelPainter.paint(canvas,
        Offset(posX - labelPainter.width / 2, 10 + labelPainter.height / 4));

    //mirrorday
    posX = width * 0.1;
    canvas.drawLine(Offset(posX, 0), Offset(posX, 10), paint);
    labelPainter.text = TextSpan(text: mirrorLabel, style: labelStyle);
    labelPainter.layout(minWidth: 0, maxWidth: double.maxFinite);
    labelPainter.paint(canvas,
        Offset(posX - labelPainter.width / 2, 10 + labelPainter.height / 4));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
