import 'package:frontend/models/models.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'navigation_event.freezed.dart';

@freezed
class NavigationEvent with _$NavigationEvent {
  const factory NavigationEvent.navigateTo({
    @Default('') String route,
    @Default(NavigationType.PUSH) NavigationType type,
    Object? args,
  }) = NVENavigateTo;
}
