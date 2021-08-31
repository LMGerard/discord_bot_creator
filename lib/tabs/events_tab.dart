import 'package:discord_bot_creator/components/event_editor.dart';
import 'package:discord_bot_creator/models/bot_data.dart' show BotData;
import 'package:discord_bot_creator/models/mirror.dart';
import 'package:flutter/material.dart';

class EventsTab extends StatefulWidget {
  const EventsTab({Key? key}) : super(key: key);

  @override
  _EventsTabState createState() => _EventsTabState();
}

class _EventsTabState extends State<EventsTab> {
  Type? _selectedEvent;
  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.subtitle1;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          for (var event in BotData.eventListeners) ...[
            AspectRatio(
              aspectRatio: 4 / 1,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(event.runtimeType.toString(), style: textStyle),
                    ElevatedButton.icon(
                      onPressed: () {
                        EventEditor.show(context, event: event);
                      },
                      icon: Icon(Icons.edit),
                      label: Text('edit'),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 10)
          ],
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton<Type>(
                value: _selectedEvent,
                icon: const Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (newValue) {
                  setState(() => _selectedEvent = newValue!);
                },
                items: Mirror.events.keys.map<DropdownMenuItem<Type>>((value) {
                  return DropdownMenuItem<Type>(
                    value: value,
                    child: Text(value.toString(), style: textStyle),
                  );
                }).toList(),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  if (_selectedEvent != null)
                    setState(() {
                      final listener = EventListener.ofType(_selectedEvent!);
                      if (listener == null) return;
                      print(listener);
                      BotData.eventListeners.add(listener);
                      _selectedEvent = null;
                    });
                },
                icon: Icon(Icons.add),
                label: Text('add listener'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
