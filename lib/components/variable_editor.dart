import 'dart:io';

import 'package:discord_bot_creator/components/confirm_dialog.dart';
import 'package:discord_bot_creator/components/dialogs.dart';
import 'package:discord_bot_creator/models/command.dart';
import 'package:discord_bot_creator/models/variables.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class VariableEditor extends StatefulWidget {
  final Command command;
  final Variable variable;

  const VariableEditor(
      {required this.variable, required this.command, Key? key})
      : super(key: key);

  static Future<bool?> show(BuildContext context,
      {required Command command, Variable? variable}) async {
    if (variable == null) {
      variable = Variable(
        name: 'var_${command.variables.length + 1}',
        type: TextVar(text: ''),
      );
      command.addVariable(variable);
    }
    return showDialog<bool>(
      context: context,
      builder: (context) => VariableEditor(
        variable: variable!,
        command: command,
      ),
    );
  }

  @override
  _VariableEditorState createState() => _VariableEditorState();
}

class _VariableEditorState extends State<VariableEditor> {
  late final TextVarEditor _textVarEditor;
  late final FileVarEditor _fileVarEditor;
  late final FunctionVarEditor _functionVarEditor;

  late final String _originalName;
  late String _variableType;

  @override
  void initState() {
    _variableType = widget.variable.type.type;
    _originalName = widget.variable.name;

    final text = widget.variable.type is TextVar
        ? (widget.variable.type as TextVar).text
        : '';

    _textVarEditor = TextVarEditor(text: text);

    final path = widget.variable.type is FileVar
        ? (widget.variable.type as FileVar).path
        : null;
    _fileVarEditor = FileVarEditor(path: path);

    final action = widget.variable.type is FunctionVar
        ? (widget.variable.type as FunctionVar).action
        : 'default';
    _functionVarEditor = FunctionVarEditor(action: action);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.subtitle1;
    return CustomDialog(
      title: 'Variable Editor',
      aspectRatio: 7 / 13,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Variable type :', style: textStyle),
              DropdownButton<String>(
                value: _variableType,
                icon: const Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? newValue) {
                  setState(() => _variableType = newValue!);
                },
                items: Variable.types
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: textStyle),
                  );
                }).toList(),
              ),
            ],
          ),
          if (_variableType == 'text') _textVarEditor,
          if (_variableType == 'file') _fileVarEditor,
          if (_variableType == 'function') _functionVarEditor,
          Stack(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () {
                    ConfirmDialog.show(context, value: widget.variable.name,
                        onConfirm: () {
                      widget.command.removeVariable(widget.variable);
                      Navigator.of(context).pop();
                    });
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
                    switch (_variableType) {
                      case 'text':
                        {
                          final newVar = TextVar(text: _textVarEditor.text);
                          widget.variable.type = newVar;
                          break;
                        }
                      case 'file':
                        {
                          if (_fileVarEditor.path == null) return;

                          final newVar = FileVar(path: _fileVarEditor.path!);

                          widget.variable.type = newVar;
                          break;
                        }
                      case 'function':
                        {
                          final newVar = FunctionVar();

                          widget.variable.type = newVar;

                          break;
                        }
                    }

                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.save),
                  label: Text('save'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TextVarEditor extends StatelessWidget {
  final TextEditingController _controller;
  String get text => _controller.text;
  TextVarEditor({required String text, Key? key})
      : _controller = TextEditingController(text: text),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: _controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderSide: BorderSide(width: 2)),
          ),
          keyboardType: TextInputType.multiline,
          minLines: 1,
          maxLines: 10,
        )
      ],
    );
  }
}

class FileVarEditor extends StatelessWidget {
  String? path;
  FileVarEditor({required this.path, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: () async {
            FilePickerResult? result = await FilePicker.platform.pickFiles();

            path = result?.files.single.path!;
          },
          icon: Icon(Icons.file_upload),
          label: Text('Select file'),
        )
      ],
    );
  }
}

class FunctionVarEditor extends StatefulWidget {
  String action;
  FunctionVarEditor({required this.action, Key? key}) : super(key: key);

  @override
  State<FunctionVarEditor> createState() => _FunctionVarEditorState();
}

class _FunctionVarEditorState extends State<FunctionVarEditor> {
  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.subtitle1;

    return Column(
      children: [
        DropdownButton<String>(
          value: widget.action,
          icon: const Icon(Icons.arrow_downward),
          iconSize: 24,
          elevation: 16,
          style: const TextStyle(color: Colors.deepPurple),
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          onChanged: (String? newValue) {
            setState(() => widget.action = newValue!);
          },
          items: FunctionVar.actions.keys
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: textStyle),
            );
          }).toList(),
        ),
      ],
    );
  }
}
