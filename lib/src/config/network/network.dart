import 'package:dio/dio.dart';

abstract class Network {
  Future<dynamic> get(
    String route, {
    String? token,
  });
  Future<dynamic> post(
    String route, {
    String? token,
    required FormData form,
    bool isFormData = false,
  });
  Future<dynamic> delete(
    String route,
    String token,
  );
  Future<dynamic> patch(
    String route, {
    String? token,
    required String id,
    required FormData form,
    bool isFormData = false,
  });
  Future<dynamic> put(
    String route, {
    String? token,
    required FormData form,
    bool isFormData = false,
  });
}

class NetworkImpl extends Network {
  NetworkImpl() {
    dio = Dio(
      BaseOptions(baseUrl: ""),
    );
  }

  late Dio dio;

  @override
  Future get(String route, {String? token}) async {
    var response = await dio.get(
      route,
      options: Options(
        headers: {
          if (token != null) 'Authorization': 'Bearer $token',
        },
      ),
    );

    return response.data;
  }

  @override
  Future patch(
    String route, {
    String? token,
    String? id,
    required FormData form,
    bool isFormData = false,
  }) async {
    var response = await dio.patch(
      //'$route/$id', ///don't know if it'll be needed in future
      route,
      data: form,
      options: Options(
        headers: {
          if (token != null) 'Authorization': 'Bearer $token',
          'Content-Type':
              isFormData ? 'multipart/form-data' : 'application/json'
        },
      ),
    );

    return response.data;
  }

  @override
  Future post(
    String route, {
    String? token,
    required FormData form,
    bool isFormData = false,
  }) async {
    var response = await dio.post(
      route,
      data: form,
      options: Options(
        headers: {
          if (token != null) 'Authorization': 'Bearer $token',
          'Content-Type':
              isFormData ? 'multipart/form-data' : 'application/json'
        },
      ),
    );

    return response.data;
  }

  @override
  Future delete(
    String route,
    String token,
  ) async {
    var response = await dio.delete(
      route,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
      ),
    );

    return response.data;
  }

  @override
  Future put(
    String route, {
    String? token,
    required FormData form,
    bool isFormData = false,
  }) async {
    var response = await dio.put(
      route,
      data: form,
      options: Options(
        headers: {
          if (token != null) 'Authorization': 'Bearer $token',
          'Content-Type':
              isFormData ? 'multipart/form-data' : 'application/json'
        },
      ),
    );

    return response.data;
  }
}
