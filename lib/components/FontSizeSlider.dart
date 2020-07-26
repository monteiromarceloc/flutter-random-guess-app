import 'package:flutter/material.dart';
import 'package:flutter_random_guess_app/theme/AppTheme.dart';

class FontSizeSlider extends StatelessWidget {
  FontSizeSlider();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: 80,
        child: Material(
            child: Slider(
          min: 5.0,
          max: 15.0,
          divisions: 9,
          value: AppTheme.of(context).size,
          onChanged: AppTheme.of(context).onSizeChange,
        )),
        margin: EdgeInsets.only(top: 100, left: 12, right: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
