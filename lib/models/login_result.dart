import 'package:json_annotation/json_annotation.dart';
import 'package:story_app/screens/login.dart';

part 'login_result.g.dart';

@JsonSerializable()
class LoginResult {
  bool error;
  String message;
  Login login;

  LoginResult({
    required this.error,
    required this.message,
    required this.login,
  });

  factory LoginResult.fromJson(Map<String, dynamic> json) =>
      _$LoginResultFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResultToJson(this);
}
