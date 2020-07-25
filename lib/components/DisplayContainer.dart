import 'package:flutter/material.dart';
import 'CustomSegmentDisplay.dart';
import 'CustomButton.dart';

class DisplayContainer extends StatelessWidget {
  String label;
  String displayText;
  bool showButton;
  final Function onRestart;

  DisplayContainer(
      {@required this.label,
      @required this.displayText,
      @required this.showButton,
      @required this.onRestart});

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
          CustomSegmentDisplay(displayValue: int.parse(displayText)),
          Visibility(
              visible: showButton,
              child: CustomButton(label: "Nova Partida", onPress: onRestart)),
        ]));
  }
}
