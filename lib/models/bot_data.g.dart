// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bot_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyEmbed _$MyEmbedFromJson(Map<String, dynamic> json) => MyEmbed(
      title: json['title'] as String?,
      titleStyleFlag: json['titleStyleFlag'] as int? ?? 0x0,
      colorIndex: json['colorIndex'] as int? ?? 0,
    );

Map<String, dynamic> _$MyEmbedToJson(MyEmbed instance) => <String, dynamic>{
      'title': instance.title,
      'titleStyleFlag': instance.titleStyleFlag,
      'colorIndex': instance.colorIndex,
    };
