import 'dart:async';

import 'package:flutter_random_guess_app/services/ApiProvider.dart';
import 'package:flutter_random_guess_app/models/NumberResponse.dart';

class RandomNumberRepository {
  ApiProvider _provider = ApiProvider();

  Future<NumberResponse> getValue() async {
    final response = await _provider.get('/rand?min=1&max=300');
    print(response.toString());
    return NumberResponse.fromJson(response);
  }
}
