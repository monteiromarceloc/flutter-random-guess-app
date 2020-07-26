import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_random_guess_app/store/GlobalState.dart';
import 'package:flutter_random_guess_app/screens/HomePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return GlobalState(
        child: MaterialApp(
      title: 'Qual é o número?',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    ));
  }
}
