// ignore_for_file: non_constant_identifier_names
import 'dart:convert';
import 'package:egresadoapp/utils/loading.dart';
import 'package:http/browser_client.dart';
import 'package:http/http.dart' as http;

import '../../utils/errors.dart';

const current = String.fromEnvironment("target");
final allHeaders = {
  "Accept": "*/*",
  "Access-Control-Allow-Origin": "http://localhost:8000",
  "Access-Control-Allow-Methods": "GET, POST, PUT, DELETE, OPTIONS, HEAD"
};

class Api {
  static String URL = current;
  static String AUTH = URL + Endpoints.AUTH;
  static String COLABORACIONES = URL + Endpoints.COLABORACIONES;
  static String EVENTOS = URL + Endpoints.EVENTOS;
  static String IDIOMAS = URL + Endpoints.IDIOMAS;
  static String OFERTAS = URL + Endpoints.OFERTAS;
  static String SKILLS = URL + Endpoints.SKILLS;
  static String USUARIOS = URL + Endpoints.USUARIOS;

  static dynamic GET_REQUEST(String url, {Map<String, dynamic>? params}) async {
    Uri uri = Uri.parse(url);
    if (params != null) {
      uri = uri.replace(queryParameters: params);
    }

    final response = await _getHttpClient().get(
      uri,
      headers: allHeaders,
    );

    final code = response.statusCode;
    final rawJsonString = response.body;

    dynamic res = jsonDecode(rawJsonString);
    if (code >= 400) {
      String message = res["message"] ?? defaultErrorMessage;
      LoadingHandler.showToastWithoutContext(message, isError: true);
      throw ApiException(code: code, message: message);
    } else {
      String? message = res["message"];
      if (message != null) {
        LoadingHandler.showToastWithoutContext(message, isError: false);
      }
    }

    return res;
  }

  static dynamic POST_REQUEST(String url, [Object? body]) async {
    final parsedUrl = Uri.parse(url);

    final response =
        await _getHttpClient().post(parsedUrl, headers: allHeaders, body: body);

    final code = response.statusCode;

    final rawJsonString = response.body;
    dynamic res = jsonDecode(rawJsonString);

    if (code >= 400) {
      String message = res["message"] ?? defaultErrorMessage;

      LoadingHandler.showToastWithoutContext(message, isError: true);
      throw ApiException(code: code, message: message);
    } else {
      String? message = res["message"];
      if (message != null) {
        LoadingHandler.showToastWithoutContext(message, isError: false);
      }
    }

    return res;
  }

  static dynamic MULTIPART_REQUEST(String url,
      {Map<String, dynamic>? params,
      List<http.MultipartFile>? files,
      String method = "POST"}) async {
    Uri parsedUrl = Uri.parse(url);
    if (params != null) {
      parsedUrl = parsedUrl.replace(queryParameters: params);
    }

    http.MultipartRequest request = http.MultipartRequest(method, parsedUrl);

    if (files != null && files.isNotEmpty) {
      request.files.addAll(files);
    }
    final sent = await _getHttpClient().send(request);

    final response = await http.Response.fromStream(sent);
    final code = response.statusCode;

    final rawJsonString = response.body;
    dynamic res = jsonDecode(rawJsonString);

    if (code >= 400) {
      String message = res["message"] ?? defaultErrorMessage;

      LoadingHandler.showToastWithoutContext(message, isError: true);
      throw ApiException(code: code, message: message);
    } else {
      String? message = res["message"];
      if (message != null) {
        LoadingHandler.showToastWithoutContext(message, isError: false);
      }
    }

    return res;
  }

  static dynamic PUT_REQUEST(String url,
      {Map<String, dynamic>? params, Object? body}) async {
    Uri parsedUrl = Uri.parse(url);
    if (params != null) {
      parsedUrl = parsedUrl.replace(queryParameters: params);
    }
    final response =
        await _getHttpClient().put(parsedUrl, headers: allHeaders, body: body);
    final code = response.statusCode;
    final rawJsonString = response.body;

    dynamic res = jsonDecode(rawJsonString);

    if (code >= 400) {
      String message = res["message"] ?? defaultErrorMessage;
      LoadingHandler.showToastWithoutContext(message, isError: true);
      throw ApiException(code: code, message: message);
    } else {
      String? message = res["message"];
      if (message != null) {
        LoadingHandler.showToastWithoutContext(message, isError: false);
      }
    }
    return res;
  }

  static dynamic DELETE_REQUEST(String url,
      {Map<String, dynamic>? params, Object? body}) async {
    Uri parsedUrl = Uri.parse(url);
    if (params != null) {
      parsedUrl = parsedUrl.replace(queryParameters: params);
    }
    final response = await _getHttpClient()
        .delete(parsedUrl, headers: allHeaders, body: body);
    final code = response.statusCode;
    final rawJsonString = response.body;
    dynamic res = jsonDecode(rawJsonString);

    if (code >= 400) {
      String message = res["message"] ?? defaultErrorMessage;

      LoadingHandler.showToastWithoutContext(message, isError: true);
      throw ApiException(code: code, message: message);
    } else {
      String? message = res["message"];
      if (message != null) {
        LoadingHandler.showToastWithoutContext(message, isError: false);
      }
    }
    return res;
  }
}

// print("PETO MI API");
// print(res["validationError"]);

// const LOCAL_URL = Platform.OS=="ios"? 'http://localhost:5000/api' : 'http://10.0.2.2:5000/api';

final http.Client cookieEnabledClient = http.Client();

const defaultErrorMessage =
    "Ha habido un error en nuestros servidores. Contacte con un administrador.";

http.Client _getHttpClient() {
  if (cookieEnabledClient is BrowserClient) {
    (cookieEnabledClient as BrowserClient).withCredentials = true;
  }

  return cookieEnabledClient;
}

class Endpoints {
  static String URL = current;
  static String AUTH = "/api/authentication";
  static String COLABORACIONES = "/api/colaboraciones";
  static String EVENTOS = "/api/eventos";
  static String IDIOMAS = "/api/idiomas";
  static String OFERTAS = "/api/ofertas";
  static String SKILLS = "/api/skills";
  static String USUARIOS = "/api/usuarios";
}
