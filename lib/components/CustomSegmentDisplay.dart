import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter_random_guess_app/store/GlobalState.dart';

class CustomSegmentDisplay extends StatelessWidget {
  int displayValue;

  CustomSegmentDisplay({@required this.displayValue});

  @override
  Widget build(BuildContext context) {
    // Separates value's digits
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      if (displayValue > 99) SingleDisplay(value: (displayValue ~/ 100)),
      if (displayValue > 9) SingleDisplay(value: ((displayValue % 100) ~/ 10)),
      SingleDisplay(value: displayValue % 10),
    ]);
  }
}

class SingleDisplay extends StatelessWidget {
  final value;
  var ledMap;

  SingleDisplay({@required this.value}) {
    // Map which segments should be turned on of or off
    this.ledMap = {
      'A': [2, 3, 5, 6, 7, 8, 9, 0].contains(this.value),
      'B': [2, 3, 4, 5, 6, 8, 9].contains(this.value),
      'C': [2, 3, 5, 6, 8, 0].contains(this.value),
      'D': [4, 5, 6, 8, 9, 0].contains(this.value),
      'E': [1, 2, 3, 4, 7, 8, 9, 0].contains(this.value),
      'F': [2, 6, 8, 0].contains(this.value),
      'G': [1, 3, 4, 5, 6, 7, 8, 9, 0].contains(this.value),
    };
  }

  @override
  Widget build(BuildContext context) {
    final color = GlobalState.of(context).color;
    final dSize = GlobalState.of(context).size;

    return Container(
      width: 6 * dSize,
      height: 12 * dSize,
      margin: EdgeInsets.fromLTRB(5.0, 0, 5.0, 0),
      child: CustomPaint(
        painter: DisplayPainter(
          ledMap: ledMap,
          color: color,
          dSize: dSize,
        ),
      ),
    );
  }
}

class DisplayPainter extends CustomPainter {
  DisplayPainter({@required this.ledMap, this.color, this.dSize});

  final ledMap;
  final color;
  double dSize;

  @override
  void paint(Canvas canvas, Size size) {
    var paintOn = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    var paintOff = Paint()
      ..color = Colors.grey[200]
      ..style = PaintingStyle.fill;

    final hSize = Size(6 * dSize, dSize);
    final vSize = Size(dSize, 6 * dSize);
    final aOffset = Offset(0, 0);
    final bOffset = Offset(0, 5.5 * dSize);
    final cOffset = Offset(0, 11 * dSize);
    final dOffset = aOffset;
    final eOffset = Offset(5 * dSize, 0);
    final fOffset = bOffset;
    final gOffset = Offset(5 * dSize, 5.5 * dSize);

    // Build background
    canvas.drawRect(aOffset & hSize, paintOff);
    canvas.drawRect(bOffset & hSize, paintOff);
    canvas.drawRect(cOffset & hSize, paintOff);
    canvas.drawRect(dOffset & vSize, paintOff);
    canvas.drawRect(eOffset & vSize, paintOff);
    canvas.drawRect(fOffset & vSize, paintOff);
    canvas.drawRect(gOffset & vSize, paintOff);

    // Paint colors
    if (ledMap['A']) canvas.drawRect(aOffset & hSize, paintOn);
    if (ledMap['B']) canvas.drawRect(bOffset & hSize, paintOn);
    if (ledMap['C']) canvas.drawRect(cOffset & hSize, paintOn);
    if (ledMap['D']) canvas.drawRect(dOffset & vSize, paintOn);
    if (ledMap['E']) canvas.drawRect(eOffset & vSize, paintOn);
    if (ledMap['F']) canvas.drawRect(fOffset & vSize, paintOn);
    if (ledMap['G']) canvas.drawRect(gOffset & vSize, paintOn);
  }

  @override
  bool shouldRepaint(DisplayPainter old) =>
      (old.ledMap != ledMap || old.color != color || old.dSize != dSize);
}

// TODO: use drawPath to create hexagonal shape
