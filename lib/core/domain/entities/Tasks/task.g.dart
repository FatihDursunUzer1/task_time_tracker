// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
      icon: json['icon'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      tags: (json['tags'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$TaskTagsEnumMap, e))
          .toList(),
      id: json['id'] as String,
      duration: json['duration'] == null
          ? null
          : Duration(microseconds: json['duration'] as int),
      createdAt: DateTime.parse(json['createdAt'] as String),
      isCompleted: json['isCompleted'] as bool,
    );

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'icon': instance.icon,
      'title': instance.title,
      'description': instance.description,
      'tags': instance.tags?.map((e) => _$TaskTagsEnumMap[e]!).toList(),
      'duration': instance.duration?.inMicroseconds,
      'isCompleted': instance.isCompleted,
      'createdAt': instance.createdAt.toIso8601String(),
      'id': instance.id,
    };

const _$TaskTagsEnumMap = {
  TaskTags.work: 'work',
  TaskTags.home: 'home',
  TaskTags.personal: 'personal',
  TaskTags.shopping: 'shopping',
  TaskTags.other: 'other',
};
