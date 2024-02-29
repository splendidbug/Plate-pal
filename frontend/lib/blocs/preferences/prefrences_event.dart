import 'package:freezed_annotation/freezed_annotation.dart';

import 'prefrences_state.dart';

part 'prefrences_event.freezed.dart';

@freezed
class PrefrencesEvent with _$PrefrencesEvent {
  const factory PrefrencesEvent.update(PrefrencesState prefrences) = PEUpdate;
}
