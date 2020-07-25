import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
  var LEDMap;

  SingleDisplay({@required this.value}) {
    // Map which segments should be turned on of or off
    this.LEDMap = {
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
    return Container(
      width: 60,
      height: 120,
      margin: EdgeInsets.fromLTRB(5.0, 0, 5.0, 0),
      child: CustomPaint(
        painter: DisplayPainter(LEDMap: LEDMap),
      ),
    );
  }
}

class DisplayPainter extends CustomPainter {
  DisplayPainter({@required this.LEDMap});

  final LEDMap;

  @override
  void paint(Canvas canvas, Size size) {
    var paintOn = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;
    var paintOff = Paint()
      ..color = Colors.grey[200]
      ..style = PaintingStyle.fill;

    // Build background
    canvas.drawRect(Offset(0, 0) & Size(60, 10), paintOff);
    canvas.drawRect(Offset(0, 55) & Size(60, 10), paintOff);
    canvas.drawRect(Offset(0, 110) & Size(60, 10), paintOff);
    canvas.drawRect(Offset(0, 0) & Size(10, 60), paintOff);
    canvas.drawRect(Offset(50, 0) & Size(10, 60), paintOff);
    canvas.drawRect(Offset(0, 55) & Size(10, 60), paintOff);
    canvas.drawRect(Offset(50, 55) & Size(10, 60), paintOff);

    // Paint colors
    if (LEDMap['A']) canvas.drawRect(Offset(0, 0) & Size(60, 10), paintOn);
    if (LEDMap['B']) canvas.drawRect(Offset(0, 55) & Size(60, 10), paintOn);
    if (LEDMap['C']) canvas.drawRect(Offset(0, 110) & Size(60, 10), paintOn);
    if (LEDMap['D']) canvas.drawRect(Offset(0, 0) & Size(10, 60), paintOn);
    if (LEDMap['E']) canvas.drawRect(Offset(50, 0) & Size(10, 60), paintOn);
    if (LEDMap['F']) canvas.drawRect(Offset(0, 55) & Size(10, 60), paintOn);
    if (LEDMap['G']) canvas.drawRect(Offset(50, 55) & Size(10, 60), paintOn);
  }

  @override
  bool shouldRepaint(DisplayPainter old) => old.LEDMap != LEDMap;
}

// TODO: use drawPath to create hexagonal shape
