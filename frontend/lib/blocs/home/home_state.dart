import 'package:frontend/infrastructure/infrastructure.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  factory HomeState({
    @Default(0) int view,
    // @Default(WebSocketState.DISCONNECTED) WebSocketState socketState,
  }) = _HomeState;
}
