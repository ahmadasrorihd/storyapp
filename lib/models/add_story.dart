import 'dart:convert';

AddStoryResult addStoryResultFromJson(String str) =>
    AddStoryResult.fromJson(json.decode(str));

String addStoryResultToJson(AddStoryResult data) => json.encode(data.toJson());

class AddStoryResult {
  bool error;
  String message;

  AddStoryResult({
    required this.error,
    required this.message,
  });

  factory AddStoryResult.fromJson(Map<String, dynamic> json) => AddStoryResult(
        error: json["error"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
      };
}
