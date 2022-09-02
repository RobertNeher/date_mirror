import 'package:flutter/material.dart';
import 'utils.dart';

class HorizontalTimelinePainter extends CustomPainter {
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
  HorizontalTimelinePainter(
      {this.eventLabel = "", this.mirrorLabel = "", this.dayDiff = 0});

  @override
  paint(Canvas canvas, Size size) {
    double xOffset = 20;
    double height = size.height;
    double width = size.width - xOffset;

    Paint paint = Paint()
      ..color = Colors.green
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    // draw base timeline
    double posY = height * 0.1;
    double posX = xOffset / 2;

    canvas.drawLine(Offset(posX, posY), Offset(posX + width, posY), paint);

    // mirrorday
    posX = xOffset + width * 0.05;
    canvas.drawLine(Offset(posX, posY - 5), Offset(posX, posY + 5), paint);
    labelPainter.text = TextSpan(text: mirrorLabel, style: labelStyle);
    labelPainter.layout(minWidth: 0, maxWidth: double.maxFinite);
    labelPainter.paint(canvas,
        Offset(posX - labelPainter.width / 2, posY + labelPainter.height / 2));

    // mirror day difference
    posX = xOffset + width * 0.25;
    canvas.drawLine(Offset(posX, posY - 5), Offset(posX, posY + 5), paint);
    labelPainter.text =
        TextSpan(text: 'Distance\n-$dayDiff days', style: labelStyle);
    labelPainter.layout(minWidth: 0, maxWidth: double.maxFinite);
    labelPainter.paint(canvas,
        Offset(posX - labelPainter.width / 2, posY - labelPainter.height - 10));

    // selected Event
    posX = xOffset + width * 0.45;

    labelPainter.text = TextSpan(text: eventLabel, style: labelStyle);
    canvas.drawLine(Offset(posX, posY - 5), Offset(posX, posY + 5), paint);
    labelPainter.text = TextSpan(text: eventLabel, style: labelStyle);
    labelPainter.layout(minWidth: 0, maxWidth: double.maxFinite);
    labelPainter.paint(canvas,
        Offset(posX - labelPainter.width / 2, posY + labelPainter.height / 2));

    // day difference
    posX = xOffset + width * 0.65;
    canvas.drawLine(Offset(posX, posY - 5), Offset(posX, posY + 5), paint);
    labelPainter.text =
        TextSpan(text: 'Distance\n+$dayDiff days', style: labelStyle);
    labelPainter.layout(minWidth: 0, maxWidth: double.maxFinite);
    labelPainter.paint(canvas,
        Offset(posX - labelPainter.width / 2, posY - labelPainter.height - 10));

    // Today
    posX = xOffset + width * 0.85;
    labelPainter.text =
        TextSpan(text: 'Today\n${DateTime.now().format()}', style: labelStyle);
    canvas.drawLine(Offset(posX, posY - 5), Offset(posX, posY + 5), paint);
    labelPainter.layout(minWidth: 0, maxWidth: double.maxFinite);
    labelPainter.paint(
        canvas,
        Offset(
            posX - (labelPainter.width / 2), posY + labelPainter.height / 2));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
