import 'navigation_event.dart';
import 'navigation_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@singleton
class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationState()) {
    on(_onNavigateTo);
  }

  void _onNavigateTo(NVENavigateTo event, Emitter<NavigationState> emit) {
    emit(state.copyWith(
      route: event.route,
      type: event.type,
      args: event.args,
    ));
  }
}
