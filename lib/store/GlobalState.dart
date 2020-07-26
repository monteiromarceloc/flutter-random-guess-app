import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class GlobalState extends StatefulWidget {
  static GlobalStateData of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<GlobalStateData>();

  const GlobalState({Key key, this.child}) : super(key: key);

  final Widget child;

  @override
  _GlobalStateState createState() => _GlobalStateState();
}

class _GlobalStateState extends State<GlobalState> {
  double size = 10.0;
  Color color = Colors.red;

  void onSizeChange(double newValue) {
    setState(() {
      size = newValue;
    });
  }

  void onColorChange(Color newValue) {
    setState(() {
      color = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GlobalStateData(
      size: size,
      color: color,
      onSizeChange: onSizeChange,
      onColorChange: onColorChange,
      child: widget.child,
    );
  }
}

class GlobalStateData extends InheritedWidget {
  final double size;
  final Color color;
  final ValueChanged<double> onSizeChange;
  final ValueChanged<Color> onColorChange;

  GlobalStateData({
    Key key,
    this.size,
    this.color,
    this.onSizeChange,
    this.onColorChange,
    Widget child,
  }) : super(key: key, child: child);

  static GlobalStateData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<GlobalStateData>();
  }

  @override
  bool updateShouldNotify(GlobalStateData oldWidget) =>
      oldWidget.size != size ||
      oldWidget.onSizeChange != onSizeChange ||
      oldWidget.color != color ||
      oldWidget.onColorChange != onColorChange;
}
