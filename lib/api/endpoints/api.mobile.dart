import 'package:http/http.dart' as http;

final http.Client _cookieEnabledClient = http.Client();

http.Client getHttpClient() {
  return _cookieEnabledClient;
}
