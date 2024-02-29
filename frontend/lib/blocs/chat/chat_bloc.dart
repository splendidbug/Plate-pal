import 'package:frontend/blocs/inventory/inventory_bloc.dart';
import 'package:frontend/common/common.dart';
import 'package:frontend/models/models.dart';
import 'package:frontend/repositories/chat/chat_dtos.dart';
import 'package:frontend/repositories/repositories.dart';
import 'package:frontend/services/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../repositories/chat/chat_repository.dart';
import '../navigation/navigation_bloc.dart';
import '../navigation/navigation_event.dart';
import '../preferences/prefrences_bloc.dart';
import '../user/user_bloc.dart';

import 'chat_event.dart';
import 'chat_state.dart';

@lazySingleton
class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository _chatRepository;
  final NavigationBloc _navigation;
  final UserBloc _userBloc;
  final InventoryBloc _inventoryBloc;
  final PrefrencesBloc _prefrencesBloc;

  ChatBloc(
    this._chatRepository,
    this._navigation,
    this._userBloc,
    this._inventoryBloc,
    this._prefrencesBloc,
  ) : super(const ChatState()) {
    on(_onOpen);
    on(_onSend);
    on(_onClose);
  }

  Future<void> _onOpen(CEOpen event, Emitter<ChatState> emit) async {
    _navigation.add(
      NavigationEvent.navigateTo(
        route: 'chat',
        type: NavigationType.PUSH,
        args: event.args,
      ),
    );

    String message = '';

    if (event.args.recpie != 'GENERAL') {
      message = await _chatRepository.initial(ChatStart(title: event.args.recpie));

      message = message.replaceAll('"', '');
      message = message.replaceAll('\\n', '\n');
    }

    emit(state.copyWith(current: event.args, chats: message.isEmpty ? [] : [Chat(isUser: false, message: message)]));
  }

  void _onClose(CEClose event, Emitter<ChatState> emit) async {
    _navigation.add(const NavigationEvent.navigateTo(
      type: NavigationType.POP,
    ));

    emit(state.copyWith(
      current: const ChatScreenArguments.initial(),
      chats: [],
    ));
  }

  Future<void> _onSend(CESend event, Emitter<ChatState> emit) async {
    List<Chat> chats = [];
    var response = state.current.recpie == "GENERAL"
        ? await _chatRepository.chat(
            ChatInput(
              current_recipe: state.current.recpie,
              input_string: event.message,
              inventory: _inventoryBloc.state.items,
              recipe_history: _userBloc.state.history,
              calorie: _prefrencesBloc.state.calories,
            ),
          )
        : await _chatRepository.chat(
            ChatInput(
              current_recipe: state.current.recpie,
              input_string: event.message,
              inventory: [],
              recipe_history: [],
              calorie: "0",
            ),
          );

    chats.add(Chat(
      message: response.result,
      isUser: false,
    ));

    chats.add(Chat(
      message: event.message,
      isUser: true,
    ));

    chats.addAll(state.chats);

    emit(state.copyWith(chats: chats));
  }
}
