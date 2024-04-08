import 'dart:io';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:mini_pos/_application/application.dart';

class ApiService {
  late final Dio _dio;
  late final Logger _logger;

  /// Retrieves the singleton instance of `ApiService`.
  static final ApiService I = ApiService._();

  factory ApiService() {
    return I;
  }

  /// making dio to construct one instance when calling api service.
  ApiService._() {
    _logger = Logger();
    _dio = Dio();
  }

  String? _token;

  /// Sets the authorization token for API requests.
  set setToken(String token) {
    _token = token;
  }

  /// Makes a request to the API.
  ///
  /// `sendData` is the data to send to the API.
  ///
  /// `baseUrl` overrides the default base URL if provided.
  ///
  /// `path` is the endpoint path after the base URL.
  ///
  /// `queryParameters` are optional query parameters for the request.
  ///
  /// `isAlreadyHaveToken` indicates whether to use the token set via [setToken].
  ///
  /// `token` allows setting the token manually.
  ///
  /// Throws an error if [sendData] is empty.
  Future<Object> callApi({
    required Map<String, dynamic> sendData,
    String? baseUrl,
    String? path,
    bool isAlreadyHaveToken = true,
    Map<String, dynamic>? queryParameters,
    String? token,
    String apiMethod = "GET",
  }) async {
    if (apiMethod != ApiConstants.I.get && sendData.isEmpty) {
      throw ArgumentError("Send data cannot be empty");
    }

    final base = baseUrl ?? ApiConstants.I.baseUrl;

    _logger.d(
        "Calling API => Base URL: $base, Path: ${path ?? ''}, Query Parameters: $queryParameters");

    try {
      final res = await _dio.fetch<Map<String, dynamic>>(
        RequestOptions(
          baseUrl: base,
          path: path ?? "",
          method: apiMethod,
          data: apiMethod != ApiConstants.I.get ? sendData : null,
          queryParameters: queryParameters,
          headers: _buildHeader(isAlreadyHaveToken, token),
        ),
      );

      _logger.i("API Response => Data: ${res.data}");

      return _handleResponse(res);
    } catch (e) {
      return _handleError(e);
    }
  }

  Map<String, dynamic>? _buildHeader(bool isAlreadyHaveToken, String? token) {
    return isAlreadyHaveToken || token != null
        ? {'Authorization': "Bearer ${token ?? _token}"}
        : null;
  }

  Object _handleResponse(Response<Map<String, dynamic>> res) {
    if (res.statusCode == HttpStatus.ok) {
      return Success(response: res.data!);
    }
    return Failure(errorResponse: res.data!);
  }

  Object _handleError(dynamic e) {
    if (e is DioException) {
      return Failure(errorResponse: {
        "title": "Dio Error",
        "message": e.toString(),
      });
    } else if (e is SocketException) {
      return Failure(errorResponse: {
        "title": "Network Error",
        "message": "No Internet connection",
      });
    } else {
      return Failure(errorResponse: {
        "title": "Unknown error",
        "message": e.toString(),
      });
    }
  }

  /// for downloading files and photos from http
  Future<String?> download(
      {required String httpUrlPath, required String savePath}) async {
    try {
      final res = await _dio.download(httpUrlPath, savePath);

      if (res.statusCode == HttpStatus.ok) {
        _logger.i("Download successfully");

        return httpUrlPath;
      }
    } catch (e) {
      _logger.e("Error downloading => $e");
    }
    return null;
  }
}
