import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../models/generic_response.dart';

enum HttpRequestType {
  get,
  post,
  put,
  delete,
}

class HttpClientWrapper {
  static final Dio dio = Dio();

  static String apiUrl(String url, Map<String, dynamic>? queryParams) {
    return Uri.parse(url).replace(queryParameters: queryParams).toString();
  }

  static Future<Dio> _dio(String? token) async {
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
    };

    if (token != null) {
      headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
    }
    dio.options.headers = headers;
    dio.options.connectTimeout = const Duration(milliseconds: 60000);
    dio.options.receiveTimeout = const Duration(milliseconds: 60000);

    return dio;
  }

  Future<GenericResponse> _executeHttpRequest(HttpRequestType httpRequestType,
      String path, Map<String, dynamic>? queryParams,
      {dynamic body, String? token}) async {
    Response dioResponse;
    GenericResponse response = GenericResponse();
    final dio = await _dio(token);
    debugPrint('Url: ${apiUrl(path, queryParams)}');
    try {
      body = jsonEncode(body);
      switch (httpRequestType) {
        case HttpRequestType.get:
          dioResponse = await dio.get(
            apiUrl(path, queryParams),
          );
          break;
        case HttpRequestType.post:
          dioResponse = await dio.post(
            apiUrl(path, queryParams),
            data: body,
          );
          break;
        case HttpRequestType.put:
          dioResponse = await dio.put(
            apiUrl(path, queryParams),
            data: body,
          );
          break;
        case HttpRequestType.delete:
          dioResponse = await dio.delete(apiUrl(path, queryParams));
          break;
      }
      //If request was successful

      response.success = true;
      response.body = dioResponse.data;
      response.status = dioResponse.statusCode!;
      response.message = dioResponse.statusMessage!;
      debugPrint('STATUS CODE: ${dioResponse.statusCode!}');
      debugPrint('SUCCESS: True');
      debugPrint('MESSAGE: ${dioResponse.statusMessage!}');
      debugPrint('RESPONSE BODY: ${dioResponse.data}');

      return response;
    } catch (e) {
      final dioError = e as DioException;
      debugPrint(dioError.response.toString());
      if (dioError.response?.data is Map) {
        var responseMap = dioError.response?.data as Map;
        if (responseMap.containsKey('message')) {
          response.message = (responseMap['message']).toString();
        } else {
          response.body = dioError.response?.data;
        }
      } else {
        response.message =
            dioError.message ?? 'An error occurred, please try again.';
      }

      response.status = dioError.response?.statusCode ?? 400;
      response.error = dioError.error;
      response.success = false;
      response.body = dioError.response?.data;
      debugPrint('STATUS CODE: ${response.status}');
      debugPrint('SUCCESS: False');
      debugPrint('ERROR: ${response.error}');
      debugPrint('MESSAGE: ${response.message}');
      debugPrint('RESPONSE BODY: ${response.body}');
      return response;
    }
  }

  Future<GenericResponse> get(String path,
      {Map<String, dynamic>? queryParams, String? token}) async {
    return await _executeHttpRequest(HttpRequestType.get, path, queryParams,
        token: token);
  }

  Future<GenericResponse> post(String path,
      {Map<String, dynamic>? queryParams, dynamic body, String? token}) async {
    return await _executeHttpRequest(HttpRequestType.post, path, queryParams,
        body: body, token: token);
  }

  Future<GenericResponse> put(String path,
      {Map<String, dynamic>? queryParams, dynamic body, String? token}) async {
    return await _executeHttpRequest(HttpRequestType.put, path, queryParams,
        body: body, token: token);
  }

  Future<GenericResponse> deleteRequest(String path,
      {Map<String, dynamic>? queryParams, String? token}) async {
    return await _executeHttpRequest(HttpRequestType.delete, path, queryParams,
        token: token);
  }
}
