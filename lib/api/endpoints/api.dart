// ignore_for_file: non_constant_identifier_names
import 'dart:convert';
import 'package:egresadoapp/api/endpoints/api_local.dart';
import 'package:egresadoapp/utils/loading.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'api.web.dart' if (dart.library.io) "api.mobile.dart" as cliente;

import '../../utils/errors.dart';

const current = String.fromEnvironment("target");
// const current = "https://egresado-production.up.railway.app";
final allHeaders = {
  "Accept": "*/*",
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Methods": "GET, POST, PUT, DELETE, OPTIONS, HEAD"
};
final allHeadersWithContentType = {
  ...allHeaders,
  "Content-Type": "application/json",
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
    String? token = kIsWeb ? null : await ApiLocal.getCookie();

    Uri uri = Uri.parse(url);
    if (params != null) {
      uri = uri.replace(queryParameters: params);
    }

    final response = await cliente.getHttpClient().get(
      uri,
      headers: {
        ...allHeaders,
        ...token != null ? {"Cookie": token} : {}
      },
    );
    try {
      String? sesion = response.headers["set-cookie"];
      if (sesion != null && sesion.isNotEmpty) {
        await ApiLocal.setCookie(sesion.split(";")[0]);
      }
    } catch (_) {}
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
    String? token = kIsWeb ? null : await ApiLocal.getCookie();

    final parsedUrl = Uri.parse(url);

    final response = await cliente.getHttpClient().post(parsedUrl,
        headers: {
          ...allHeadersWithContentType,
          ...token != null ? {"Cookie": token} : {}
        },
        body: jsonEncode(body ?? {}));
    try {
      String? sesion = response.headers["set-cookie"];
      if (sesion != null && sesion.isNotEmpty) {
        await ApiLocal.setCookie(sesion.split(";")[0]);
      }
    } catch (_) {}
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
    String? token = kIsWeb ? null : await ApiLocal.getCookie();

    Uri parsedUrl = Uri.parse(url);
    if (params != null) {
      parsedUrl = parsedUrl.replace(queryParameters: params);
    }

    final response = await cliente.getHttpClient().put(parsedUrl,
        headers: {
          ...allHeadersWithContentType,
          ...token != null ? {"Cookie": token} : {}
        },
        body: jsonEncode(body));
    try {
      String? sesion = response.headers["set-cookie"];
      if (sesion != null && sesion.isNotEmpty) {
        await ApiLocal.setCookie(sesion.split(";")[0]);
      }
    } catch (_) {}
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
    String? token = kIsWeb ? null : await ApiLocal.getCookie();

    Uri parsedUrl = Uri.parse(url);
    if (params != null) {
      parsedUrl = parsedUrl.replace(queryParameters: params);
    }
    final response = await cliente.getHttpClient().delete(parsedUrl,
        headers: {
          ...allHeaders,
          ...token != null ? {"Cookie": token} : {}
        },
        body: body);
    try {
      String? sesion = response.headers["set-cookie"];
      if (sesion != null && sesion.isNotEmpty) {
        await ApiLocal.setCookie(sesion.split(";")[0]);
      }
    } catch (_) {}
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
    String? token = kIsWeb ? null : await ApiLocal.getCookie();

    Uri parsedUrl = Uri.parse(url);
    if (params != null) {
      parsedUrl = parsedUrl.replace(queryParameters: params);
    }

    http.MultipartRequest request = http.MultipartRequest(method, parsedUrl);

    if (files != null && files.isNotEmpty) {
      request.files.addAll(files);
    }
    request.headers.addAll(token != null ? {"Cookie": token} : {});
    final sent = await cliente.getHttpClient().send(request);

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
}

// const LOCAL_URL = Platform.OS=="ios"? 'http://localhost:5000/api' : 'http://10.0.2.2:5000/api';

const defaultErrorMessage =
    "Ha habido un error en nuestros servidores. Contacte con un administrador.";

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
