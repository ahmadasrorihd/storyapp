// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_story.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailStoryResult _$DetailStoryResultFromJson(Map<String, dynamic> json) =>
    DetailStoryResult(
      error: json['error'] as bool,
      message: json['message'] as String,
      story: DetailStoryResult._storyFromJson(
          json['story'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DetailStoryResultToJson(DetailStoryResult instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'story': DetailStoryResult._storyToJson(instance.story),
    };

Story _$StoryFromJson(Map<String, dynamic> json) => Story(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      photoUrl: json['photoUrl'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      lat: (json['lat'] as num?)?.toDouble(),
      lon: (json['lon'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$StoryToJson(Story instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'photoUrl': instance.photoUrl,
      'createdAt': instance.createdAt.toIso8601String(),
      'lat': instance.lat,
      'lon': instance.lon,
    };
