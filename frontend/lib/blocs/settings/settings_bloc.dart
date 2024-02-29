import 'package:frontend/models/models.dart';
// import 'package:frontend/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../notification/notification_bloc.dart';
import '../notification/notification_event.dart';

import 'settings_state.dart';
import 'settings_event.dart';

@lazySingleton
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final NotificationBloc _notificationBloc;
  // final HealthRepository _healthRepository;

  SettingsBloc(
    this._notificationBloc,
    // this._healthRepository,
  ) : super(SettingsState()) {
    on(_onInitial);
    on(_onChangeTheme);
    // on(_onHealthCheck);
  }

  void _onInitial(STInitial event, Emitter<SettingsState> emit) async {
    // try {
    //   final response = await _healthRepository.health();

    //   emit(state.copyWith(apiVersion: response.version));
    // } catch (error) {
    //   emit(state.copyWith(apiVersion: 'ERROR'));
    // }
  }

  void _onChangeTheme(STChangeTheme event, Emitter<SettingsState> emit) {
    emit(state.copyWith(themeMode: event.themeMode));
  }

  // void _onHealthCheck(STHealthCheck event, Emitter<SettingsState> emit) async {
  //   try {
  //     final response = await _healthRepository.health();

  //     if (response.status == 'ok') {
  //       _notificationBloc.add(
  //         const NotificationEvent.show(type: NotificationType.SUCCESS, message: 'Booper is healthy :)'),
  //       );

  //       emit(state.copyWith(apiVersion: response.version));
  //     } else {
  //       _notificationBloc.add(
  //         const NotificationEvent.show(type: NotificationType.ERROR, message: 'Booper is sick :('),
  //       );

  //       emit(state.copyWith(apiVersion: 'ERROR'));
  //     }
  //   } catch (error) {
  //     _notificationBloc.add(
  //       const NotificationEvent.show(type: NotificationType.ERROR, message: 'Booper 404!! =('),
  //     );

  //     emit(state.copyWith(apiVersion: 'ERROR'));
  //   }
  // }
}
