class CustomException implements Exception {
  final _message;
  final _status;

  CustomException([this._status, this._message]);

  int get StatusCode => _status;
  String get ErrorMessage => _message;

  String toString() {
    return "Status: $_status \nMessage: $_message";
  }
}
