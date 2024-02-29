import 'package:frontend/models/models.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'navigation_state.freezed.dart';

@freezed
class NavigationState with _$NavigationState {
  factory NavigationState({
    @Default('') String route,
    @Default(NavigationType.PUSH) NavigationType type,
    Object? args,
  }) = _NavigationState;
}
