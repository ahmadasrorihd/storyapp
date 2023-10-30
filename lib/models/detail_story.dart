import 'package:json_annotation/json_annotation.dart';

part 'detail_story.g.dart';

@JsonSerializable()
class DetailStoryResult {
  bool error;
  String message;

  @JsonKey(fromJson: _storyFromJson, toJson: _storyToJson)
  Story story;

  DetailStoryResult({
    required this.error,
    required this.message,
    required this.story,
  });

  factory DetailStoryResult.fromJson(Map<String, dynamic> json) =>
      _$DetailStoryResultFromJson(json);

  Map<String, dynamic> toJson() => _$DetailStoryResultToJson(this);

  static Story _storyFromJson(Map<String, dynamic> json) {
    return Story.fromJson(json);
  }

  static Map<String, dynamic> _storyToJson(Story story) {
    return story.toJson();
  }
}

@JsonSerializable()
class Story {
  String id;
  String name;
  String description;
  String photoUrl;
  DateTime createdAt;
  double? lat;
  double? lon;

  Story({
    required this.id,
    required this.name,
    required this.description,
    required this.photoUrl,
    required this.createdAt,
    required this.lat,
    required this.lon,
  });

  factory Story.fromJson(Map<String, dynamic> json) => _$StoryFromJson(json);

  Map<String, dynamic> toJson() => _$StoryToJson(this);
}
