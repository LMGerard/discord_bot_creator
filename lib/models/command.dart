
import 'package:discord_bot_creator/models/bot_data.dart';
import 'package:discord_bot_creator/models/variables.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:nyxx/nyxx.dart';

part 'command.g.dart';

@JsonSerializable()
class Command {
  String name;
  String? _textOutput;
  String? get textOutput {
    if (_textOutput == null) {
      return null;
    } else {
      var re = RegExp(r'[$][^\s]+');

      final vars = re
          .allMatches(_textOutput!)
          .map((e) => _textOutput!.substring(e.start, e.end))
          .toSet();

      return vars.fold<String>(
        _textOutput!,
        (value, element) {
          final mv = variables[element.substring(1)];

          if (mv != null && mv.type is TextVar) {
            return value.replaceAll(element, (mv.type as TextVar).text);
          } else {
            return value;
          }
        },
      );
    }
  }

  MessageBuilder? get output {
    final output = textOutput;
    if (textOutput == null) return null;

    final builder = MessageBuilder();
    if (BotData.EMBED_ENABLED) {
      builder.embeds.add(BotData.embed.genWith(description: output));
    } else {
      builder.content = textOutput!;
    }
    for (final _var in variables.values) {
      if (_var.type is FileVar) {
        builder.addPathAttachment((_var.type as FileVar).path);
      }
    }

    return builder;
  }

  set textOutput(String? value) => _textOutput = value;

  Map<String, Variable> variables;

  Command(
      {required this.name,
      required String? textOutput,
      required this.variables})
      : _textOutput = textOutput;

  factory Command.fromJson(Map<String, dynamic> json) =>
      _$CommandFromJson(json);

  Command.empty()
      : name = '',
        _textOutput = '',
        variables = {};

  addVariable(Variable variable) {
    variables[variable.name] = variable;
    BotData.updateCommand(this);
  }

  removeVariable(Variable variable) {
    variables.remove(variable.name);
    BotData.updateCommand(this);
  }

  Map<String, dynamic> toJson() => _$CommandToJson(this);
}