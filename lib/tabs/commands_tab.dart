import 'dart:math';

import 'package:discord_bot_creator/models/bot_data.dart';
import 'package:discord_bot_creator/components/command_editor.dart';
import 'package:discord_bot_creator/components/scrollable_list.dart';
import 'package:flutter/material.dart';

class CommandsTab extends StatefulWidget {
  const CommandsTab({Key? key}) : super(key: key);

  @override
  _CommandsTabState createState() => _CommandsTabState();
}

class _CommandsTabState extends State<CommandsTab> {
  final random = Random();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AspectRatio(
              aspectRatio: 4 / 1,
              child: ScrollableListButtons(
                list: BotData.commands.keys,
                callback: (index) {
                  final command = BotData.commands.values.elementAt(index);

                  CommandEditor.show(
                    context,
                    command: command,
                  ).then((_) {
                    setState(() {});
                  });
                },
              ),
            ),
            ElevatedButton(
              onPressed: () => CommandEditor.show(context).then(
                (_) => setState(() {}),
              ),
              child: Icon(Icons.add),
            )
          ],
        ),
      ),
    );
  }
}
