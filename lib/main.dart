import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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
  int _randomNumber;
  final requestHandler = new RequestHandler();

  Future<void> _fetchRandomNumber() async {
    try {
      int value = await requestHandler._getNum();
      setState(() {
        _randomNumber = value;
      });
    } catch (error) {
      print(error.toString());
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
              Text(
                'You have pushed the button this many times:',
              ),
              Text(
                _randomNumber != null ? '$_randomNumber' : "0",
                style: Theme.of(context).textTheme.headline4,
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
      throw new Exception(body);
    }

    return body['value'];
  }
}

class CustomException implements Exception {
  CustomException(this.body);
  final body;
}
