import 'package:frontend/blocs/inventory/inventory_bloc.dart';
import 'package:frontend/blocs/recpie/recpie_event.dart';
import 'package:frontend/blocs/recpie/recpie_state.dart';
import 'package:frontend/models/api/recpie.dart';
import 'package:frontend/services/recpie_service.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class RecpieBloc extends HydratedBloc<RecpieEvent, RecpieState> {
  final InventoryBloc _inventoryBloc;
  final RecpieService _recpieService;

  RecpieBloc(
    this._recpieService,
    this._inventoryBloc,
  ) : super(const RecpieState()) {
    on(_onLoad);

    _inventoryBloc.stream.listen((_) {
      add(const RELoad());
    });
  }

  Future<void> _onLoad(RELoad event, Emitter<RecpieState> emit) async {
    final result = await _recpieService.loadApi(_inventoryBloc.state.items);
    emit(
      state.copyWith(
        recpies: result,
      ),
    );
  }

  @override
  RecpieState? fromJson(Map<String, dynamic> json) {
    return RecpieState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(RecpieState state) {
    return state.toJson();
  }
}
