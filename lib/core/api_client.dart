import 'package:dio/dio.dart';
import 'package:story_app/models/add_story.dart';
import 'package:story_app/models/detail_story.dart';
import 'package:story_app/models/list_story.dart';
import 'package:story_app/models/login.dart';
import 'package:story_app/models/register.dart';

import '../utils/constant.dart';

class ApiClient {
  final Dio _dio = Dio();

  Future<ListStoryResult> allStory() async {
    try {
      Response response = await _dio.get('$baseUrl/stories');
      return ListStoryResult.fromJson(response.data);
    } on DioException catch (_) {
      rethrow;
    }
  }

  Future<DetailStoryResult> detailStory(String id) async {
    try {
      Response response = await _dio.get('$baseUrl/stories/$id');
      return DetailStoryResult.fromJson(response.data);
    } on DioException catch (_) {
      rethrow;
    }
  }

  Future<LoginResult> login() async {
    try {
      Response response = await _dio.post('$baseUrl/login');
      return LoginResult.fromJson(response.data);
    } on DioException catch (_) {
      rethrow;
    }
  }

  Future<RegisterResult> register() async {
    try {
      Response response = await _dio.post('$baseUrl/register');
      return RegisterResult.fromJson(response.data);
    } on DioException catch (_) {
      rethrow;
    }
  }

  Future<AddStoryResult> addStory(String query) async {
    try {
      Response response = await _dio.post('$baseUrl/stories');
      return AddStoryResult.fromJson(response.data);
    } on DioException catch (_) {
      rethrow;
    }
  }
}
