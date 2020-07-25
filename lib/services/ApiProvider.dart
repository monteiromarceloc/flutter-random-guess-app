import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

import 'package:flutter_random_guess_app/models/CustomException.dart';

class ApiProvider {
  final String _baseUrl = 'https://us-central1-ss-devops.cloudfunctions.net';

  Future<dynamic> get(String url) async {
    var responseJson;
    try {
      final response = await http.get(_baseUrl + url);
      responseJson = _handleResponse(response);
    } on SocketException {
      throw CustomException(500, 'No Internet connection');
    }
    return responseJson;
  }

  dynamic _handleResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        final responseJson = jsonDecode(response.body);
        return responseJson;

      // TODO: implement other cases

      default:
        final errorBody = jsonDecode(response.body);

        if (errorBody['StatusCode'] != null || errorBody['value'] == null) {
          throw new CustomException(
            errorBody['StatusCode'],
            errorBody['Error'],
          );
        }

        throw new CustomException(500, 'Unknown error');
    }
  }
}
