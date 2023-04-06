// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
      title: json['title'] as String,
      description: json['description'] as String,
      tags: (json['tags'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$TaskTagsEnumMap, e))
          .toList(),
      userId: json['userId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    )..id = json['id'] as String;

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'tags': instance.tags?.map((e) => _$TaskTagsEnumMap[e]!).toList(),
      'userId': instance.userId,
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
