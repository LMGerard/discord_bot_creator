import 'package:discord_bot_creator/models/discord_action.dart';
import 'package:http/http.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:nyxx/nyxx.dart';
import 'package:discord_bot_creator/discord_bot.dart';
part 'mirror.g.dart';

Type typeOf<T>() => T;
bool isSubtype<S, T>() => <S>[] is List<T>;

@JsonSerializable(genericArgumentFactories: true)
class EventListener<T> {
  final List<DiscordAction> actions;
  final Mirror<T> mirror;

  String get typeString {
    final type = this.runtimeType.toString();
    return type.substring(type.indexOf('<') + 1, type.length - 1);
  }

  Type get generic => T;

  EventListener(this.actions) : mirror = Mirror<T>();
  void subscribe() {
    mirror.stream.listen((event) {
      for (final action in actions) {
        action.execute(event);
      }
    });
  }

  static EventListener? ofType(Type type) {
    switch (type) {
      case ChannelCreateEvent:
        {
          return EventListener<ChannelCreateEvent>([]);
        }
      case ChannelDeleteEvent:
        {
          return EventListener<ChannelDeleteEvent>([]);
        }
      case ChannelPinsUpdateEvent:
        {
          return EventListener<ChannelPinsUpdateEvent>([]);
        }
      case ChannelUpdateEvent:
        {
          return EventListener<ChannelUpdateEvent>([]);
        }
      case StageInstanceEvent:
        {
          return EventListener<StageInstanceEvent>([]);
        }
      case DisconnectEvent:
        {
          return EventListener<DisconnectEvent>([]);
        }
      case GuildCreateEvent:
        {
          return EventListener<GuildCreateEvent>([]);
        }
      case GuildUpdateEvent:
        {
          return EventListener<GuildUpdateEvent>([]);
        }
      case GuildDeleteEvent:
        {
          return EventListener<GuildDeleteEvent>([]);
        }
      case GuildMemberRemoveEvent:
        {
          return EventListener<GuildMemberRemoveEvent>([]);
        }
      case GuildMemberUpdateEvent:
        {
          return EventListener<GuildMemberUpdateEvent>([]);
        }
      case GuildMemberAddEvent:
        {
          return EventListener<GuildMemberAddEvent>([]);
        }
      case GuildBanAddEvent:
        {
          return EventListener<GuildBanAddEvent>([]);
        }
      case GuildBanRemoveEvent:
        {
          return EventListener<GuildBanRemoveEvent>([]);
        }
      case GuildEmojisUpdateEvent:
        {
          return EventListener<GuildEmojisUpdateEvent>([]);
        }
      case RoleCreateEvent:
        {
          return EventListener<RoleCreateEvent>([]);
        }
      case RoleDeleteEvent:
        {
          return EventListener<RoleDeleteEvent>([]);
        }
      case RoleUpdateEvent:
        {
          return EventListener<RoleUpdateEvent>([]);
        }
      case HttpErrorEvent:
        {
          return EventListener<HttpErrorEvent>([]);
        }
      case HttpResponseEvent:
        {
          return EventListener<HttpResponseEvent>([]);
        }
      case InviteCreatedEvent:
        {
          return EventListener<InviteCreatedEvent>([]);
        }
      case InviteDeletedEvent:
        {
          return EventListener<InviteDeletedEvent>([]);
        }
      case MemberChunkEvent:
        {
          return EventListener<MemberChunkEvent>([]);
        }
      case MessageReceivedEvent:
        {
          return EventListener<MessageReceivedEvent>([]);
        }
      case MessageDeleteEvent:
        {
          return EventListener<MessageDeleteEvent>([]);
        }
      case MessageDeleteBulkEvent:
        {
          return EventListener<MessageDeleteBulkEvent>([]);
        }
      case MessageReactionEvent:
        {
          return EventListener<MessageReactionEvent>([]);
        }
      case MessageReactionAddedEvent:
        {
          return EventListener<MessageReactionAddedEvent>([]);
        }
      case MessageReactionRemovedEvent:
        {
          return EventListener<MessageReactionRemovedEvent>([]);
        }
      case MessageReactionsRemovedEvent:
        {
          return EventListener<MessageReactionsRemovedEvent>([]);
        }
      case MessageReactionRemoveEmojiEvent:
        {
          return EventListener<MessageReactionRemoveEmojiEvent>([]);
        }
      case MessageUpdateEvent:
        {
          return EventListener<MessageUpdateEvent>([]);
        }
      case PresenceUpdateEvent:
        {
          return EventListener<PresenceUpdateEvent>([]);
        }
      case RawEvent:
        {
          return EventListener<RawEvent>([]);
        }
      case ReadyEvent:
        {
          return EventListener<ReadyEvent>([]);
        }
      case ThreadCreateEvent:
        {
          return EventListener<ThreadCreateEvent>([]);
        }
      case ThreadDeletedEvent:
        {
          return EventListener<ThreadDeletedEvent>([]);
        }
      case ThreadMembersUpdateEvent:
        {
          return EventListener<ThreadMembersUpdateEvent>([]);
        }
      case TypingEvent:
        {
          return EventListener<TypingEvent>([]);
        }
      case UserUpdateEvent:
        {
          return EventListener<UserUpdateEvent>([]);
        }
      case VoiceServerUpdateEvent:
        {
          return EventListener<VoiceServerUpdateEvent>([]);
        }
      case VoiceStateUpdateEvent:
        {
          return EventListener<VoiceStateUpdateEvent>([]);
        }
    }
  }

  factory EventListener.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$EventListenerFromJson(json, fromJsonT);
  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$EventListenerToJson(this, toJsonT);
}

class Mirror<T> {
  const Mirror();
  Map<Type, String> get attributes => types[T]!;

  Map<Type, String> getAttributes(Type type) => types[type]!;

  Stream get stream => events[T]!();

  String? search({required Type type}) => searchInside(type: type, inside: T);

  String? searchInside({required Type type, required Type inside}) {
    final subTypes = [];

    for (final subType in getAttributes(inside).keys) {
      if (subType.toString().contains(type.toString())) {
        return getAttributes(inside)[subType];
      }
    }

    for(final subType in getAttributes(inside).keys){
      
    }
  }

  static final Map<Type, Stream Function()> events = {
    DisconnectEvent: () => DiscordBot.bot!.onDisconnect,
    ReadyEvent: () => DiscordBot.bot!.onReady,
    MessageReceivedEvent: () => DiscordBot.bot!.onSelfMention,
    ChannelPinsUpdateEvent: () => DiscordBot.bot!.onChannelPinsUpdate,
    GuildEmojisUpdateEvent: () => DiscordBot.bot!.onGuildEmojisUpdate,
    MessageUpdateEvent: () => DiscordBot.bot!.onMessageUpdate,
    MessageDeleteEvent: () => DiscordBot.bot!.onMessageDelete,
    ChannelCreateEvent: () => DiscordBot.bot!.onChannelCreate,
    ChannelUpdateEvent: () => DiscordBot.bot!.onChannelUpdate,
    ChannelDeleteEvent: () => DiscordBot.bot!.onChannelDelete,
    GuildBanAddEvent: () => DiscordBot.bot!.onGuildBanAdd,
    GuildBanRemoveEvent: () => DiscordBot.bot!.onGuildBanRemove,
    GuildCreateEvent: () => DiscordBot.bot!.onGuildCreate,
    GuildUpdateEvent: () => DiscordBot.bot!.onGuildUpdate,
    GuildDeleteEvent: () => DiscordBot.bot!.onGuildDelete,
    GuildMemberAddEvent: () => DiscordBot.bot!.onGuildMemberAdd,
    GuildMemberUpdateEvent: () => DiscordBot.bot!.onGuildMemberUpdate,
    GuildMemberRemoveEvent: () => DiscordBot.bot!.onGuildMemberRemove,
    PresenceUpdateEvent: () => DiscordBot.bot!.onPresenceUpdate,
    TypingEvent: () => DiscordBot.bot!.onTyping,
    RoleCreateEvent: () => DiscordBot.bot!.onRoleCreate,
    RoleUpdateEvent: () => DiscordBot.bot!.onRoleUpdate,
    RoleDeleteEvent: () => DiscordBot.bot!.onRoleDelete,
    MessageDeleteBulkEvent: () => DiscordBot.bot!.onMessageDeleteBulk,
    MessageReactionEvent: () => DiscordBot.bot!.onMessageReactionRemove,
    MessageReactionsRemovedEvent: () =>
        DiscordBot.bot!.onMessageReactionsRemoved,
    VoiceStateUpdateEvent: () => DiscordBot.bot!.onVoiceStateUpdate,
    VoiceServerUpdateEvent: () => DiscordBot.bot!.onVoiceServerUpdate,
    UserUpdateEvent: () => DiscordBot.bot!.onUserUpdate,
    InviteCreatedEvent: () => DiscordBot.bot!.onInviteCreated,
    InviteDeletedEvent: () => DiscordBot.bot!.onInviteDeleted,
    MessageReactionRemoveEmojiEvent: () =>
        DiscordBot.bot!.onMessageReactionRemoveEmoji,
    ThreadCreateEvent: () => DiscordBot.bot!.onThreadCreated,
    ThreadMembersUpdateEvent: () => DiscordBot.bot!.onThreadMembersUpdate,
    ThreadDeletedEvent: () => DiscordBot.bot!.onThreadDelete,
    StageInstanceEvent: () => DiscordBot.bot!.onStageInstanceDelete,
    GuildStickerUpdate: () => DiscordBot.bot!.onGuildStickersUpdate
  };

  static final Map<Type, Map<Type, String>> types = {
    ChannelCreateEvent: {IChannel: 'channel'},
    IChannel: {ChannelType: 'channelType', INyxx: 'client'},
    ChannelType: {ChannelType: 'unknown'},
    // INyxx: {
    //   typeOf<Stream<HttpResponseEvent>>(): 'onHttpResponse',
    //   typeOf<Stream<HttpErrorEvent>>(): 'onHttpError',
    //   typeOf<Stream<RatelimitEvent>>(): 'onRateLimited'
    // },
    ChannelDeleteEvent: {IChannel: 'channel'},
    ChannelPinsUpdateEvent: {
      typeOf<CacheableTextChannel<TextChannel>>(): 'channel',
      typeOf<Cacheable<Snowflake, Guild>>(): 'guild',
      DateTime: 'lastPingTimestamp'
    },
    DateTime: {int: 'monthsPerYear', bool: 'isUtc'},
    int: {},
    bool: {},
    ChannelUpdateEvent: {IChannel: 'updatedChannel'},
    StageInstanceEvent: {StageChannelInstance: 'stageChannelInstance'},
    StageChannelInstance: {
      typeOf<Cacheable<Snowflake, Guild>>(): 'guild',
      typeOf<Cacheable<Snowflake, StageVoiceGuildChannel>>(): 'channel',
      String: 'topic',
      StageChannelInstancePrivacyLevel: 'privacyLevel',
      bool: 'disoverableDisabled'
    },
    String: {},
    StageChannelInstancePrivacyLevel: {
      StageChannelInstancePrivacyLevel: 'guildOnly'
    },
    DisconnectEvent: {Shard: 'shard', DisconnectEventReason: 'reason'},
    // Shard: {
    //   int: 'id',
    //   ShardManager: 'manager',
    //   typeOf<Stream<Shard>>(): 'onDisconnect',
    //   typeOf<Stream<MemberChunkEvent>>(): 'onMemberChunk',
    //   typeOf<List<Snowflake>>(): 'guilds'
    // },
    // ShardManager: {
    //   typeOf<Stream<Shard>>(): 'onDisconnect',
    //   typeOf<Stream<MemberChunkEvent>>(): 'onMemberChunk',
    //   typeOf<Stream<RawEvent>>(): 'rawEvent',
    //   int: 'maxConcurrency'
    // },
    DisconnectEventReason: {DisconnectEventReason: 'invalidSession'},
    GuildCreateEvent: {Guild: 'guild'},
    Guild: {
      INyxx: 'client',
      String: 'preferredLocale',
      typeOf<Cacheable<Snowflake, TextGuildChannel>>(): 'embedChannel',
      typeOf<Iterable<GuildFeature>>(): 'features',
      typeOf<Cacheable<Snowflake, VoiceGuildChannel>>(): 'afkChannel',
      int: 'premiumSubscriptionCount',
      bool: 'available',
      typeOf<Cacheable<Snowflake, TextChannel>>(): 'rulesChannel',
      typeOf<Cacheable<Snowflake, User>>(): 'owner',
      typeOf<Cache<Snowflake, Member>>(): 'members',
      typeOf<Cache<Snowflake, Role>>(): 'roles',
      typeOf<Cache<Snowflake, IGuildEmoji>>(): 'emojis',
      PremiumTier: 'premiumTier',
      typeOf<CacheableTextChannel<TextChannel>>(): 'publicUpdatesChannel',
      Permissions: 'currentUserPermissions',
      typeOf<Cache<Snowflake, VoiceState>>(): 'voiceStates',
      typeOf<Iterable<StageChannelInstance>>(): 'stageInstances',
      GuildNsfwLevel: 'guildNsfwLevel',
      typeOf<Iterable<GuildSticker>>(): 'stickers'
    },
    PremiumTier: {PremiumTier: 'tier3'},
    Permissions: {int: 'raw', bool: 'usePrivateThreads'},
    GuildNsfwLevel: {GuildNsfwLevel: 'ageRestricted'},
    GuildUpdateEvent: {Guild: 'guild'},
    GuildDeleteEvent: {
      typeOf<Cacheable<Snowflake, Guild>>(): 'guild',
      bool: 'unavailable'
    },
    GuildMemberRemoveEvent: {
      typeOf<Cacheable<Snowflake, Guild>>(): 'guild',
      User: 'user'
    },
    User: {
      INyxx: 'client',
      String: 'bannerHash',
      int: 'discriminator',
      bool: 'system',
      ClientStatus: 'status',
      Activity: 'presence',
      UserFlags: 'userFlags',
      NitroType: 'nitroType',
      DiscordColor: 'accentColor'
    },
    ClientStatus: {UserStatus: 'phone'},
    UserStatus: {UserStatus: 'idle'},
    Activity: {
      String: 'state',
      ActivityType: 'type',
      DateTime: 'createdAt',
      ActivityTimestamps: 'timestamps',
      Snowflake: 'applicationId',
      ActivityEmoji: 'customStatusEmoji',
      ActivityParty: 'party',
      GameAssets: 'assets',
      GameSecrets: 'secrets',
      bool: 'instance',
      ActivityFlags: 'activityFlags',
      typeOf<Iterable<String>>(): 'buttons'
    },
    ActivityType: {ActivityType: 'competing'},
    ActivityTimestamps: {DateTime: 'end'},
    Snowflake: {int: 'snowflakeDateOffset'},
    ActivityEmoji: {Snowflake: 'id', bool: 'animated'},
    ActivityParty: {String: 'id', int: 'maxSize'},
    GameAssets: {String: 'smallText'},
    GameSecrets: {String: 'match'},
    ActivityFlags: {int: 'value'},
    UserFlags: {bool: 'certifiedModerator'},
    NitroType: {NitroType: 'nitro'},
    DiscordColor: {DiscordColor: 'sienna'},
    GuildMemberUpdateEvent: {
      typeOf<Cacheable<Snowflake, Member>>(): 'member',
      User: 'user',
      typeOf<Cacheable<Snowflake, Guild>>(): 'guild'
    },
    GuildMemberAddEvent: {
      Member: 'member',
      User: 'user',
      typeOf<Cacheable<Snowflake, Guild>>(): 'guild'
    },
    Member: {
      INyxx: 'client',
      typeOf<Cacheable<Snowflake, User>>(): 'user',
      String: 'avatarHash',
      DateTime: 'boostingSince',
      bool: 'mute',
      typeOf<Cacheable<Snowflake, Guild>>(): 'guild',
      typeOf<Iterable<Cacheable<Snowflake, Role>>>(): 'roles',
      typeOf<Cacheable<Snowflake, Role>>(): 'hoistedRole'
    },
    GuildBanAddEvent: {
      typeOf<Cacheable<Snowflake, Guild>>(): 'guild',
      User: 'user'
    },
    GuildBanRemoveEvent: {
      typeOf<Cacheable<Snowflake, Guild>>(): 'guild',
      User: 'user'
    },
    GuildEmojisUpdateEvent: {
      typeOf<List<GuildEmoji>>(): 'emojis',
      typeOf<Cacheable<Snowflake, Guild>>(): 'guild'
    },
    RoleCreateEvent: {
      Role: 'role',
      typeOf<Cacheable<Snowflake, Guild>>(): 'guild'
    },
    Role: {
      INyxx: 'client',
      typeOf<Cacheable<Snowflake, Guild>>(): 'guild',
      String: 'name',
      DiscordColor: 'color',
      int: 'position',
      bool: 'mentionable',
      Permissions: 'permissions',
      RoleTags: 'roleTags'
    },
    RoleTags: {Snowflake: 'integrationId', bool: 'nitroRole'},
    RoleDeleteEvent: {
      Role: 'role',
      Snowflake: 'roleId',
      typeOf<Cacheable<Snowflake, Guild>>(): 'guild'
    },
    RoleUpdateEvent: {
      Role: 'role',
      typeOf<Cacheable<Snowflake, Guild>>(): 'guild'
    },
    HttpErrorEvent: {HttpResponseError: 'response'},
    HttpResponseError: {String: 'errorMessage', int: 'errorCode'},
    HttpResponseEvent: {HttpResponseSuccess: 'response'},
    HttpResponseSuccess: {},
    InviteCreatedEvent: {Invite: 'invite'},
    Invite: {
      String: 'code',
      typeOf<Cacheable<Snowflake, Guild>>(): 'guild',
      typeOf<Cacheable<Snowflake, TextChannel>>(): 'channel',
      User: 'inviter',
      typeOf<Cacheable<Snowflake, User>>(): 'targetUser',
      INyxx: 'client'
    },
    InviteDeletedEvent: {
      typeOf<Cacheable<Snowflake, GuildChannel>>(): 'channel',
      typeOf<Cacheable<Snowflake, Guild>>(): 'guild',
      String: 'code'
    },
    MemberChunkEvent: {
      typeOf<Iterable<Member>>(): 'members',
      typeOf<Cacheable<Snowflake, Guild>>(): 'guild',
      int: 'shardId',
      typeOf<Iterable<Snowflake>>(): 'invalidIds',
      String: 'nonce'
    },
    MessageReceivedEvent: {Message: 'message'},
    Message: {
      INyxx: 'client',
      String: 'nonce',
      typeOf<CacheableTextChannel<TextChannel>>(): 'channel',
      DateTime: 'editedTimestamp',
      typeOf<List<Cacheable<Snowflake, User>>>(): 'mentions',
      typeOf<List<Embed>>(): 'embeds',
      typeOf<List<Attachment>>(): 'attachments',
      bool: 'mentionEveryone',
      typeOf<List<Reaction>>(): 'reactions',
      MessageType: 'type',
      MessageFlags: 'flags',
      typeOf<Iterable<PartialSticker>>(): 'partialStickers',
      ReferencedMessage: 'referencedMessage',
      typeOf<List<List<IMessageComponent>>>(): 'components',
      Snowflake: 'applicationId'
    },
    MessageType: {MessageType: 'guildInviteRemainder'},
    MessageFlags: {int: 'raw'},
    ReferencedMessage: {Message: 'message', bool: 'isDeleted'},
    MessageDeleteEvent: {
      Message: 'message',
      Snowflake: 'messageId',
      typeOf<CacheableTextChannel<TextChannel>>(): 'channel'
    },
    MessageDeleteBulkEvent: {
      typeOf<Iterable<Snowflake>>(): 'deletedMessagesIds',
      typeOf<CacheableTextChannel<TextChannel>>(): 'channel',
      typeOf<Cacheable<Snowflake, Guild>>(): 'guild'
    },
    MessageReactionEvent: {
      typeOf<Cacheable<Snowflake, User>>(): 'user',
      typeOf<CacheableTextChannel<TextChannel>>(): 'channel',
      typeOf<Cacheable<Snowflake, Guild>>(): 'guild',
      Message: 'message',
      Snowflake: 'messageId',
      Member: 'member',
      IEmoji: 'emoji'
    },
    IEmoji: {},
    MessageReactionAddedEvent: {},
    MessageReactionRemovedEvent: {},
    MessageReactionsRemovedEvent: {
      typeOf<CacheableTextChannel<TextChannel>>(): 'channel',
      typeOf<Cacheable<Snowflake, Message>>(): 'message',
      typeOf<Cacheable<Snowflake, Guild>>(): 'guild'
    },
    MessageReactionRemoveEmojiEvent: {
      typeOf<CacheableTextChannel<TextChannel>>(): 'channel',
      typeOf<Cacheable<Snowflake, Message>>(): 'message',
      typeOf<Cacheable<Snowflake, Guild>>(): 'guild',
      IEmoji: 'emoji'
    },
    MessageUpdateEvent: {
      Message: 'updatedMessage',
      typeOf<CacheableTextChannel<TextChannel>>(): 'channel',
      Snowflake: 'messageId'
    },
    PresenceUpdateEvent: {
      typeOf<Cacheable<Snowflake, User>>(): 'user',
      typeOf<Iterable<Activity>>(): 'presences',
      ClientStatus: 'clientStatus'
    },
    RawEvent: {Shard: 'shard', typeOf<Map<String, dynamic>>(): 'rawData'},
    ReadyEvent: {},
    ThreadCreateEvent: {ThreadChannel: 'thread'},
    ThreadChannel: {
      typeOf<Cacheable<Snowflake, Member>>(): 'owner',
      int: 'memberCount',
      bool: 'archived',
      DateTime: 'archiveAt',
      ThreadArchiveTime: 'archiveAfter',
      MessageCache: 'messageCache'
    },
    ThreadArchiveTime: {ThreadArchiveTime: 'week'},
    MessageCache: {},
    ThreadDeletedEvent: {
      typeOf<CacheableTextChannel<ThreadChannel>>(): 'thread',
      typeOf<CacheableTextChannel<TextGuildChannel>>(): 'parent',
      typeOf<Cacheable<Snowflake, Guild>>(): 'guild'
    },
    ThreadMembersUpdateEvent: {
      typeOf<CacheableTextChannel<ThreadChannel>>(): 'thread',
      typeOf<Cacheable<Snowflake, Guild>>(): 'guild',
      typeOf<Iterable<Cacheable<Snowflake, Member>>>(): 'addedMembers',
      int: 'approxMemberCount',
      typeOf<Iterable<Cacheable<Snowflake, User>>>(): 'removedUsers'
    },
    TypingEvent: {
      typeOf<CacheableTextChannel<TextChannel>>(): 'channel',
      typeOf<Cacheable<Snowflake, User>>(): 'user',
      Member: 'member',
      DateTime: 'timestamp',
      typeOf<Cacheable<Snowflake, Guild>>(): 'guild'
    },
    UserUpdateEvent: {User: 'user'},
    VoiceServerUpdateEvent: {
      typeOf<Map<String, dynamic>>(): 'raw',
      String: 'endpoint',
      typeOf<Cacheable<Snowflake, Guild>>(): 'guild'
    },
    VoiceStateUpdateEvent: {
      VoiceState: 'state',
      typeOf<Map<String, dynamic>>(): 'raw'
    },
    VoiceState: {
      typeOf<Cacheable<Snowflake, User>>(): 'user',
      String: 'sessionId',
      typeOf<Cacheable<Snowflake, Guild>>(): 'guild',
      typeOf<Cacheable<Snowflake, IChannel>>(): 'channel',
      bool: 'selfVideo',
      DateTime: 'requestToSpeakTimeStamp'
    }
  };

  static const Map<Type, Mirror> mirrors = {
    ChannelCreateEvent: Mirror<ChannelCreateEvent>(),
    IChannel: Mirror<IChannel>(),
    ChannelType: Mirror<ChannelType>(),
    INyxx: Mirror<INyxx>(),
    ChannelDeleteEvent: Mirror<ChannelDeleteEvent>(),
    ChannelPinsUpdateEvent: Mirror<ChannelPinsUpdateEvent>(),
    DateTime: Mirror<DateTime>(),
    int: Mirror<int>(),
    bool: Mirror<bool>(),
    ChannelUpdateEvent: Mirror<ChannelUpdateEvent>(),
    StageInstanceEvent: Mirror<StageInstanceEvent>(),
    StageChannelInstance: Mirror<StageChannelInstance>(),
    String: Mirror<String>(),
    StageChannelInstancePrivacyLevel:
        Mirror<StageChannelInstancePrivacyLevel>(),
    DisconnectEvent: Mirror<DisconnectEvent>(),
    Shard: Mirror<Shard>(),
    ShardManager: Mirror<ShardManager>(),
    DisconnectEventReason: Mirror<DisconnectEventReason>(),
    GuildCreateEvent: Mirror<GuildCreateEvent>(),
    Guild: Mirror<Guild>(),
    PremiumTier: Mirror<PremiumTier>(),
    Permissions: Mirror<Permissions>(),
    GuildNsfwLevel: Mirror<GuildNsfwLevel>(),
    GuildUpdateEvent: Mirror<GuildUpdateEvent>(),
    GuildDeleteEvent: Mirror<GuildDeleteEvent>(),
    GuildMemberRemoveEvent: Mirror<GuildMemberRemoveEvent>(),
    User: Mirror<User>(),
    ClientStatus: Mirror<ClientStatus>(),
    UserStatus: Mirror<UserStatus>(),
    Activity: Mirror<Activity>(),
    ActivityType: Mirror<ActivityType>(),
    ActivityTimestamps: Mirror<ActivityTimestamps>(),
    Snowflake: Mirror<Snowflake>(),
    ActivityEmoji: Mirror<ActivityEmoji>(),
    ActivityParty: Mirror<ActivityParty>(),
    GameAssets: Mirror<GameAssets>(),
    GameSecrets: Mirror<GameSecrets>(),
    ActivityFlags: Mirror<ActivityFlags>(),
    UserFlags: Mirror<UserFlags>(),
    NitroType: Mirror<NitroType>(),
    DiscordColor: Mirror<DiscordColor>(),
    GuildMemberUpdateEvent: Mirror<GuildMemberUpdateEvent>(),
    GuildMemberAddEvent: Mirror<GuildMemberAddEvent>(),
    Member: Mirror<Member>(),
    GuildBanAddEvent: Mirror<GuildBanAddEvent>(),
    GuildBanRemoveEvent: Mirror<GuildBanRemoveEvent>(),
    GuildEmojisUpdateEvent: Mirror<GuildEmojisUpdateEvent>(),
    RoleCreateEvent: Mirror<RoleCreateEvent>(),
    Role: Mirror<Role>(),
    RoleTags: Mirror<RoleTags>(),
    RoleDeleteEvent: Mirror<RoleDeleteEvent>(),
    RoleUpdateEvent: Mirror<RoleUpdateEvent>(),
    HttpErrorEvent: Mirror<HttpErrorEvent>(),
    HttpResponseError: Mirror<HttpResponseError>(),
    HttpResponseEvent: Mirror<HttpResponseEvent>(),
    HttpResponseSuccess: Mirror<HttpResponseSuccess>(),
    InviteCreatedEvent: Mirror<InviteCreatedEvent>(),
    Invite: Mirror<Invite>(),
    InviteDeletedEvent: Mirror<InviteDeletedEvent>(),
    MemberChunkEvent: Mirror<MemberChunkEvent>(),
    MessageReceivedEvent: Mirror<MessageReceivedEvent>(),
    Message: Mirror<Message>(),
    MessageType: Mirror<MessageType>(),
    MessageFlags: Mirror<MessageFlags>(),
    ReferencedMessage: Mirror<ReferencedMessage>(),
    MessageDeleteEvent: Mirror<MessageDeleteEvent>(),
    MessageDeleteBulkEvent: Mirror<MessageDeleteBulkEvent>(),
    MessageReactionEvent: Mirror<MessageReactionEvent>(),
    IEmoji: Mirror<IEmoji>(),
    MessageReactionAddedEvent: Mirror<MessageReactionAddedEvent>(),
    MessageReactionRemovedEvent: Mirror<MessageReactionRemovedEvent>(),
    MessageReactionsRemovedEvent: Mirror<MessageReactionsRemovedEvent>(),
    MessageReactionRemoveEmojiEvent: Mirror<MessageReactionRemoveEmojiEvent>(),
    MessageUpdateEvent: Mirror<MessageUpdateEvent>(),
    PresenceUpdateEvent: Mirror<PresenceUpdateEvent>(),
    RawEvent: Mirror<RawEvent>(),
    ReadyEvent: Mirror<ReadyEvent>(),
    ThreadCreateEvent: Mirror<ThreadCreateEvent>(),
    ThreadChannel: Mirror<ThreadChannel>(),
    ThreadArchiveTime: Mirror<ThreadArchiveTime>(),
    MessageCache: Mirror<MessageCache>(),
    ThreadDeletedEvent: Mirror<ThreadDeletedEvent>(),
    ThreadMembersUpdateEvent: Mirror<ThreadMembersUpdateEvent>(),
    TypingEvent: Mirror<TypingEvent>(),
    UserUpdateEvent: Mirror<UserUpdateEvent>(),
    VoiceServerUpdateEvent: Mirror<VoiceServerUpdateEvent>(),
    VoiceStateUpdateEvent: Mirror<VoiceStateUpdateEvent>(),
    VoiceState: Mirror<VoiceState>()
  };
}
