import 'package:frontend/blocs/navigation/navigation_bloc.dart';
import 'package:frontend/blocs/navigation/navigation_event.dart';
import 'package:frontend/blocs/notification/notification_bloc.dart';
import 'package:frontend/blocs/notification/notification_event.dart';
import 'package:frontend/blocs/user/user_event.dart';
import 'package:frontend/blocs/user/user_state.dart';
import 'package:frontend/data/user.data.dart';

import 'package:frontend/infrastructure/infrastructure.dart';
import 'package:frontend/models/models.dart';
// import 'package:frontend/repositories/repositories.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UserBloc extends Bloc<UserEvent, UserState> {
  final NavigationBloc _navigation;
  // final UserRepository _userRepository;
  final NotificationBloc _notification;

  UserBloc(
    this._navigation,
    this._notification,
    // this._userRepository,
  ) : super(const UserState()) {
    on(_onInitial);
    on(_onEat);
    on(_onHistoryDelete);
    // on(_onSignInWithGoogle);
    // on(_onCreateUser);
    // on(_onUpdateUser);
    // on(_onDeleteUser);
    // on(_onLogout);
  }

  Future<void> _onInitial(UEInitial event, Emitter<UserState> emit) async {
    // if not logged in
    // if (!_auth.isLoggedIn) {
    //   // then navigate to title
    //   _navigateToTitle(emit);
    //   return;
    // }

    var user = ME;

    // if user does not exist
    // if (user == null) {
    //   // then navigate to create profile
    //   _navigateToCreateProfile(emit);
    //   return;
    // }

    // fcm token check
    // final fcm = (await _fcm.instance.getToken())!;
    // if (user.fcm != fcm) {
    //   user = await _userRepository.update(
    //     user.uid,
    //     UserUpdateInput(fcm: fcm),
    //   );
    // }

    // else navigate to home
    _navigateToHome(user, emit);
  }

  void _onEat(UEEat event, Emitter<UserState> emit) {
    var history = [...state.history];

    history.add(event.recpie);

    emit(state.copyWith(history: history));

    _notification.add(const NotificationEvent.show(type: NotificationType.SUCCESS, message: 'Omm nom nom'));
  }

  void _onHistoryDelete(UEHDelete event, Emitter<UserState> emit) {
    var history = [...state.history];

    history.removeAt(event.index);

    emit(state.copyWith(history: history));

    _notification
        .add(const NotificationEvent.show(type: NotificationType.SUCCESS, message: 'Item removed from history'));
  }

  // Future<void> _onSignInWithGoogle(UESignInWithGoogle event, Emitter<UserState> emit) async {
  //   await _auth.signInWithGoogle();

  //   final user = await _userRepository.findOne(_auth.uid);

  //   // if user does not exist
  //   if (user == null) {
  //     // then navigate to create profile
  //     _navigateToCreateProfile(emit);
  //     return;
  //   }

  //   // else navigate to home
  //   _navigateToHome(user, emit);
  // }

  // Future<void> _onCreateUser(UECreate event, Emitter<UserState> emit) async {
  //   final user = await _userRepository.create(UserCreateInput(
  //     dp: event.dp,
  //     uid: _auth.uid,
  //     fcm: (await _fcm.instance.getToken())!,
  //     name: event.name,
  //   ));

  //   _navigateToHome(user, emit);
  // }

  // Future<void> _onUpdateUser(UEUpdate event, Emitter<UserState> emit) async {
  //   final user = await _userRepository.update(
  //     state.uid,
  //     UserUpdateInput(
  //       dp: event.dp,
  //       name: event.name,
  //     ),
  //   );

  //   _navigation.add(const NavigationEvent.navigateTo(
  //     type: NavigationType.POP,
  //   ));

  //   emit(state.copyWith(
  //     id: user.id,
  //     dp: user.dp,
  //     uid: user.uid,
  //     fcm: user.fcm,
  //     name: user.name,
  //   ));

  //   _notification
  //       .add(const NotificationEvent.show(type: NotificationType.SUCCESS, message: 'Booper profile updated :)'));
  // }

  // Future<void> _onLogout(UELogout event, Emitter<UserState> emit) async {
  //   await _auth.logout();

  //   _navigateToTitle(emit);
  // }

  // Future<void> _onDeleteUser(UEDelete event, Emitter<UserState> emit) async {
  //   await _userRepository.remove(state.uid);

  //   await _auth.remove();

  //   _navigateToTitle(emit);

  //   _notification
  //       .add(const NotificationEvent.show(type: NotificationType.SUCCESS, message: 'Booper account deleted :('));
  // }

  void _navigateToHome(User user, Emitter<UserState> emit) {
    _navigation.add(const NavigationEvent.navigateTo(
      route: 'home',
      type: NavigationType.PUSH_EMPTY,
    ));

    emit(state.copyWith(
      uid: user.uid,
      name: user.name,
    ));
  }

  // @override
  // UserState? fromJson(Map<String, dynamic> json) {
  //   return UserState.fromJson(json);
  // }

  // @override
  // Map<String, dynamic>? toJson(UserState state) {
  //   throw state.toJson();
  // }

  // void _navigateToCreateProfile(Emitter<UserState> emit) {
  //   _navigation.add(const NavigationEvent.navigateTo(
  //     route: 'profile',
  //     type: NavigationType.PUSH_EMPTY,
  //     args: ProfileScreenArguments(mode: ProfileScreenMode.CREATE),
  //   ));

  //   emit(UserState(uid: _auth.uid));
  // }

  // void _navigateToTitle(Emitter<UserState> emit) {
  //   _navigation.add(const NavigationEvent.navigateTo(
  //     route: 'title',
  //     type: NavigationType.PUSH_EMPTY,
  //   ));

  //   emit(const UserState());
  // }
}
