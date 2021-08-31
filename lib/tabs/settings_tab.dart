import 'package:discord_bot_creator/models/bot_data.dart';
import 'package:flutter/material.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({Key? key}) : super(key: key);

  @override
  _SettingsTabState createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  bool _tokenEditing = false;
  bool _embedEditing = false;
  final _tokenController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          _tokenEditing = !_tokenEditing;
                        });
                      },
                      icon: BotData.TOKEN.isEmpty
                          ? Icon(Icons.edit, color: Colors.red, size: 25)
                          : Icon(Icons.check, color: Colors.green, size: 25),
                      label: Text('BOT TOKEN'),
                    ),
                  ),
                  if (_tokenEditing) ...[
                    SizedBox(width: 20),
                    Flexible(
                      child: Row(
                        children: [
                          Flexible(
                              child: TextField(
                            controller: _tokenController,
                          )),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _tokenEditing = false;
                                if (_tokenController.text.isNotEmpty)
                                  BotData.TOKEN = _tokenController.text;
                              });
                            },
                            child: Icon(Icons.check),
                          )
                        ],
                      ),
                    ),
                  ]
                ],
              ),
              Row(
                children: [
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          BotData.EMBED_ENABLED = !BotData.EMBED_ENABLED;
                          _embedEditing = false;
                        });
                      },
                      icon: BotData.EMBED_ENABLED
                          ? Icon(Icons.check, color: Colors.green, size: 25)
                          : Icon(Icons.cancel, color: Colors.red, size: 25),
                      label: Text('EMBED ENABLED'),
                    ),
                  ),
                  if (BotData.EMBED_ENABLED) ...[
                    SizedBox(width: 20),
                    ElevatedButton.icon(
                      onPressed: () => setState(() {
                        _embedEditing = !_embedEditing;
                      }),
                      icon: Icon(Icons.edit),
                      label: Text('EDIT'),
                    ),
                  ]
                ],
              ),
              if (_embedEditing)
                Center(
                  child: EmbedEditor(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class EmbedEditor extends StatefulWidget {
  const EmbedEditor({Key? key}) : super(key: key);

  @override
  _EmbedEditorState createState() => _EmbedEditorState();
}

class _EmbedEditorState extends State<EmbedEditor> {
  bool _italic = false;
  bool _underline = false;
  @override
  void initState() {
    _italic = BotData.embed.titleStyleFlag & 0x1 == 0x1;
    _underline = BotData.embed.titleStyleFlag & 0x2 == 0x2;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BotData.embed.titleStyleFlag = 0;
    if (_italic) BotData.embed.titleStyleFlag |= 0x1;
    if (_underline) BotData.embed.titleStyleFlag |= 0x2;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 300,
          child: AspectRatio(
            aspectRatio: 8 / 5,
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() {
                      BotData.embed.colorIndex++;
                      BotData.updateEmbed();
                    }),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.primaries[BotData.embed.colorIndex],
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          topLeft: Radius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 19,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF292841),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Expanded(
                              child: TextFormField(
                            initialValue: BotData.embed.rawTitle,
                            onFieldSubmitted: (d) {
                              BotData.embed.title = d;
                              BotData.updateEmbed();
                            },
                            style:
                                Theme.of(context).textTheme.headline5!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: _italic
                                          ? FontStyle.italic
                                          : FontStyle.normal,
                                      decoration: _underline
                                          ? TextDecoration.underline
                                          : TextDecoration.none,
                                    ),
                          )),
                          Expanded(child: Container()),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Column(
          children: [
            IconButton(
              onPressed: () => setState(() => _italic = !_italic),
              icon: Icon(
                Icons.format_italic,
                color: _italic ? Colors.white : Colors.black,
              ),
            ),
            IconButton(
              onPressed: () => setState(() => _underline = !_underline),
              icon: Icon(
                Icons.format_underline,
                color: _underline ? Colors.white : Colors.black,
              ),
            ),
          ],
        )
      ],
    );
  }
}
