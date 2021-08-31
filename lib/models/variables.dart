import 'package:discord_bot_creator/discord_bot.dart';
import 'package:json_annotation/json_annotation.dart';

part 'variables.g.dart';

@JsonSerializable()
class Variable {
  static List<String> types = ['text', 'file', 'function'];
  final String name;

  VariableType type;

  Variable({required this.name, required this.type});

  factory Variable.fromJson(Map<String, dynamic> json) =>
      _$VariableFromJson(json);

  Map<String, dynamic> toJson() => _$VariableToJson(this);
}

@JsonSerializable()
class VariableType {
  String type;
  VariableType({required this.type});

  factory VariableType.fromJson(Map<String, dynamic> json) {
    switch (json['type']) {
      case 'text':
        {
          return _$TextVarFromJson(json);
        }
      case 'file':
        {
          return _$FileVarFromJson(json);
        }
      case 'function':
        {
          return _$FunctionVarFromJson(json);
        }
      default:
        {
          return _$TextVarFromJson(json);
        }
    }
  }

  Map<String, dynamic> toJson() => _$VariableTypeToJson(this);
}

@JsonSerializable()
class TextVar extends VariableType {
  final String text;
  TextVar({required this.text}) : super(type: 'text');

  factory TextVar.fromJson(Map<String, dynamic> json) =>
      _$TextVarFromJson(json);

  Map<String, dynamic> toJson() => _$TextVarToJson(this);
}

@JsonSerializable()
class FileVar extends VariableType {
  final String path;
  FileVar({required this.path}) : super(type: 'file');

  factory FileVar.fromJson(Map<String, dynamic> json) =>
      _$FileVarFromJson(json);

  Map<String, dynamic> toJson() => _$FileVarToJson(this);
}

@JsonSerializable()
class FunctionVar extends VariableType {
  static final Map<String, String Function()> actions = {
    'default': () => 'Well hello, Mr. Rachel !',
    'inviteLink': () => DiscordBot.bot!.inviteLink,
    'version': () => DiscordBot.bot!.version,
  };
  final String action;
  FunctionVar({this.action = 'default'}) : super(type: 'function');

  factory FunctionVar.fromJson(Map<String, dynamic> json) =>
      _$FunctionVarFromJson(json);

  Map<String, dynamic> toJson() => _$FunctionVarToJson(this);
}
