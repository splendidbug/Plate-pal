import 'package:frontend/infrastructure/infrastructure.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'home_event.dart';
import 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  // final WebSocketClient _socket;

  HomeBloc(
      // this._socket,
      )
      : super(HomeState()) {
    // on(_onReconnect);
    on(_onHomeNavigateTo);
    // on(_onChatStateChange);

    // _socket.state.listen((state) => add(HomeEvent.socketStateChange(state: state)));
  }

  void _onHomeNavigateTo(HENavigateTo event, Emitter<HomeState> emit) {
    emit(state.copyWith(view: event.view));
  }

  // void _onChatStateChange(HESocketStateChange event, Emitter<HomeState> emit) {
  //   emit(state.copyWith(socketState: event.state));
  // }

  // Future<void> _onReconnect(HEReconnect event, Emitter<HomeState> emit) async {
  //   if (state.socketState == WebSocketState.DISCONNECTED) await _socket.connect();

  //   emit(state.copyWith(socketState: WebSocketState.CONNECTED));
  // }
}
