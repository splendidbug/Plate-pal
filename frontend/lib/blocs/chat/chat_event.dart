import 'package:frontend/models/models.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_event.freezed.dart';

@freezed
class ChatEvent with _$ChatEvent {
  const factory ChatEvent.close() = CEClose;
  const factory ChatEvent.open(ChatScreenArguments args) = CEOpen;
  const factory ChatEvent.send({required String message}) = CESend;
}
