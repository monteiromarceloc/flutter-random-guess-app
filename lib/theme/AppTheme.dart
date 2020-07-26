import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class AppTheme extends StatefulWidget {
  static AppThemeData of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppThemeData>();

  const AppTheme({Key key, this.child}) : super(key: key);

  final Widget child;

  @override
  _AppThemeState createState() => _AppThemeState();
}

class _AppThemeState extends State<AppTheme> {
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
    return AppThemeData(
      size: size,
      color: color,
      onSizeChange: onSizeChange,
      onColorChange: onColorChange,
      child: widget.child,
    );
  }
}

class AppThemeData extends InheritedWidget {
  final double size;
  final Color color;
  final ValueChanged<double> onSizeChange;
  final ValueChanged<Color> onColorChange;

  AppThemeData({
    Key key,
    this.size,
    this.color,
    this.onSizeChange,
    this.onColorChange,
    Widget child,
  }) : super(key: key, child: child);

  static AppThemeData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppThemeData>();
  }

  @override
  bool updateShouldNotify(AppThemeData oldWidget) =>
      oldWidget.size != size ||
      oldWidget.onSizeChange != onSizeChange ||
      oldWidget.color != color ||
      oldWidget.onColorChange != onColorChange;
}
