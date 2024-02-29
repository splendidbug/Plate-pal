import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'notification_event.dart';
import 'notification_state.dart';

@singleton
class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationState()) {
    on(_onNotificationEvent);
  }

  void _onNotificationEvent(NTShow event, Emitter<NotificationState> emit) {
    emit(state.copyWith(
      id: state.id + 1,
      type: event.type,
      message: event.message,
    ));
  }
}
