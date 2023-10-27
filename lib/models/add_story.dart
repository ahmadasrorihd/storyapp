import 'package:json_annotation/json_annotation.dart';

part 'add_story.g.dart';

@JsonSerializable()
class AddStoryResult {
  bool error;
  String message;

  AddStoryResult({
    required this.error,
    required this.message,
  });

  factory AddStoryResult.fromJson(Map<String, dynamic> json) =>
      _$AddStoryFromJson(json);

  Map<String, dynamic> toJson() => _$AddStoryToJson(this);
}
