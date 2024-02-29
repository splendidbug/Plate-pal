import 'package:frontend/models/models.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat.g.dart';
part 'chat.freezed.dart';

@freezed
class Chat with _$Chat {
  factory Chat({
    required String message,
    required bool isUser,
  }) = _Chat;

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);
}
