import 'package:flutter/material.dart';
import 'package:flutter_random_guess_app/components/FontSizeSlider.dart';
import 'package:flutter_random_guess_app/components/ColorPicker.dart';

List<Widget> AppBarActions = [
  FontIcon(),
  ColorIcon(),
];

class FontIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseIcon(icon: Icons.format_size, widgetToOpen: FontSizeSlider());
  }
}

class ColorIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseIcon(icon: Icons.palette, widgetToOpen: ColorPicker());
  }
}

class BaseIcon extends StatelessWidget {
  final IconData icon;
  final Widget widgetToOpen;

  BaseIcon({this.icon, this.widgetToOpen});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(
          icon,
          color: Colors.white,
          size: 30.0,
        ),
        onPressed: () {
          showGeneralDialog(
            barrierLabel: "Barrier",
            barrierDismissible: true,
            barrierColor: Colors.black.withOpacity(0.5),
            transitionDuration: Duration(milliseconds: 300),
            context: context,
            pageBuilder: (_, __, ___) => widgetToOpen,
            transitionBuilder: (_, anim, __, child) {
              return SlideTransition(
                position:
                    Tween(begin: Offset(1, 0), end: Offset(0, 0)).animate(anim),
                child: child,
              );
            },
          );
        });
  }
}
