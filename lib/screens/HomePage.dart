import 'package:flutter/material.dart';

import 'package:flutter_random_guess_app/repositories/RandomNumberRepository.dart';
import 'package:flutter_random_guess_app/models/NumberResponse.dart';
import 'package:flutter_random_guess_app/models/CustomException.dart';
import 'package:flutter_random_guess_app/components/DisplayContainer.dart';
import 'package:flutter_random_guess_app/components/FormRow.dart';
import 'package:flutter_random_guess_app/components/LoadingComponent.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _inputText = '0';
  int _randomNumber = 0;
  String _textToDisplay = '';
  bool _showPlayAgainButton = false;
  bool _isLoading = true;

  final myController = TextEditingController();
  final randomNumberRepository = new RandomNumberRepository();

  Future<void> _fetchRandomNumber() async {
    setState(() {
      _isLoading = true;
    });
    try {
      NumberResponse res = await randomNumberRepository.getValue();
      int value = res.value;
      setState(() {
        _randomNumber = value;
      });
    } on CustomException catch (error) {
      setState(() {
        _inputText = error.StatusCode.toString();
        _textToDisplay = error.ErrorMessage;
        _showPlayAgainButton = true;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchRandomNumber();
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
          margin: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _isLoading
                  ? LoadingComponent()
                  : DisplayContainer(
                      label: _textToDisplay,
                      displayText: _inputText,
                      showButton: _showPlayAgainButton,
                      onRestart: () {
                        setState(() {
                          _inputText = '0';
                          _textToDisplay = '';
                          _showPlayAgainButton = false;
                        });
                        _fetchRandomNumber();
                      }),
              FormRow(
                myController: myController,
                disableButton: _showPlayAgainButton || _isLoading,
                onSubmit: () {
                  int inputNumber = int.parse(myController.text);
                  bool didHit = inputNumber == _randomNumber;
                  setState(() {
                    _inputText = myController.text;
                    _textToDisplay = didHit
                        ? "Acertou!"
                        : inputNumber < _randomNumber ? "É maior" : "É menor";
                    _showPlayAgainButton = didHit;
                  });
                  myController.clear();
                },
              )
            ],
          ),
        ));
  }
}
