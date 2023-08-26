import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import 'package:story_app/models/login.dart';

class UserPreferences {
  Future<bool> saveUser(LoginResultClass user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString("userId", user.userId);
    prefs.setString("name", user.name);
    prefs.setString("token", user.token);
    return prefs.commit();
  }

  Future<LoginResultClass> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String userId = prefs.getString("userId")!;
    String name = prefs.getString("name")!;
    String token = prefs.getString("token")!;

    return LoginResultClass(userId: userId, name: name, token: token);
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove("name");
    prefs.remove("email");
    prefs.remove("phone");
    prefs.remove("type");
    prefs.remove("token");
  }

  Future<String> getToken(args) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token")!;
    return token;
  }
}
