import 'package:dio/dio.dart';
import 'dart:async';
import '../config/service_url.dart';

//Future request(url, {params}) async {
//  try{
//    print('开始请求数据.....');
//    Response res;
//    Dio _dio = Dio();
//    _dio.options.responseType = ResponseType.json;
//    print(params);
//    if (params == null) {
//      print('post请求');
//      res = await _dio.post(servicePath[url]);
//    } else {
//      print('get请求');
//      res = await _dio.get(servicePath[url], queryParameters: params);
//    }
//    if (res.statusCode == 200) {
//      print('dio success');
//      return res.data;
//    } else {
//      throw Exception('后端接口出现问题');
//    }
//  }catch(e) {
//    print('ERROR=======>${e})');
//  }
//}

// 封装数据请求异步方法
Future request(url, {params}) async {
  try{
    // print('开始request请求数据.....');
    Response res;
    Dio _dio = Dio();
    if (params == null) {
      _dio.options.responseType = ResponseType.json;
      // print(params);
      res = await _dio.post(servicePath[url]);
    } else {
      _dio.options.responseType = ResponseType.plain;
      // print(params);
      res = await _dio.post(servicePath[url], data: params);
    }
    if (res.statusCode == 200) {
      return res.data;
    } else {
      throw Exception('后端接口出现问题');
    }
  }catch(e) {
    print('服务器请求失败=======>${e})');
  }
}
Future postRequestPlain(url, {params}) async {
  try{
    // print('开始postRequestPlain数据请求.....');
    Response res;
    Dio _dio = Dio();
    _dio.options.responseType = ResponseType.plain;
    if (params == null) {
      res = await _dio.post(servicePath[url]);
    } else {
      res = await _dio.post(servicePath[url], data: params);
    }
    if (res.statusCode == 200) {
      // print('postRequestPlain success');
      return res.data;
    } else {
      throw Exception('后端接口出现问题');
    }
  }catch(e) {
    print('服务器请求失败=======>${e})');
  }
}
Future postRequestJson(url, params) async {
  try{
    // print('开始postRequestJson数据请求.....');
    Response res;
    Dio _dio = Dio();
    _dio.options.responseType = ResponseType.json;
    if (params == null) {
      res = await _dio.post(servicePath[url]);
    } else {
      res = await _dio.post(servicePath[url], data: params);
    }
    if (res.statusCode == 200) {
      return res.data;
    } else {
      throw Exception('后端接口出现问题');
    }
  }catch(e) {
    print('服务器请求失败=======>${e})');
  }
}
//Future requestParams(url, {params}) async {
//  try{
//    print('开始请求数据.....');
//    Response res;
//    Dio _dio = Dio();
//    _dio.options.responseType = ResponseType.plain;
//    print(params);
//    res = await _dio.get(servicePath[url], queryParameters: params);
//    if (res.statusCode == 200) {
//      print('dio success');
//      return res.data;
//    } else {
//      throw Exception('后端接口出现问题');
//    }
//  }catch(e) {
//    print('ERROR=======>${e})');
//  }
//}
// 获取首页主体内容
//Future getHomePageContent() async {
//  try{
//    print('开始获取首页数据.........');
//    Response res;
//    Dio dio = Dio();
//    // dio.options.contentType = ContentType.parse('application/x-www-form-urlencoded') as String;
//    // 如果有参数设置参数{}
//    // 发送post请求
//    dio.options.responseType = ResponseType.json;
//    res = await dio.post(servicePath['homePageContent']);
//    // print(res);
//    if (res.statusCode == 200) {
//      print('dio success');
//      return res.data;
//    } else {
//      throw Exception('后端接口出现问题');
//    }
//  } catch(e) {
//    print('ERROR=======>${e})');
//  }
//
//
//
//}
