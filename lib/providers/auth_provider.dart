import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

String LOGIN_KEY = "5FD6G46SDF4GD64F1VG9SD68";

class AuthProvider with ChangeNotifier {
  late final SharedPreferences sharedPreferences;
  bool _loginState = false;
  bool _initialized = false;
  final StreamController<bool> _onAuthStateChange =
      StreamController.broadcast();

  AuthProvider(this.sharedPreferences);

  bool get loginState => _loginState;
  bool get initialized => _initialized;
  Stream<bool> get onAuthStateChange => _onAuthStateChange.stream;

  set loginState(bool state) {
    sharedPreferences.setBool(LOGIN_KEY, state);
    _loginState = state;
    notifyListeners();
  }

  set initialized(bool value) {
    _initialized = value;
    notifyListeners();
  }

  Future<void> onAppStart() async {
    _loginState = sharedPreferences.getBool(LOGIN_KEY) ?? false;
    _initialized = true;
    notifyListeners();
  }

  Future<bool> login() async {
    _onAuthStateChange.add(true);
    return true;
  }

  void logOut() {
    _onAuthStateChange.add(false);
  }
}
