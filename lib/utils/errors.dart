class ApiException implements Exception {
  String message;
  int code;
  ApiException({required this.code, this.message = ""});
}
