import 'dart:async';
import 'dart:developer';
import 'package:discord_bot_creator/models/wrapped_event.dart';
import 'package:http/http.dart' as http;
import 'package:discord_bot_creator/models/bot_data.dart';
import 'package:nyxx/nyxx.dart';

class DiscordBot {
  static Nyxx? bot;
  static final _streamSubscriptions = <StreamSubscription>[];
  final List commands = [];
  DiscordBot();

  static void stop() {
    _streamSubscriptions.forEach((sub) => sub.cancel());
    _streamSubscriptions.clear();
    bot = null;
  }

  static Future<bool> tryToken() async {
    final response = await http.get(
      Uri.parse('https://discord.com/api/v7/users/@me'),
      headers: {
        'Authorization': 'Bot ${BotData.TOKEN}',
      },
    );

    return 200 <= response.statusCode && response.statusCode < 300;
  }

  static Future run() async {
    final isTokenValid = await tryToken();

    if (isTokenValid == false) return;
    log('Running bot');
    bot = Nyxx(BotData.TOKEN, GatewayIntents.allUnprivileged);

    final _ss = bot!.onMessageReceived.listen(
      (event) {
        final command = BotData.commands[event.message.content];

        if (command != null && command.output != null) {
          final message = command.output;

          if (message != null)
            event.message.channel.getFromCache()!.sendMessage(message);
        }
      },
    );

    for (final listener in BotData.eventListeners) {
      listener.subscribe();
    }

    _streamSubscriptions.add(_ss);
  }
}
