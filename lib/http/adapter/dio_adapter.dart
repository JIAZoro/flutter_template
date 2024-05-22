import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_template_plus/flavor_config.dart';
import 'package:flutter_template_plus/http/core/my_net_adapter.dart';
import 'package:flutter_template_plus/http/core/my_net_error.dart';
import 'package:flutter_template_plus/http/core/my_base_request.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Dio 适配器
class DioAdapter extends MyNetAdapter {
  @override
  Future<MyNetResponse<T>> send<T>(MyBaseRequest request) async {
    var response;
    var error;
    var options = Options(headers: request.header);

    Dio _dio = Dio();
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
      // 忽略证书验证，生产模式慎用
      if (FlavorConfig.instance.flavor == Flavor.DevEnv) {
        client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      }
      
      client.findProxy = (uri) {
        String proxyip = '';
        SharedPreferences.getInstance().then((prf) {
          if ((prf.getString('proxy') ?? '').length > 0) {
            proxyip ="PROXY ${prf.getString('proxy')}";
          } else {
            proxyip = "DIRECT";
          }
        });
        return proxyip;
      };
      return client;
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
