import 'package:json_annotation/json_annotation.dart';
import 'package:story_app/models/login.dart';

part 'login_result.g.dart';

@JsonSerializable()
class LoginResult {
  bool error;
  String message;

  @JsonKey(fromJson: _loginFromJson, toJson: _loginToJson)
  Login loginResult;

  LoginResult({
    required this.error,
    required this.message,
    required this.loginResult,
  });

  factory LoginResult.fromJson(Map<String, dynamic> json) =>
      _$LoginResultFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResultToJson(this);

  static Login _loginFromJson(Map<String, dynamic> json) {
    return Login.fromJson(json);
  }

  static Map<String, dynamic> _loginToJson(Login login) {
    return login.toJson();
  }
}
