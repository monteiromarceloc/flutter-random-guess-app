import 'package:flutter/material.dart';
import 'custom_button.dart';
import 'package:segment_display/segment_display.dart';

class DisplayContainer extends StatelessWidget {
  DisplayContainer(
      {@required this.label,
      @required this.displayText,
      @required this.showButton,
      @required this.onRestart});

  String label;
  String displayText;
  bool showButton;
  final Function onRestart;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          Container(
              margin: EdgeInsets.only(bottom: 20.0),
              child: Text(
                label,
                style: Theme.of(context).textTheme.headline6,
              )),
          SevenSegmentDisplay(
            value: displayText,
            size: 10.0,
            characterSpacing: 4.0,
            backgroundColor: Colors.transparent,
            segmentStyle: HexSegmentStyle(
              enabledColor: Colors.red,
              disabledColor: Colors.grey.withOpacity(0.15),
            ),
          ),
          Visibility(
              visible: showButton,
              child: CustomButton(label: "Nova Partida", onPress: onRestart)),
        ]));
  }
}
