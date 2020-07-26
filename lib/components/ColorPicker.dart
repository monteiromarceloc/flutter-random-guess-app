import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:flutter_random_guess_app/store/GlobalState.dart';

class ColorPicker extends StatelessWidget {
  ColorPicker();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: 240,
        child: Material(
            child: MaterialColorPicker(
          onColorChange: GlobalState.of(context).onColorChange,
          selectedColor: GlobalState.of(context).color,
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
