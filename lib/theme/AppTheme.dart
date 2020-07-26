import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class AppTheme extends InheritedWidget {
  final theme;

  AppTheme({this.theme, Widget child}) : super(child: child);

  @override
  updateShouldNotify(InheritedWidget old) => true;

  static AppTheme of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppTheme>();
}
