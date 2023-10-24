import 'dart:convert';

DetailStoryResult detailStoryResultFromJson(String str) =>
    DetailStoryResult.fromJson(json.decode(str));

String detailStoryResultToJson(DetailStoryResult data) =>
    json.encode(data.toJson());

class DetailStoryResult {
  bool error;
  String message;
  Story story;

  DetailStoryResult({
    required this.error,
    required this.message,
    required this.story,
  });

  factory DetailStoryResult.fromJson(Map<String, dynamic> json) =>
      DetailStoryResult(
        error: json["error"],
        message: json["message"],
        story: Story.fromJson(json["story"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "story": story.toJson(),
      };
}

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

  factory Story.fromJson(Map<String, dynamic> json) => Story(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        photoUrl: json["photoUrl"],
        createdAt: DateTime.parse(json["createdAt"]),
        lat: json["lat"]?.toDouble() ?? 0.0,
        lon: json["lon"]?.toDouble() ?? 0.0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "photoUrl": photoUrl,
        "createdAt": createdAt.toIso8601String(),
        "lat": lat,
        "lon": lon,
      };
}
