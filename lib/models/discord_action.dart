import 'package:nyxx/nyxx.dart';
import 'package:json_annotation/json_annotation.dart';

part 'discord_action.g.dart';

@JsonSerializable()
class DiscordAction {
  static Map<String, Iterable<Type>> requiredTypes = {
    'SendMessage': [TextChannel],
  };
  static final Map<String, DiscordAction Function()> actions = {
    'SendMessage': () => SendMessage(),
  };

  DiscordAction();

  void execute(event) {}

  factory DiscordAction.fromJson(Map<String, dynamic> json) =>
      _$DiscordActionFromJson(json);

  Map<String, dynamic> toJson() => _$DiscordActionToJson(this);
}

class SendMessage extends DiscordAction {
  SendMessage() : super();
}


