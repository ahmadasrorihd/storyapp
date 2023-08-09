import 'dart:convert';

LoginResult loginResultFromJson(String str) =>
    LoginResult.fromJson(json.decode(str));

String loginResultToJson(LoginResult data) => json.encode(data.toJson());

class LoginResult {
  bool error;
  String message;
  LoginResultClass loginResult;

  LoginResult({
    required this.error,
    required this.message,
    required this.loginResult,
  });

  factory LoginResult.fromJson(Map<String, dynamic> json) => LoginResult(
        error: json["error"],
        message: json["message"],
        loginResult: LoginResultClass.fromJson(json["loginResult"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "loginResult": loginResult.toJson(),
      };
}

class LoginResultClass {
  String userId;
  String name;
  String token;

  LoginResultClass({
    required this.userId,
    required this.name,
    required this.token,
  });

  factory LoginResultClass.fromJson(Map<String, dynamic> json) =>
      LoginResultClass(
        userId: json["userId"],
        name: json["name"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "name": name,
        "token": token,
      };
}
