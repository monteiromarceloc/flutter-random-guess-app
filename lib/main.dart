import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:segment_display/segment_display.dart';

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
  bool _isLoading = true;

  final requestHandler = new RequestHandler();
  final myController = TextEditingController();

  Future<void> _fetchRandomNumber() async {
    try {
      int value = await requestHandler._getNum();
      setState(() {
        _randomNumber = value;
      });
    } catch (error) {
      setState(() {
        _randomNumber = error.StatusCode;
        _textToDisplay = error.ErrorMessage;
        _showPlayAgainButton = true;
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
            child: Column(children: <Widget>[
              Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(bottom: 20.0),
                        child: Text(
                          _textToDisplay,
                          style: Theme.of(context).textTheme.headline6,
                        )),
                    SevenSegmentDisplay(
                      value: _inputText,
                      size: 10.0,
                      characterSpacing: 4.0,
                      backgroundColor: Colors.transparent,
                      segmentStyle: HexSegmentStyle(
                        enabledColor: Colors.red,
                        disabledColor: Colors.grey.withOpacity(0.15),
                      ),
                    ),
                    Visibility(
                        visible: _showPlayAgainButton,
                        child: ButtonTheme(
                            minWidth: 120.0,
                            child: FlatButton(
                              onPressed: () {
                                _fetchRandomNumber();
                                myController.clear();
                                setState(() {
                                  _inputText = '0';
                                  _textToDisplay = '';
                                  _showPlayAgainButton = false;
                                  _isLoading = true;
                                });
                              },
                              child: Text(
                                "Nova Partida",
                              ),
                            ))),
                  ])),
              // Text(_randomNumber.toString()),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: myController,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2.0)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 2.0)),
                        hintText: 'Digite o palpite',
                      ),
                      maxLength: 3,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  ButtonTheme(
                      minWidth: 120.0,
                      child: FlatButton(
                        onPressed: () {
                          int inputNumber = int.parse(myController.text);
                          bool didHit = inputNumber == _randomNumber;
                          print(inputNumber.toString() +
                              " == " +
                              _randomNumber.toString());
                          setState(() {
                            _inputText = myController.text;
                            _textToDisplay = didHit
                                ? "Acertou!"
                                : inputNumber < _randomNumber
                                    ? "É maior"
                                    : "É menor";
                            _showPlayAgainButton = didHit;
                          });
                          myController.clear();
                        },
                        child: Text(
                          "Enviar",
                        ),
                      ))
                ],
              ),
            ])));
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
