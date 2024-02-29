import 'package:freezed_annotation/freezed_annotation.dart';

part 'inventory_event.freezed.dart';

@freezed
class InventoryEvent with _$InventoryEvent {
  const factory InventoryEvent.scan() = IEScan;
  const factory InventoryEvent.clear() = IEClear;
  const factory InventoryEvent.delete({required int index}) = IEDelete;
}
