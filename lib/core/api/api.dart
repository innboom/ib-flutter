import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ib/core/event_bus.dart';
import 'package:ib/core/secure_storage.dart';

class Api {
  // 单例模式
  static final Api _instance = Api._internal();

  factory Api() => _instance;

  Api._internal() {
    _init();
  }

  late final Dio _dio;
  static const String _baseUrl = "https://dev.innboom.com/prod-api";

  // 初始化请求配置
  void _init() {
    _dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        responseType: ResponseType.json,
        connectTimeout: const Duration(seconds: 5), // 设置连接超时
        receiveTimeout: const Duration(seconds: 5), // 设置接收超时
      ),
    )..interceptors.addAll([
      ApiInterceptor(), // 监听器
    ]);
  }

  // 统一请求逻辑
  Future<Map<String, dynamic>> _httpRequest(
      String method, String path, {
        Map<String, dynamic>? data = const {},
      }) async {
    try {
      late Response response;

      switch (method) {
        case 'GET':
          final queryParameters =
          data!.isNotEmpty ? Uri(queryParameters: data).query : '';
          final url = path + (queryParameters.isNotEmpty ? '?$queryParameters' : '');
          response = await _dio.get(url);
          break;

        case 'POST':
          final jsonData = json.encode(data);
          response = await _dio.post(path, data: jsonData);
          break;

        case 'PUT':
          final jsonData = json.encode(data);
          response = await _dio.put(path, data: jsonData);
          break;

        case 'DELETE':
          response = await _dio.delete(path);
          break;
      }

      return _handleResponse(response);
    } catch (e) {
      rethrow; // 将异常抛出，外层可以捕获
    }
  }

  // GET请求
  Future<Map<String, dynamic>> httpGet(String path,
      {Map<String, dynamic> data = const {}}) async {
    return _httpRequest('GET', path, data: data);
  }

  // POST请求
  Future<Map<String, dynamic>> httpPost(String path,
      {Map<String, dynamic>? data = const {}}) async {
    return _httpRequest('POST', path, data: data);
  }

  // PUT请求
  Future<Map<String, dynamic>> httpPut(String path,
      {Map<String, dynamic>? data = const {}}) async {
    return _httpRequest('PUT', path, data: data);
  }

  // DELETE请求
  Future<Map<String, dynamic>> httpDelete(String path,
      {Map<String, dynamic>? data = const {}}) async {
    return _httpRequest('DELETE', path, data: data);
  }

  // 处理响应
  Map<String, dynamic> _handleResponse(Response response) {
    final data = response.data is String ? json.decode(response.data) : response.data;
    final int? code = data['code'];

    if (code != 200) {
      throw DioException(
        type: DioExceptionType.badResponse,
        requestOptions: response.requestOptions,
        response: response,
        error: data['message'] ?? '未知错误',
      );
    }

    return data;
  }
}

// 监听 API 错误
class ApiInterceptor extends Interceptor {
  final SecureStorage _storage = SecureStorage();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      final String? token = await _storage.get('token');
      if (token != null) {
        options.headers['Authorization'] = token;
      }
    } catch (e) {
      // 捕获读取 token 异常，避免请求失败
      print('TokenInterceptor Error: $e');
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    try {
      final data =
      response.data is String ? json.decode(response.data) : response.data;
      final int? code = data['code'];

      if (code == 401) {
        // 触发登出事件
        EventBus.instance.commit(EventKeys.logout, "没有权限");
      }

      // 替换解析后的数据
      handler.next(response..data = data);
    } catch (e) {
      handler.reject(
        DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          error: 'Response parsing error: $e',
        ),
      );
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final int? statusCode = err.response?.statusCode;

    // 统一处理不同类型的错误
    if (statusCode == 401) {
      EventBus.instance.commit(EventKeys.logout, "没有权限");
    }

    super.onError(err, handler);
  }
}
