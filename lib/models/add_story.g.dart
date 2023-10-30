// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_story.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddStoryResult _$AddStoryResultFromJson(Map<String, dynamic> json) =>
    AddStoryResult(
      error: json['error'] as bool,
      message: json['message'] as String,
    );

Map<String, dynamic> _$AddStoryResultToJson(AddStoryResult instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
    };
