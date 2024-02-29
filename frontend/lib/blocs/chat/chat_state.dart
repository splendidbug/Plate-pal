import 'dart:async';

import 'package:frontend/models/models.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_state.freezed.dart';

@freezed
class ChatState with _$ChatState {
  const factory ChatState({
    @Default([]) List<Chat> chats,
    @Default(ChatScreenArguments.initial()) ChatScreenArguments current,
  }) = _ChatState;
}
