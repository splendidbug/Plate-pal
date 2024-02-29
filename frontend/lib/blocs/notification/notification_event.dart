import 'package:frontend/models/models.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_event.freezed.dart';

@freezed
class NotificationEvent with _$NotificationEvent {
  const factory NotificationEvent.show({
    required NotificationType type,
    required String message,
  }) = NTShow;
}
