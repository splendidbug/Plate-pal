import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recpie_event.freezed.dart';

@freezed
class RecpieEvent with _$RecpieEvent {
  const factory RecpieEvent.load() = RELoad;
}
