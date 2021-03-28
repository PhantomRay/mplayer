import 'package:dio/dio.dart';

class Http {
  static Dio _dio;

  static final Http _singleton = Http._internal();

  factory Http() {
    return _singleton;
  }

  static Http get instance => Http();
  Dio get currentDio => _dio;

  Http._internal() {
    BaseOptions options = BaseOptions(
        connectTimeout: 15000,
        receiveTimeout: 15000,
        //contentType: Headers.jsonContentType,
        responseType: ResponseType.plain);

    _dio = new Dio(options);

    _dio.interceptors.add(AdapterInterceptor());
  }

  get(String url, {Map<String, dynamic> data}) async {
    Response response = await _dio.get(url, queryParameters: data);

    return response;
  }

  getBytes(String url, {Map<String, dynamic> data}) async {
    Response response = await _dio.get(url, queryParameters: data, options: Options(responseType: ResponseType.bytes));

    return response;
  }

  post(String url, {dynamic data}) async {
    Response response = await _dio.post(url, data: data);

    return response;
  }

  put(String url, {dynamic data}) async {
    Response response = await _dio.put(url, data: data);

    return response;
  }

  delete(String url, {Map<String, dynamic> data}) async {
    Response response = await _dio.delete(url, data: data);

    return response;
  }
}

class AdapterInterceptor extends Interceptor {
  @override
  onRequest(Options options) async {
    return super.onRequest(options);
  }

  @override
  onResponse(Response response) {
    return super.onResponse(response);
  }

  @override
  onError(DioError err) {
    return super.onError(err);
  }
}
