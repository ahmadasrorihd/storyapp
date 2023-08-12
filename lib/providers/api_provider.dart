import 'package:flutter/cupertino.dart';
import 'package:story_app/models/list_story.dart';
import 'package:story_app/models/login.dart';
import 'package:story_app/models/register.dart';

import '../core/api_client.dart';

class ApiProvider with ChangeNotifier {
  final ApiClient apiClient;
  ApiProvider({required this.apiClient});

  late LoginResult _loginResult;
  late RegisterResult _registerResult;
  late ListStoryResult _listStoryResult;

  bool _loading = false;
  final ApiClient _apiClient = ApiClient();
  String _errorMessage = '';

  LoginResult get loginResult => _loginResult;
  RegisterResult get registerResult => _registerResult;
  ListStoryResult get listStoryResult => _listStoryResult;

  bool get loading => _loading;
  String get errorMessage => _errorMessage;

  Future login(String email, String password) async {
    _loading = true;
    try {
      _loginResult = await _apiClient.login(email, password);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future register(String name, String email, String password) async {
    _loading = true;
    try {
      _registerResult = await _apiClient.register(name, email, password);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future allStory(String token) async {
    _loading = true;
    try {
      _listStoryResult = await _apiClient.allStory(token);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
