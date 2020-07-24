import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:segment_display/segment_display.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
  int _inputNumber = 0;
  int _randomNumber = 0;
  String _textToDisplay = '';
  final requestHandler = new RequestHandler();

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
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(_textToDisplay),
              SevenSegmentDisplay(
                value: _randomNumber.toString(),
                size: 10.0,
                characterSpacing: 4.0,
                backgroundColor: Colors.transparent,
                segmentStyle: HexSegmentStyle(
                  enabledColor: Colors.red,
                  disabledColor: Colors.grey.withOpacity(0.15),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _fetchRandomNumber,
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ));
  }
}

class RequestHandler {
  Future<int> _getNum() async {
    final url =
        'https://us-central1-ss-devops.cloudfunctions.net/rand?min=1&max=300';
    final response = await http.get(url);
    final body = jsonDecode(response.body);

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
