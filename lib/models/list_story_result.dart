import 'package:json_annotation/json_annotation.dart';
import 'package:story_app/models/list_story.dart';

part 'list_story_result.g.dart';

@JsonSerializable()
class ListStoryResult {
  bool error;
  String message;
  List<ListStory> listStory;

  ListStoryResult({
    required this.error,
    required this.message,
    required this.listStory,
  });

  factory ListStoryResult.fromJson(Map<String, dynamic> json) =>
      _$ListStoryResultFromJson(json);

  Map<String, dynamic> toJson() => _$ListStoryResultToJson(this);
}
