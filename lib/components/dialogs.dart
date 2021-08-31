import 'package:flutter/material.dart';

class CustomDialog extends StatefulWidget {
  final String title;
  final double aspectRatio;
  final Widget? body;
  const CustomDialog(
      {required this.title, this.body, this.aspectRatio = 1.0, Key? key})
      : super(key: key);

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SingleChildScrollView(
        child: AspectRatio(
          aspectRatio: widget.aspectRatio,
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      color: Theme.of(context).accentColor,
                      child: Center(
                        child: Text(
                          widget.title,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: Icon(Icons.cancel, color: Colors.white, size: 30),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: widget.body,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
