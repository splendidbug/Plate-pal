import 'package:freezed_annotation/freezed_annotation.dart';

part 'prefrences_state.g.dart';
part 'prefrences_state.freezed.dart';

@freezed
class PrefrencesState with _$PrefrencesState {
  const factory PrefrencesState({
    @Default('') String cuisines,
    @Default('') String cost,
    @Default('') String carbs,
    @Default('') String fats,
    @Default('') String proteins,
    @Default('') String calories,
  }) = _PrefrencesState;

  factory PrefrencesState.fromJson(Map<String, Object?> json) => _$PrefrencesStateFromJson(json);
}
