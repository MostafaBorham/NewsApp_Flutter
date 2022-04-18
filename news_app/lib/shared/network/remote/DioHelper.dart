// ignore_for_file: file_names
import 'package:dio/dio.dart';
import 'package:news_app/shared/network/remote/EndPoints.dart';

class DioHelper {
  static Dio? dio;

  static initNewsApp(String language) {
    dio = Dio(BaseOptions(
      baseUrl: BASE_URL,
      receiveDataWhenStatusError: true,
      headers: {
        'language' : language,
      }
    ));
  }

  static Future<Response> getData({required String url, dynamic query}) async {
    return await dio!.get(url, queryParameters: query);
  }

  static Future<Response> postData(String url, {dynamic data}) async {
    return await dio!.post(url, data: data);
  }

  static Future<Response> putData(String url, {dynamic data}) async {
    return await dio!.put(url, data: data);
  }
}
