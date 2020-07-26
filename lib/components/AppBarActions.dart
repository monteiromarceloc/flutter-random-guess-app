import 'package:flutter/material.dart';
import 'package:flutter_random_guess_app/components/FontSizeSlider.dart';
import 'package:flutter_random_guess_app/theme/AppTheme.dart';

List<Widget> AppBarActions = [
  FontIcon(),
];

class FontIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(
          Icons.format_size,
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
            pageBuilder: (_, __, ___) => FontSizeSlider(),
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
