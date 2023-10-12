import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story_app/models/add_story.dart';
import 'package:story_app/models/detail_story.dart';
import 'package:story_app/models/list_story.dart';
import 'package:story_app/models/login.dart';
import 'package:story_app/models/register.dart';

import '../utils/constant.dart';

class ApiClient {
  final Dio _dio = Dio();

  ApiClient() {
    _dio.interceptors.add(
      AwesomeDioInterceptor(
        logRequestTimeout: true,
        logRequestHeaders: true,
        logResponseHeaders: true,
        logger: debugPrint,
      ),
    );
  }

  Future<ListStoryResult> allStory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString(keyToken);
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString(keyToken);
    try {
      Response response = await _dio.get('$baseUrl/stories/$id',
          options: Options(headers: {"Authorization": "Bearer $token"}));
      return DetailStoryResult.fromJson(response.data);
    } on DioException catch (_) {
      rethrow;
    }
  }

  Future<dynamic> login(String email, String password) async {
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

  Future<AddStoryResult> addStory(XFile file, String description) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString(keyToken);
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      "photo": await MultipartFile.fromFile(file.path, filename: fileName),
      "description": description,
    });
    try {
      Response response = await _dio.post('$baseUrl/stories',
          data: formData,
          options: Options(headers: {
            "Content-Type": "multipart/form-data",
            "Authorization": "Bearer $token"
          }));
      return AddStoryResult.fromJson(response.data);
    } on DioException catch (_) {
      rethrow;
    }
  }
}
