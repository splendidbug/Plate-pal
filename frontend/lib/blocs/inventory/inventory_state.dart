import 'package:freezed_annotation/freezed_annotation.dart';

part 'inventory_state.freezed.dart';
part 'inventory_state.g.dart';

@freezed
class InventoryState with _$InventoryState {
  const factory InventoryState({
    @Default([]) List<String> items,
  }) = _InventoryState;

  factory InventoryState.fromJson(Map<String, Object?> json) => _$InventoryStateFromJson(json);
}
