import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  String label;
  final Function onPress;
  bool disabled;

  CustomButton(
      {@required this.label, @required this.onPress, this.disabled = false});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10.0),
        child: ButtonTheme(
            minWidth: 100.0,
            child: FlatButton(
              onPressed: disabled ? null : onPress,
              child: Text(label),
              color: Colors.grey[300],
              disabledColor: Colors.grey[500],
              textColor: Colors.grey[800],
              disabledTextColor: Colors.grey[900],
            )));
  }
}
