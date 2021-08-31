import 'package:nyxx/nyxx.dart';

class WrappedEvent {
  Message? _message;
  Message? get message => _message;
  IEmoji? _emoji;
  IEmoji? get emoji => _emoji;
  IChannel? _channel;
  IChannel? get channel => _channel ?? message?.channel;

  WrappedEvent(unkwownEvent) {
    _message = tryFunc(() => unkwownEvent.message);
    _emoji = tryFunc(() => unkwownEvent.emoji);
  }

  dynamic tryFunc(dynamic Function() func) {
    try {
      return func();
    } on NoSuchMethodError catch (_) {}
  }
}
