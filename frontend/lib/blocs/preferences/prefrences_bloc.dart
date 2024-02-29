import 'package:frontend/blocs/preferences/prefrences_event.dart';
import 'package:frontend/blocs/preferences/prefrences_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../models/models.dart';
import '../navigation/navigation_bloc.dart';
import '../navigation/navigation_event.dart';
import '../notification/notification_bloc.dart';
import '../notification/notification_event.dart';

@lazySingleton
class PrefrencesBloc extends HydratedBloc<PrefrencesEvent, PrefrencesState> {
  final NavigationBloc _navigation;
  final NotificationBloc _notification;

  PrefrencesBloc(
    this._navigation,
    this._notification,
  ) : super(const PrefrencesState()) {
    on(_onUpdate);
  }

  void _onUpdate(PEUpdate event, Emitter<PrefrencesState> emit) {
    _navigation.add(const NavigationEvent.navigateTo(
      type: NavigationType.POP,
    ));

    emit(event.prefrences);

    _notification.add(const NotificationEvent.show(type: NotificationType.SUCCESS, message: 'Prefrences updated :)'));
  }

  @override
  PrefrencesState? fromJson(Map<String, dynamic> json) {
    return PrefrencesState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(PrefrencesState state) {
    return state.toJson();
  }
}
