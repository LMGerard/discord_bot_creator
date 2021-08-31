import 'package:discord_bot_creator/discord_bot.dart';
import 'package:discord_bot_creator/models/bot_data.dart';
import 'package:discord_bot_creator/tabs/commands_tab.dart';
import 'package:discord_bot_creator/tabs/events_tab.dart';
import 'package:discord_bot_creator/tabs/settings_tab.dart';
import 'package:flutter/material.dart';
import 'models/mirror.dart';
import 'package:nyxx/nyxx.dart';

void main() async {
  await BotData.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color(0xFF292841),
        accentColor: Color(0xFF404EED),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF404EED),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          primary: Color(0xFF404EED),
        )),
        textTheme: TextTheme(
          headline5: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          subtitle1: TextStyle(color: Colors.black),
        ),
        tabBarTheme: TabBarTheme(
          indicator: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.black, width: 3)),
          ),
        ),
        scaffoldBackgroundColor: Color(0xFF5865F2),
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: ImageIcon(
            AssetImage('assets/images/discord_logo.png'),
            size: 60,
          ),
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text('Commands'),
              ),
              Tab(
                child: Text('Events'),
              ),
              Tab(
                child: Text('Settings'),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CommandsTab(),
            EventsTab(),
            SettingsTab(),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: PlayButton(),
      ),
    );
  }
}

class PlayButton extends StatefulWidget {
  const PlayButton({Key? key}) : super(key: key);

  @override
  _PlayButtonState createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton>
    with SingleTickerProviderStateMixin {
  late final controller = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 500),
  );
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        if (DiscordBot.bot == null) {
          DiscordBot.run().then(
              (value) => {if (DiscordBot.bot != null) controller.forward()});
        } else {
          controller.reverse();
          DiscordBot.stop();
        }
      },
      child: AnimatedIcon(
        icon: AnimatedIcons.play_pause,
        progress: controller,
      ),
    );
  }
}
