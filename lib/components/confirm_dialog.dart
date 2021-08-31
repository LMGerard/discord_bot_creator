import 'package:discord_bot_creator/components/dialogs.dart';
import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  static Future show(BuildContext context,
      {required String value, required VoidCallback onConfirm}) async {
    return showDialog(
      context: context,
      builder: (context) => ConfirmDialog(value: value, onConfirm: onConfirm),
    );
  }

  final _formKey = GlobalKey<FormState>();

  final String value;
  final VoidCallback onConfirm;
  final _controller = TextEditingController();
  ConfirmDialog({required this.value, required this.onConfirm, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: 'Are you sure ?',
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.subtitle1,
              text: 'Type ',
              children: [
                TextSpan(
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(color: Colors.red),
                  text: value,
                ),
                TextSpan(text: ' to confirm.'),
              ],
            ),
          ),
          Form(
            key: _formKey,
            child: TextFormField(
              validator: (value) {
                return value == this.value ? null : 'try again...';
              },
              controller: _controller,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.of(context).pop();
                    onConfirm();
                  }
                },
                icon: Icon(Icons.save),
                label: Text('Confirm'),
              ),
              ElevatedButton.icon(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(Icons.cancel),
                label: Text('cancel'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
