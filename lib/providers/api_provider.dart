import 'package:flutter/cupertino.dart';
import 'package:story_app/models/login.dart';
import 'package:story_app/models/register.dart';

import '../core/api_client.dart';

class DataProvider with ChangeNotifier {
  final ApiClient apiClient;
  DataProvider({required this.apiClient});

  late LoginResult _loginResult;
  late RegisterResult _registerResult;

  bool _loading = false;
  final ApiClient _apiClient = ApiClient();
  String _errorMessage = '';

  LoginResult get loginResult => _loginResult;
  RegisterResult get registerResult => _registerResult;

  bool get loading => _loading;
  String get errorMessage => _errorMessage;

  Future login() async {
    _loading = true;
    try {
      _loginResult = await _apiClient.login();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future register() async {
    _loading = true;
    try {
      _registerResult = await _apiClient.register();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
