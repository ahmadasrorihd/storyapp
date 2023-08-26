import 'dart:convert';

ListStoryResult listStoryResultFromJson(String str) =>
    ListStoryResult.fromJson(json.decode(str));

String listStoryResultToJson(ListStoryResult data) =>
    json.encode(data.toJson());

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
      ListStoryResult(
        error: json["error"],
        message: json["message"],
        listStory: List<ListStory>.from(
            json["listStory"].map((x) => ListStory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "listStory": List<dynamic>.from(listStory.map((x) => x.toJson())),
      };
}

class ListStory {
  String id;
  String name;
  String description;
  String photoUrl;
  DateTime createdAt;
  dynamic lat;
  dynamic lon;

  ListStory({
    required this.id,
    required this.name,
    required this.description,
    required this.photoUrl,
    required this.createdAt,
    required this.lat,
    required this.lon,
  });

  factory ListStory.fromJson(Map<String, dynamic> json) => ListStory(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        photoUrl: json["photoUrl"],
        createdAt: DateTime.parse(json["createdAt"]),
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
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
