// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mirror.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventListener<T> _$EventListenerFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    EventListener<T>(
      (json['actions'] as List<dynamic>)
          .map((e) => DiscordAction.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EventListenerToJson<T>(
  EventListener<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'actions': instance.actions,
    };
