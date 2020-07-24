import 'package:flutter/material.dart';
import 'custom_button.dart';

class FormRow extends StatelessWidget {
  FormRow(
      {@required this.myController,
      this.disableButton,
      @required this.onSubmit});

  bool disableButton;
  var myController;
  final Function onSubmit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            controller: myController,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2.0)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 2.0)),
              hintText: 'Digite o palpite',
            ),
            maxLength: 3,
            keyboardType: TextInputType.number,
          ),
        ),
        CustomButton(
          label: "Enviar",
          onPress: onSubmit,
          disabled: disableButton,
        )
      ],
    );
  }
}
