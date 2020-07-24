import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {@required this.label, this.disabled = false, @required this.onPress});

  bool disabled;
  String label;
  final Function onPress;

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
