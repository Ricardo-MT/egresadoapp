import 'package:http/browser_client.dart';
import 'package:http/http.dart' as http;

final http.Client _cookieEnabledClient = http.Client();

http.Client getHttpClient() {
  if (_cookieEnabledClient is BrowserClient) {
    (_cookieEnabledClient as BrowserClient).withCredentials = true;
  }

  return _cookieEnabledClient;
}
