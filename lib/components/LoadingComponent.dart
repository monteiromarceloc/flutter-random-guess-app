import 'package:flutter/material.dart';
import 'package:loading/loading.dart';
import 'package:loading/indicator/ball_beat_indicator.dart';

class LoadingComponent extends StatelessWidget {
  LoadingComponent();

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Loading(
            indicator: BallBeatIndicator(), size: 80.0, color: Colors.red));
  }
}
