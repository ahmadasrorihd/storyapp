import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:story_app/models/add_story.dart';
import 'package:story_app/models/detail_story.dart';
import 'package:story_app/models/list_story.dart';
import 'package:story_app/models/login.dart';
import 'package:story_app/models/register.dart';

import '../utils/constant.dart';

class ApiClient {
  final Dio _dio = Dio();

  Future<ListStoryResult> allStory(String token) async {
    _dio.interceptors.add(PrettyDioLogger());
    _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
    try {
      Response response = await _dio.get(
          '$baseUrl/stories?page=1&limit=10&location=0',
          options: Options(headers: {"Authorization": "Bearer $token"}));
      return ListStoryResult.fromJson(response.data);
    } on DioException catch (_) {
      rethrow;
    }
  }

  Future<DetailStoryResult> detailStory(String id) async {
    _dio.interceptors.add(PrettyDioLogger());
    _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
    try {
      Response response = await _dio.get(
        '$baseUrl/stories/$id',
      );
      return DetailStoryResult.fromJson(response.data);
    } on DioException catch (_) {
      rethrow;
    }
  }

  Future<LoginResult> login(String email, String password) async {
    _dio.interceptors.add(PrettyDioLogger());
    _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
    try {
      Response response = await _dio.post(
        '$baseUrl/login',
        data: {'email': email, 'password': password},
      );
      return LoginResult.fromJson(response.data);
    } on DioException catch (_) {
      rethrow;
    }
  }

  Future<RegisterResult> register(
      String name, String email, String password) async {
    _dio.interceptors.add(PrettyDioLogger());
    _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
    try {
      Response response = await _dio.post(
        '$baseUrl/register',
        data: {'name': name, 'email': email, 'password': password},
      );
      return RegisterResult.fromJson(response.data);
    } on DioException catch (_) {
      rethrow;
    }
  }

  Future<AddStoryResult> addStory(String query) async {
    _dio.interceptors.add(PrettyDioLogger());
    _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
    try {
      Response response = await _dio.post('$baseUrl/stories');
      return AddStoryResult.fromJson(response.data);
    } on DioException catch (_) {
      rethrow;
    }
  }
}
