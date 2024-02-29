import 'package:frontend/models/models.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_state.freezed.dart';

@freezed
class NotificationState with _$NotificationState {
  factory NotificationState({
    @Default(0) int id,
    @Default('') String message,
    @Default(NotificationType.DEFAULT) NotificationType type,
  }) = _NotificationState;
}
