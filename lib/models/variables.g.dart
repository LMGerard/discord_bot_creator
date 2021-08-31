// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'variables.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Variable _$VariableFromJson(Map<String, dynamic> json) => Variable(
      name: json['name'] as String,
      type: VariableType.fromJson(json['type'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VariableToJson(Variable instance) => <String, dynamic>{
      'name': instance.name,
      'type': instance.type,
    };

VariableType _$VariableTypeFromJson(Map<String, dynamic> json) => VariableType(
      type: json['type'] as String,
    );

Map<String, dynamic> _$VariableTypeToJson(VariableType instance) =>
    <String, dynamic>{
      'type': instance.type,
    };

TextVar _$TextVarFromJson(Map<String, dynamic> json) => TextVar(
      text: json['text'] as String,
    )..type = json['type'] as String;

Map<String, dynamic> _$TextVarToJson(TextVar instance) => <String, dynamic>{
      'type': instance.type,
      'text': instance.text,
    };

FileVar _$FileVarFromJson(Map<String, dynamic> json) => FileVar(
      path: json['path'] as String,
    )..type = json['type'] as String;

Map<String, dynamic> _$FileVarToJson(FileVar instance) => <String, dynamic>{
      'type': instance.type,
      'path': instance.path,
    };

FunctionVar _$FunctionVarFromJson(Map<String, dynamic> json) => FunctionVar(
      action: json['action'] as String? ?? 'default',
    )..type = json['type'] as String;

Map<String, dynamic> _$FunctionVarToJson(FunctionVar instance) =>
    <String, dynamic>{
      'type': instance.type,
      'action': instance.action,
    };
