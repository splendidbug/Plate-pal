import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:frontend/models/models.dart';

part 'recpie_state.freezed.dart';
part 'recpie_state.g.dart';

@freezed
class RecpieState with _$RecpieState {
  const factory RecpieState({
    @Default([]) List<Recpie> recpies,
  }) = _RecpieState;

  factory RecpieState.fromJson(Map<String, Object?> json) => _$RecpieStateFromJson(json);
}
