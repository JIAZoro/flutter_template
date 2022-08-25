import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_template_plus/http/core/my_net_adapter.dart';
import 'package:flutter_template_plus/http/core/my_net_error.dart';
import 'package:flutter_template_plus/http/core/my_base_request.dart';

/// Dio 适配器
class DioAdapter extends MyNetAdapter {
  @override
  Future<MyNetResponse<T>> send<T>(MyBaseRequest request) async {
    var response;
    var error;
    var options = Options(headers: request.header);

    Dio _dio = Dio();
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.findProxy = (uri) {
        return "PROXY 192.168.2.8:8888";
      };
    };

    try {
      switch (request.httpMethod()) {
        case HttpMethod.GET:
          response = await _dio.get(
            request.url(),
            options: options,
          );
          break;
        case HttpMethod.POST:
          response = await _dio.post(
            request.url(),
            data: request.params,
            options: options,
          );
          break;
        case HttpMethod.PUT:
          response = await _dio.put(
            request.url(),
            data: request.params,
            options: options,
          );
          break;
        case HttpMethod.DELETE:
          response = await _dio.delete(
            request.url(),
            data: request.params,
            options: options,
          );
          break;
      }
    } on DioError catch (e) {
      error = e;
      response = e.response;
    }
    if (error != null) {
      // 抛出 MyNetError
      throw MyNetError(
        response?.statusCode ?? -1,
        error.toString(),
        data: buildRes(response, request),
      );
    }
    return buildRes<T>(response, request);
  }

  // 构建 MyNetResponse
  MyNetResponse<T> buildRes<T>(Response? response, MyBaseRequest request) {
    return MyNetResponse<T>(
      data: response?.data,
      request: request,
      statusCode: response?.statusCode,
      statusMessage: response?.statusMessage,
      extra: response,
    );
  }
}
