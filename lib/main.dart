import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'display_container.dart';
import 'form_row.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      title: 'Qual é o número?',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(title: 'Qual é o número?'),
    );
  }
}

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
  bool _isLoading = false;

  final requestHandler = new RequestHandler();
  final myController = TextEditingController();

  Future<void> _fetchRandomNumber() async {
    setState(() {
      _isLoading = true;
    });
    try {
      int value = await requestHandler._getNum();
      setState(() {
        _randomNumber = value;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _inputText = error.StatusCode.toString();
        _textToDisplay = error.ErrorMessage;
        _showPlayAgainButton = true;
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
              DisplayContainer(
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
                disableButton: _showPlayAgainButton,
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

class RequestHandler {
  Future<int> _getNum() async {
    final url =
        'https://us-central1-ss-devops.cloudfunctions.net/rand?min=1&max=300';
    final response = await http.get(url);
    final body = jsonDecode(response.body);
    print(body.toString());

    if (body['StatusCode'] != null || body['value'] == null) {
      throw new CustomException(
        StatusCode: body['StatusCode'],
        ErrorMessage: body['Error'],
      );
    }
    return body['value'];
  }
}

class CustomException implements Exception {
  CustomException({@required this.StatusCode, @required this.ErrorMessage});
  int StatusCode;
  String ErrorMessage;
}
