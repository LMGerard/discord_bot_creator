import 'package:discord_bot_creator/components/confirm_dialog.dart';
import 'package:discord_bot_creator/components/dialogs.dart';
import 'package:discord_bot_creator/components/scrollable_list.dart';
import 'package:discord_bot_creator/components/variable_editor.dart';
import 'package:discord_bot_creator/models/command.dart';
import 'package:flutter/material.dart';
import 'package:discord_bot_creator/models/bot_data.dart';

class CommandEditor extends StatefulWidget {
  Command? command;
  CommandEditor({this.command, Key? key}) : super(key: key);

  static Future show(BuildContext context, {Command? command}) async {
    return showDialog(
      context: context,
      builder: (context) => CommandEditor(command: command),
    );
  }

  @override
  _CommandEditorState createState() => _CommandEditorState();
}

class _CommandEditorState extends State<CommandEditor> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: 'Command Editor',
      aspectRatio: 7 / 13,
      body: widget.command == null
          ? CommandCreator(
              onCommandCreated: (command) {
                setState(() {
                  this.widget.command = command;
                });
              },
            )
          : _PropertiesEditor(command: widget.command!),
    );
  }
}

class CommandCreator extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final Function(Command) onCommandCreated;

  CommandCreator({required this.onCommandCreated, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          'Chose your command name',
          style: Theme.of(context).textTheme.subtitle1,
        ),
        Form(
          key: _formKey,
          child: TextFormField(
            controller: _nameController,
            validator: (value) {
              if (value == null || value.isEmpty)
                return "The command can't be empty";
              if (BotData.commands.containsKey(value)) {
                return 'This command already exist';
              } else {
                return null;
              }
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final command = Command.empty();
                  command.name = _nameController.text;

                  BotData.addCommand(command);

                  onCommandCreated(command);
                }
              },
              icon: Icon(Icons.save),
              label: Text('save'),
            ),
            ElevatedButton.icon(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(Icons.cancel),
              label: Text('cancel'),
            ),
          ],
        )
      ],
    );
  }
}

class _PropertiesEditor extends StatefulWidget {
  final Command command;
  final String _originalName;
  final TextEditingController _command;
  final TextEditingController _answer;
  _PropertiesEditor({required this.command, Key? key})
      : _originalName = command.name,
        _command = TextEditingController(text: command.name),
        _answer = TextEditingController(text: command.textOutput),
        super(key: key);

  @override
  State<_PropertiesEditor> createState() => _PropertiesEditorState();
}

class _PropertiesEditorState extends State<_PropertiesEditor> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.subtitle1;

    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text('Command :', style: textStyle),
              Flexible(
                child: TextFormField(
                  controller: widget._command,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "The command can not be empty.";
                    }
                    if (value != widget._originalName &&
                        BotData.commands.containsKey(value)) {
                      return 'This command alreay exist';
                    }
                  },
                ),
              ),
            ],
          ),
          Column(
            children: [
              Text('Output :'),
              TextField(
                controller: widget._answer,
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 5,
              ),
            ],
          ),
          Column(
            children: [
              Text('Variables', style: textStyle),
              AspectRatio(
                aspectRatio: 4 / 1,
                child: ScrollableListButtons(
                  list: widget.command.variables.keys,
                  callback: (index) {
                    VariableEditor.show(
                      context,
                      variable:
                          widget.command.variables.values.elementAt(index),
                      command: widget.command,
                    ).then((value) => setState(() {}));
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  VariableEditor.show(context, command: widget.command).then(
                    (value) => setState(() {}),
                  );
                },
                child: Icon(Icons.add),
              )
            ],
          ),
          Stack(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () {
                    ConfirmDialog.show(
                      context,
                      value: widget.command.name,
                      onConfirm: () {
                        BotData.removeCommand(widget.command);

                        Navigator.of(context).pop();
                      },
                    );
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 30,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton.icon(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      widget.command.name = widget._command.text;
                      widget.command.textOutput = widget._answer.text;

                      BotData.updateCommand(widget.command);

                      Navigator.of(context).pop();
                    }
                  },
                  icon: Icon(Icons.save),
                  label: Text('save'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
