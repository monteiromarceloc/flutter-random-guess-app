import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_random_guess_app/theme/AppTheme.dart';
import 'package:flutter_random_guess_app/screens/HomePage.dart';
import 'package:flutter_random_guess_app/theme/ThemeRepository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return AppTheme(
        theme: new ThemeRepository(color: Colors.red, size: 10.0),
        child: MaterialApp(
          title: 'Qual é o número?',
          theme: ThemeData(
            primarySwatch: Colors.red,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: HomePage(title: 'Qual é o número?'),
        ));
  }
}
