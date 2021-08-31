import 'package:discord_bot_creator/components/dialogs.dart';
import 'package:discord_bot_creator/models/discord_action.dart';
import 'package:discord_bot_creator/models/mirror.dart';
import 'package:flutter/material.dart';
import 'package:nyxx/nyxx.dart';

class EventEditor extends StatefulWidget {
  EventListener event;
  EventEditor(this.event, {Key? key}) : super(key: key);

  static Future show(BuildContext context, {EventListener? event}) async {
    return showDialog(
      context: context,
      builder: (context) => EventEditor(event!),
    );
  }

  @override
  _EventEditorState createState() => _EventEditorState();
}

class _EventEditorState extends State<EventEditor> {
  String? _selectedAction;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final actions = DiscordAction.actions.keys.where((action) {
      print(action);
      print(DiscordAction.requiredTypes[action]);
      print(widget.event.mirror.attributes);
      return widget.event.mirror.attributes.keys
          .toSet()
          .containsAll(DiscordAction.requiredTypes[action]!);
    });
    print('Actions $actions');
    return CustomDialog(
      title: 'Event Editor',
      aspectRatio: 7 / 13,
      body: Column(
        children: [
          DropdownButton<String>(
            value: _selectedAction,
            icon: const Icon(Icons.arrow_downward),
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (newValue) {
              setState(() => _selectedAction = newValue!);
            },
            items: actions.map<DropdownMenuItem<String>>((value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value.toString()),
              );
            }).toList(),
          ),
          ElevatedButton(
            onPressed: () {
              final t = widget.event.mirror.search(type: IChannel);
              print(t);
            },
            child: Text('test'),
          ),
        ],
      ),
    );
  }
}
