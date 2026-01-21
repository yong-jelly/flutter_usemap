// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'demo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DemoModel _$DemoModelFromJson(Map<String, dynamic> json) => DemoModel(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$DemoModelToJson(DemoModel instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'created_at': instance.createdAt.toIso8601String(),
};
