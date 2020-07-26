import 'package:flutter/material.dart';
import 'package:flutter_random_guess_app/store/GlobalState.dart';

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
          max: 10.0,
          value: GlobalState.of(context).size,
          onChanged: GlobalState.of(context).onSizeChange,
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
