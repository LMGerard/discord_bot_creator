// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'command.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Command _$CommandFromJson(Map<String, dynamic> json) => Command(
      name: json['name'] as String,
      textOutput: json['textOutput'] as String?,
      variables: (json['variables'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, Variable.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$CommandToJson(Command instance) => <String, dynamic>{
      'name': instance.name,
      'textOutput': instance.textOutput,
      'variables': instance.variables,
    };
