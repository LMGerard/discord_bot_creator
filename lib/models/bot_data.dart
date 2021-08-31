import 'dart:convert';
import 'package:discord_bot_creator/models/command.dart';
import 'package:discord_bot_creator/models/mirror.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:nyxx/nyxx.dart';
part 'bot_data.g.dart';

final commandsStorage = GetStorage('COMMANDS');
final settingsStorage = GetStorage('SETTINGS');

class BotData {
  static String get TOKEN => settingsStorage.read('TOKEN') ?? '';
  static set TOKEN(String value) => settingsStorage.write('TOKEN', value);

  static late MyEmbed embed;
  static updateEmbed() {
    settingsStorage.write('embed', jsonEncode(embed.toJson()));
  }

  static bool get EMBED_ENABLED =>
      settingsStorage.read('EMBED_ENABLED') ?? false;
  static set EMBED_ENABLED(bool value) =>
      settingsStorage.write('EMBED_ENABLED', value);

  static final Map<String, dynamic> settings = {};

  static final Map<String, Command> commands = {};

  static final List<EventListener> eventListeners = [];

  static Future initialize() async {
    await GetStorage.init('COMMANDS');
    await GetStorage.init('SETTINGS');
    //commandsStorage.erase();
    for (String commandName in commandsStorage.getKeys()) {
      final jsonCommand = jsonDecode(commandsStorage.read(commandName));

      commands[commandName] = Command.fromJson(jsonCommand);
    }

    final embedJson = settingsStorage.read('embed');
    embed = embedJson == null
        ? MyEmbed()
        : MyEmbed.fromJson(
            jsonDecode(embedJson),
          );
  }

  static void addCommand(Command command) {
    commands[command.name] = command;

    updateCommand(command);
  }

  static updateCommand(Command command) {
    commandsStorage.write(command.name, jsonEncode(command.toJson()));
  }

  static void removeCommand(Command command) {
    commands.remove(command.name);
    commandsStorage.remove(command.name);
  }
}

@JsonSerializable()
class MyEmbed {
  String? _title;
  set title(String? value) => _title = value;
  String? get title {
    if (_title == null) return null;
    var value = _title;

    if (titleStyleFlag & 0x1 == 0x1) value = "*$value*";
    if (titleStyleFlag & 0x2 == 0x2) value = "__${value}__";
    if (titleStyleFlag & 0x4 == 0x4) value = "**$value**";

    return value;
  }

  String? get rawTitle => _title;

  int titleStyleFlag;

  int _colorIndex;
  int get colorIndex => _colorIndex;
  set colorIndex(int value) {
    _colorIndex = value % Colors.primaries.length;
  }

  DiscordColor get color {
    final _color = Colors.primaries[colorIndex];

    return DiscordColor.fromRgb(_color.red, _color.green, _color.blue);
  }

  MyEmbed({String? title, this.titleStyleFlag = 0x0, int colorIndex = 0})
      : _title = title,
        _colorIndex = colorIndex;

  factory MyEmbed.fromJson(Map<String, dynamic> json) =>
      _$MyEmbedFromJson(json);

  Map<String, dynamic> toJson() => _$MyEmbedToJson(this);

  EmbedBuilder genWith({String? description, String? title}) {
    return EmbedBuilder()
      ..title = title ?? this.title
      ..description = description
      ..color = color;
  }
}
