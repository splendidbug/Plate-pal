import 'package:frontend/infrastructure/infrastructure.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_event.freezed.dart';

@freezed
class HomeEvent with _$HomeEvent {
  const factory HomeEvent.reconnect() = HEReconnect;
  const factory HomeEvent.navigateTo({required int view}) = HENavigateTo;
  // const factory HomeEvent.socketStateChange({required WebSocketState state}) = HESocketStateChange;
}
