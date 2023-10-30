// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_story_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListStoryResult _$ListStoryResultFromJson(Map<String, dynamic> json) =>
    ListStoryResult(
      error: json['error'] as bool,
      message: json['message'] as String,
      listStory: (json['listStory'] as List<dynamic>)
          .map((e) => ListStory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListStoryResultToJson(ListStoryResult instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'listStory': instance.listStory,
    };
