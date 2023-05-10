import 'package:dio/dio.dart';

class DioHelper {
  // out init method in main method to excute first when app is open
  static late Dio dio;
  // static String accesstoken =
  //     SharedPreferencesHelper.getData(key: "accesstoken") ?? "";

  static init() {
    dio = Dio(BaseOptions(
      receiveDataWhenStatusError: true,
        receiveTimeout:10000000,
        connectTimeout:10000000
    ));
  }

  // static Future<Response> getData(
  //     {required String url, Map<String, dynamic>? query}) async {
  //   return await dio.get(url,
  //       queryParameters: query,
  //       options: Options(headers: {
  //         "Authorization": "Bearer ${accesstoken}",
  //       }));
  // }

  static Future<Response> postData(
      {required String url,
      required Map<String, dynamic> data,
      String token = ""}) async {
    return await dio.post(url,
        data: data,
        options: Options(headers: {
          'Accept': 'application/json',
          "Authorization": "Bearer $token",
        }, validateStatus: (_) => true));
  }

  static Future<Response?> postDataChatMessage(
      {required String url,
        required dynamic data,
        required Map<String, dynamic> headers}) async {
    try {
      Response response = await dio.post(
        url,
        options: Options(headers: headers),
        data: data,
      );

      return response;
    } on DioError catch (e) {
      // handleError(e);
      print(e);
    }
    return null;
  }
  static Future<Response> postDataPayment(
      {required String url,
        required List<Map<String, dynamic>> data,
        String token = ""}) async {
    return await dio.post(url,
        data: data,
        options: Options(headers: {
          'Accept': 'application/json',
          "Authorization": "Bearer $token",
          "content-type":"application/json"
        }, validateStatus: (_) => true));
  }

  static Future<Response> deleteData(
      {required String url, required Map<String, dynamic> data}) async {
    return await dio.delete(
      url,
      data: data,
    );
  }

  static Future<Response> updateData(
      {required String url, required Map<String, dynamic> data}) async {
    return await dio.put(url, data: data);
  }
}
