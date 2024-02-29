import 'package:frontend/blocs/blocs.dart';
import 'package:frontend/blocs/inventory/inventory_event.dart';
import 'package:frontend/blocs/recpie/recpie_bloc.dart';
import 'package:frontend/blocs/recpie/recpie_event.dart';
import 'package:frontend/services/services.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../models/bloc/notification.dart';

@lazySingleton
class InventoryBloc extends HydratedBloc<InventoryEvent, InventoryState> {
  final ImageService _service;
  final NotificationBloc _notification;

  InventoryBloc(
    this._service,
    this._notification,
  ) : super(const InventoryState()) {
    on(_onScan);
    on(_onClear);
    on(_onDelete);
  }

  Future<void> _onScan(IEScan event, Emitter<InventoryState> emit) async {
    final result = await _service.scan();

    var current = [...state.items];

    for (var r in result) {
      if (!current.contains(r)) current.add(r);
    }

    emit(state.copyWith(items: current));

    _notification.add(const NotificationEvent.show(type: NotificationType.SUCCESS, message: 'Ingredients added'));
  }

  void _onDelete(IEDelete event, Emitter<InventoryState> emit) {
    var items = [...state.items];

    items.removeAt(event.index);

    emit(state.copyWith(items: items));

    _notification.add(const NotificationEvent.show(type: NotificationType.SUCCESS, message: 'Ingredient removed'));
  }

  void _onClear(IEClear event, Emitter<InventoryState> emit) {
    emit(state.copyWith(items: []));

    _notification.add(const NotificationEvent.show(type: NotificationType.SUCCESS, message: 'Ingredients cleared'));
  }

  @override
  InventoryState? fromJson(Map<String, dynamic> json) {
    return InventoryState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(InventoryState state) {
    return state.toJson();
  }
}
